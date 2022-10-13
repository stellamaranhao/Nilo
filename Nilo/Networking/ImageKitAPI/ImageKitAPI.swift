//
//  ImageKitAPI.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 12/10/22.
//

import Foundation
import UIKit

/// ImagiKitAPI connects to the ImageKit.io site - Used to host Media in CDNs
final class ImageKitAPI{
    
    /// Send a Image to the ImageKit.io media server
    /// - Parameters:
    ///   - image: UIimage to be sended
    ///   - completionCallback: Callback when API call is finished
    func uploadImage(_ image:UIImage, onCompletion completionCallback: @escaping(Result<ImageKitUploadResponse,Error>)->Void){
        let boundary = "Boundary-\(UUID().uuidString)"
        let parameters = generateParametres(image, named: Date().timeIntervalSince1970.description)
        var body = generateBody(fromBody: parameters, usingBoundary: boundary)
        
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://upload.imagekit.io/api/v1/files/upload")!,timeoutInterval: Double.infinity)
        request.addValue("Basic cHJpdmF0ZV90bEV0TUVIY2ErZXU1eDVYWHdNdHZsS2hFbDg9Og==", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            return
          }
            do{
                let decoder = JSONDecoder()
                let objResponse = try decoder.decode(ImageKitUploadResponse.self, from: data)
                completionCallback(.success(objResponse))
                
            }catch{
                print("Json Parse Error \(error)")
            }
        }
        task.resume()
    }
    
    /// Delete a image in the ImageKit.io media server
    /// - Parameter id: image id (provided by ImageKit.io)
    func deleteImage(fromID id:String){
        var request = URLRequest(url: URL(string: "https://api.imagekit.io/v1/files/\(id)")!,timeoutInterval: Double.infinity)
        request.addValue("Basic cHJpdmF0ZV90bEV0TUVIY2ErZXU1eDVYWHdNdHZsS2hFbDg9Og==", forHTTPHeaderField: "Authorization")

        request.httpMethod = "DELETE"
        print("trying to delete \(id)")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print("DELETED \(id)")
        }

        task.resume()
    }
    
    /// Since ImageKit.io uses a special type of request, first we have to built it
    /// - Parameters:
    ///   - image: image to be saved
    ///   - name: Name of the image
    /// - Returns: Paraments of the call
    private func generateParametres(_ image:UIImage, named name:String)->[[String : Any]]{
        let parameters = [
          [
            "key": "file",
            "value": image.dataURL()!,
            "type": "text"
          ],
          [
            "key": "fileName",
            "value": "\(name).jpg",
            "type": "text"
          ],
          [
            "key": "tags",
            "value": "test",
            "type": "text"
          ]] as [[String : Any]]
        
        return parameters
    }
    
    /// Since ImageKit.io uses a special type of request, first we have to built it
    /// - Parameters:
    ///   - parameters: Paramerts of the request
    ///   - boundary: request boundary
    /// - Returns: request body
    private func generateBody(fromBody parameters:[[String : Any]], usingBoundary boundary:String)->String{
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
              let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data
                let fileContent = String(data: (fileData)!, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        
        return body
    }
    
    
    
}

