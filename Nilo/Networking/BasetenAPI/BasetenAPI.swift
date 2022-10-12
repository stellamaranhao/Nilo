//
//  BasetenAPI.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 11/10/22.
//

import Foundation

final class BasetenAPI{
    var authToken:String
    var authTokenValid:Bool = false
    
    
    init (fromToken authToken: String) {
        self.authToken = authToken
    }
    
    init(){
        self.authToken = "vjbG7ScV.Ej9addGGST88VD7vhGO2fbCW7sry5n1u"
    }
    
    
    func createPrediction(using data:BasetenAPIInput, onCompletion completionCallback:@escaping()->Void){
        let url = URL(string: "https://app.baseten.co/model_versions/\(data.using!)/predict")
        
        guard let requestURL = url else {fatalError()}
        
        
        print(requestURL)
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        
        // Set HTTP Requst Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Api-Key \(self.authToken)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = data.httpBody
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("handle no response failure \(error.debugDescription)")
                //completionCallback(.failure(.networkError))
                return
            }
            
            print("data: \(String(describing: String(bytes: data, encoding: .utf8)))")
            
            guard error == nil else {
                // handle network error
                print("handle network error \(error.debugDescription)")
                //completionCallback(.failure(.noInternet))
                return
            }
            do {
                
                print("Sucess: \(String(describing: String(bytes: data, encoding: .utf8)))")
                print("DONE !")
                //                let decoder = JSONDecoder()
                //                let objResponse = try decoder.decode(ReplicateAPIMakePredictionResponse.self, from: data)
                //
                //                let output = ReplicateAPIPredictionInfo(from: objResponse)
                //                self.buffer.append(output)
                //                self.saveBuffer()
                //                completionCallback(.success(output))
                
            } catch {
                // completionCallback(.failure(.responseParsingError(response: data.description)))
                print("Json Parse Error \(error)")
                return
            }
            
        }
        task.resume()
    }
    
    
}



