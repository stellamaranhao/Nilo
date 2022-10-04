//
//  ReplicateAPI.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 04/10/22.
//

import Foundation

class ReplicateAPI {
    
    private var authToken:String
    var authTokenValid:Bool = false
    
    init (authToken: String) {
        self.authToken = authToken
    }
    
    init (){
        // TODO: Implementar metodo de carregamento por persistencia
        self.authToken = ""
    }
    
    func validateToken (sucessCallback:@escaping()->Void,errorCallback:@escaping()->Void){
        let url  = URL(string: "https://api.replicate.com/v1/models/replicate/hello-world")
        guard let requestURL = url else {fatalError()}
        
        //Prerate URL request object
        var request = URLRequest(url:requestURL)
        request.httpMethod = "GET"
        
        //Prepare Header
        request.setValue("Token \(self.authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //Perform the HTTP Request
        let task = URLSession.shared.dataTask(with:request){ (data, response, error) in
            guard let data = data else {
                print("Handle no response failure \(error)")
                errorCallback()
                return
            }
            
            guard error == nil else{
                print("Handle Network Error")
                errorCallback()
                return
            }
            
            do{
                //Sucesso !!!
                let decoder = JSONDecoder()
                let objResponse = try
                decoder.decode(ReplicateAPIGetModelResponse.self, from: data)
                
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
    
    
    
}
