//
//  BasetenAPI.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 11/10/22.
//

import Foundation
import UIKit

/// Class to make calls to the BasetenAPI
final class BasetenAPI{
    var authToken:String
    var authTokenValid:Bool = false
    var imageKit = ImageKitAPI()
    var lastProcessedID = ""
    
    
    init (fromToken authToken: String) {
        self.authToken = authToken
    }
    
    init(){
        self.authToken = ProcessInfo.processInfo.environment["BASETEN_KEY"] ?? "vjbG7ScV.Ej9addGGST88VD7vhGO2fbCW7sry5n1u"
    }
    
    
    /// Create a image prediction using GFP-GAN. This Pipeline salves the image in the imageKit.io, then, passes the URL to the BasetenAPI. Finally the image is generated and retrived as a UIImage
    /// - Parameters:
    ///   - image: Image to be upscaled using the GFP-GAN
    ///   - completionCallback: Completion Callback
    func imagePredictionPipeline(fromImage image:UIImage, onCompletion completionCallback:@escaping(Result<UIImage,BasetenError>)->Void){
        imageKit.uploadImage(image){result in
            switch result {
            case .success(let success):
                guard let url = success.url else {fatalError()}
                self.lastProcessedID = success.fileId!
                let input = BasetenAPIInput()
                input.GFPGAN(imageURL: url)
                
                self.createImagePrediction(using: input){result in
                    switch result {
                    case .success(let success):
                        completionCallback(.success(success))
                        self.imagePredictionPipelineCleanUp()
                    case .failure(_):
                        completionCallback(.failure(.pipelineError(response: "")))
                    }
                }
                
                
            case .failure(let failure):
                completionCallback(.failure(.imageKitError(response: "")))
                fatalError()
            }
            
        }
    }
    
    
    /// Create a image prediction using GFP-GAN. This Pipeline salves the image in the imageKit.io, then, passes the URL to the BasetenAPI. Finally the image is generated and retrived as a UIImage
    /// - Parameters:
    ///   - image: Image to be upscaled using the GFP-GAN
    ///   - progressUpdate: Updates the progress during all steps via a callback function
    ///   - completionCallback: Completion Callback
    func imagePredictionPipeline(fromImage image:UIImage, progressUpdate:@escaping(Int)->Void, onCompletion completionCallback:@escaping(Result<UIImage,BasetenError>)->Void){
        progressUpdate(0)
        imageKit.uploadImage(image){result in
            switch result {
            case .success(let success):
                guard let url = success.url else {fatalError()}
                self.lastProcessedID = success.fileId!
                let input = BasetenAPIInput()
                input.GFPGAN(imageURL: url)
                progressUpdate(50)
                
                self.createImagePrediction(using: input){result in
                    switch result {
                    case .success(let success):
                        progressUpdate(100)
                        completionCallback(.success(success))
                    case .failure(let failure):
                        completionCallback(.failure(.pipelineError(response: "")))
                    }
                }
                
                
            case .failure(let failure):
                completionCallback(.failure(.imageKitError(response: "")))
                fatalError()
            }
            
        }
    }
    
    
    /// Clean the last image preddicted from the MediaServer in the ImageKit.io
    func imagePredictionPipelineCleanUp(){
        imageKit.deleteImage(fromID: self.lastProcessedID)
    }
    
    
    /// Make a prediction call to the BasetenAPI
    /// - Parameters:
    ///   - data: Baseten Input
    ///   - completionCallback: Callback when call is completed
    func createImagePrediction(using data:BasetenAPIInput, onCompletion completionCallback:@escaping(Result<UIImage,BasetenError>)->Void){
        let url = URL(string: "https://app.baseten.co/model_versions/\(data.using!)/predict")
        
        guard let requestURL = url else {
            completionCallback(.failure(BasetenError.badRequestedUrl(response: url?.description ?? "")))
            fatalError()
        }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        
        // Set HTTP Requst Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Api-Key \(self.authToken)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = data.httpBody
        
        // Perform HTTP Request
        print("Starting preciton")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionCallback(.failure(BasetenError.noResponse(response: error.debugDescription)))
                return
            }
            guard error == nil else {
                completionCallback(.failure(BasetenError.networkError(response: error.debugDescription)))
                return
            }
            do {
                print("Prediction recived")
                let decoder = JSONDecoder()
                let objResponse = try decoder.decode(BasetenAPIGFPGANResponse.self, from: data)
                guard let predictionUrl = objResponse.predictions?.first else {
                    completionCallback(.failure(BasetenError.invalidReResponseObj(response: "")))
                    fatalError()
                }

                DispatchQueue.global().async {
                    // Fetch Image Data
                    if let data = try? Data(contentsOf: URL(string: (predictionUrl))!) {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)!
                            completionCallback(.success(image))
                        }
                    }
                }
                
            } catch {
                completionCallback(.failure(BasetenError.responseJsonParseError(response: "")))
                return
            }
            
        }
        task.resume()
    }
    
    
}



