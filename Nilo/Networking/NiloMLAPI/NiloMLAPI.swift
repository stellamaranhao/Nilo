//
//  NiloMLAPI.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import Foundation


class NiloMLAPI{
    private let deviceUniqueID:String = UIDevice.current.identifierForVendor!.uuidString
    private var serverList:[String] = ["https://niloml9d1a9711.loca.lt"]
    private var onLineServerList:[String] = []
    
    init() {
        Task{
            await upDateOnlineServerList()
        }
    }
    
    
    func createDeepFake(fromImage image:UIImage) async throws->TemporaryMediaFile{
        //Check avaliable servers
        let onlineServerCount = await upDateOnlineServerList()
        if(onlineServerCount < 1){
            throw NiloMLError.noServerInPool
        }
        
        let requestBodyData = transformInHttpBodyDataDeepFake(image)
        var request = buildRequestDeepFakes(from: requestBodyData, using: self.onLineServerList.randomElement()!)
        //self.onLineServerList = []
        
        return try await makePreddiction(fromRequest: request)
    }
    
    private func makePreddiction(fromRequest request:URLRequest) async throws->TemporaryMediaFile{
        let (data,response) = try await URLSession.shared.data(for:request)
       
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NiloMLError.unexpected(code: -1)
        }
        
        dump(response)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Could not found \(urlString)")
//
//        }
        
        return TemporaryMediaFile(withData: data)
    }
    
    private func upDateOnlineServerList() async -> Int {
        serverList.shuffle()
        
        for server in serverList {
            await askForServerConnection(fromString: server)
        }
        
        return onLineServerList.count
    }
    
    private func askForServerConnection(fromString server:String) async{
        let postData = NSData(data: "".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(server)/isalive")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask1 = session.dataTask(with: request as URLRequest, completionHandler: { (data1, response, error) -> Void in
            if (error != nil) {
                return
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                if httpResponse?.statusCode != 200{
                    return
                }
                
                self.onLineServerList.append(server)
                
                self.onLineServerList = self.onLineServerList.unique()
                return
            }
        })
        
        dataTask1.resume()
    }
    
    private func transformInHttpBodyDataDeepFake(_ image:UIImage)->Data{
        let bodyAsJson:[String: Any] = [
            "instances":[
                [
                    "image":image.dataURL(),
                    "id":deviceUniqueID
                ]
            ]]
        
        return try! JSONSerialization.data(withJSONObject: bodyAsJson)
    }
    
    private func buildRequestDeepFakes(from postData:Data,using url:String)->URLRequest{
        let request = NSMutableURLRequest(url: NSURL(string: "\(url)/predict")! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 364.0)
        
        let headers = ["Content-Type": "application/json"]
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        return request as URLRequest
    }
    
    
    
    
}
