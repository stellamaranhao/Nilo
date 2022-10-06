//
//  ReplicateAPI.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 04/10/22.
//

import Foundation
import Network
import UIKit

class ReplicateAPI {
    
    private var authToken:String  // cria var para receber o token
    var authTokenValid:Bool = false // cria var que define se o token e valido
    
    init (authToken: String) {  // init para token com valor
        self.authToken = authToken
    }
    
    init (){ // init para receber valor do token no Replicate
        // TODO: Implementar metodo de carregamento por persistencia
        self.authToken = ""
    }
    
    // Enum e var que recebem o valor da ID e manda pra func createPrediction()
    enum nomesId : CustomStringConvertible {
        case Primeiro
        
        var description : String {
            switch self {
            case .Primeiro: return "9283608cc6b7be6b65a8e44983db012355fde4132009bf99d976b2f0896856a3"
            }
        }
    }
    let recebeID = nomesId.Primeiro
    
    
    func validateToken (sucessCallback:@escaping()->Void,errorCallback:@escaping()->Void){
        //cria var url que recebe endereço da api
        let url  = URL(string: "https://api.replicate.com/v1/models/replicate/hello-world")
        // cria guard let que verifica se a url é valida, caso nao seja cai em fatalError()
        guard let requestURL = url else {fatalError()} // var que a url valida fica armazenada
        
        //Prerate URL request object
        // Faz um request da var de url validada do tipo GET
        var request = URLRequest(url:requestURL)
        request.httpMethod = "GET"
        
        //Prepare Header
        // associa as infos -H nome + valor
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        // Faz o Request:
        //Perform the HTTP Request
        let task = URLSession.shared.dataTask(with:request){ (data, response, error) in
            guard let data = data else {
                print("Handle no response failure \(String(describing: error))")
                errorCallback()
                return
            }
            
            guard error == nil else{
                print("Handle Network Error")
                errorCallback()
                return
            }
            do{ // Caso o request seja bem sucedido entra
                //Sucesso !!!
                let decoder = JSONDecoder()  // decodifica para o jason
                let objResponse = try decoder.decode(ReplicateAPIGetModelResponse.self, from: data)
                
                if (objResponse.name != nil){
                    self.authTokenValid = true
                    sucessCallback()
                }else{
                    errorCallback()
                    self.authTokenValid = false
                }
            }catch{
                errorCallback()
                print("Json Parse Error \(error)")
                return
            }
            
        }
        task.resume()
    }
    
    func createPrediction(image: UIImage,sucessCallback:@escaping()->Void,errorCallback:@escaping()->Void) {
        
        let url = URL(string: "https://api.replicate.com/v1/predictions")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Requst Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
         
        //---------------------------------------------------------------------------------------
        
        // Dict dos dados de inpput - ID + dados da foto
        let json: [String: Any] = [
            "version": recebeID,
            "input": ["img":image.dataURL()!,
                      "version":"v1.3",
                      "scale":"2"]
            ]
        
       //---------------------------------------------------------------------------------------
        
        // Traduz para json
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData!
        

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("handle no response failure \(error.debugDescription)")
                errorCallback()
                return
            }
            print("data: \(String(describing: String(bytes: data, encoding: .utf8)))")
            guard error == nil else {
                // handle network error
                print("handle network error \(error.debugDescription)")
                errorCallback()
                return
            }
            do {
                print("Deu tudo certo com o modelo")
                sucessCallback()
            } catch {
                // handle json decoding error
                errorCallback()
                print("handle json decoding error \(error)")
            }
        }
        task.resume()
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
