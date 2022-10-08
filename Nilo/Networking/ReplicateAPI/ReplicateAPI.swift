//
//  ReplicateAPI.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 04/10/22.
//

import Foundation
import Network
import UIKit

final class ReplicateAPI {
    
    var authToken:String
    var authTokenValid:Bool = false
    
    var buffer:ReplicateAPIBuffer
    
    
    init (fromToken authToken: String) {
        self.authToken = authToken
        
        
        
        do{
            buffer = try ReplicateAPIBuffer.load(from: ReplicateAPIBuffer.tokenToSHA(authToken))
        }catch{
            buffer = ReplicateAPIBuffer(fromToken: authToken)
        }
        
    }
    
    init (){ // init para receber valor do token no Replicate
        // TODO: Implementar metodo de carregamento por persistencia
        self.authToken = ""
        do{
            buffer = try ReplicateAPIBuffer.load(from: authToken)
        }catch{
            buffer = ReplicateAPIBuffer(fromToken: authToken)
        }
        
    }
    
    deinit {
        saveBuffer()
    }
    
    /// Validate class token
    /// - Parameter completionCallback: CompletionCallback
    func validateToken (onCompletion completionCallback:@escaping(Result<Void,ReplicateError>)->Void){
        
        let url  = URL(string: "https://api.replicate.com/v1/models/replicate/hello-world")
        guard let requestURL = url else {fatalError()}
        
        var request = URLRequest(url:requestURL)
        request.httpMethod = "GET"
        
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with:request){ (data, response, error) in
            guard let data = data else {
                print("No response failure \(String(describing: error))")
                completionCallback(.failure(.networkError))
                return
            }
            
            guard error == nil else{
                print("Handle Network Error")
                completionCallback(.failure(.noInternet))
                return
            }
            do{
                let decoder = JSONDecoder()
                let objResponse = try decoder.decode(ReplicateAPIGetModelResponse.self, from: data)
                
                if (objResponse.name != nil){
                    self.authTokenValid = true
                    completionCallback(.success(()))
                }else{
                    completionCallback(.failure(.invalidToken))
                    self.authTokenValid = false
                }
            }catch{
                completionCallback(.failure(.responseParsingError(response: data.description)))
                print("Json Parse Error \(error)")
                return
            }
            let userDefaults = UserDefaults.standard
            userDefaults.string(forKey: self.authToken)
            
        }
        task.resume()
    }
    
    func createPrediction(using model:ReplicateAPIInput,onCompletion completionCallback:@escaping(Result<ReplicateAPIPredictionInfo,ReplicateError>)->Void) {
        guard let requestUrl = Constants.url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Requst Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
        
        guard let httpBody = model.httpBody else{
            completionCallback(.failure(.unexpected(message: "[createPrediction] No body in input")))
            return
        }
        
        request.httpBody = httpBody
        
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("handle no response failure \(error.debugDescription)")
                completionCallback(.failure(.networkError))
                return
            }
            
            //print("data: \(String(describing: String(bytes: data, encoding: .utf8)))"
            guard error == nil else {
                // handle network error
                print("handle network error \(error.debugDescription)")
                completionCallback(.failure(.noInternet))
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let objResponse = try decoder.decode(ReplicateAPIMakePredictionResponse.self, from: data)
                
                let output = ReplicateAPIPredictionInfo(from: objResponse)
                self.buffer.append(output)
                self.saveBuffer()
                completionCallback(.success(output))
                
            } catch {
                completionCallback(.failure(.responseParsingError(response: data.description)))
                print("Json Parse Error \(error)")
                return
            }
        }
        task.resume()
    }
    
    func getImagePrediction(fromId id:String, onCompletion completionCallback:@escaping(Result<UIImage?,ReplicateError>)->Void){
        let url = URL(string: "https://api.replicate.com/v1/predictions/\(id)")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Requst Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("handle no response failure \(error.debugDescription)")
                return
            }
            
            //print("data: \(String(describing: String(bytes: data, encoding: .utf8)))")
            guard error == nil else {
                // handle network error
                print("handle network error \(error.debugDescription)")
                return
            }
            do {
                // decode json data
                let decoder = JSONDecoder()
                let object = try decoder.decode(ReplicateAPIMakePredictionResponse.self, from: data)
                
                
                guard let predictionOutput = object.output else{
                    return
                }
                
                

                DispatchQueue.global().async {
                        // Fetch Image Data
                    if let data = try? Data(contentsOf: URL(string: (predictionOutput))!) {
                            DispatchQueue.main.async {
                                self.buffer.append(ReplicateAPIPredictionInfo.init(from: object))
                                self.saveBuffer()
                                completionCallback(.success(UIImage(data: data)))
                            }
                        }
                    }
//
                //completionCallback(.success(object.urls?.urlsGet))
                
                
            } catch {
                // handle json decoding error
                print("handle json decoding error \(error)")
            }
        }
        task.resume()
        
    }
    
    func getImagePrediction(onCompletion completionCallback:@escaping(Result<UIImage?,ReplicateError>)->Void){
        guard let last = buffer.getLast() else{
            completionCallback(.failure(.unexpected(message: "Empty buffer")))
            return
        }
        
        let url = URL(string: "https://api.replicate.com/v1/predictions/\(last.id)")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Requst Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("handle no response failure \(error.debugDescription)")
                completionCallback(.failure(.networkError))
                return
            }
            
            //print("data: \(String(describing: String(bytes: data, encoding: .utf8)))")
            guard error == nil else {
                // handle network error
                print("handle network error \(error.debugDescription)")
                return
            }
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(ReplicateAPIMakePredictionResponse.self, from: data)
                
                
                guard let predictionOutput = object.output else{
                    return
                }
                
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: URL(string: (predictionOutput))!) {
                            DispatchQueue.main.async {
                                let infoObj = ReplicateAPIPredictionInfo.init(from: object)
                                infoObj.presented.toggle()
                                self.buffer.append(infoObj)
                                self.saveBuffer()
                                completionCallback(.success(UIImage(data: data)))
                            }
                        }
                    }
                
            } catch {
                completionCallback(.failure(.responseParsingError(response: data.description)))
                print("Json Parse Error \(error)")
            }
        }
        task.resume()
        
    }
    
}

extension ReplicateAPI{
    struct Constants{
        static let url = URL(string: "https://api.replicate.com/v1/predictions")
    }
}

extension ReplicateAPI{
    func saveBuffer(){
        do{
            if !buffer.buffer.isEmpty{
                try buffer.save(in:buffer.name)
            }
        }catch{
            print("Erro saving ReplicateAPIbuffer")
        }
    }
}





final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global() // fica checando a conexao
    private let monitor : NWPathMonitor
    
    @Published public private (set) var isConnected : Bool = false
    
    private init () {
        monitor = NWPathMonitor ()
    }
    public func startMonitoring () {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[ weak self ] path in
            DispatchQueue.main.async {
                if (path.status == .satisfied) {
                    self?.isConnected = true
                } else {
                    self?.isConnected = false
                }
            }
        }
    }
    public func stopMonitoring () {
        monitor.cancel()
    }
    
}
