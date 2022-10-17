//
//  TelaUpload.swift
//  Nilo
//
//  Created by Stella Maranhao on 14/10/22.
//


//

import SwiftUI
import PhotosUI

struct TelaUploadView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var imageShown:UIImage?
    
    @State var message:String = "GFP-GAN"
    @State var progressMsg:String = "progress: not started"
    let api = BasetenAPI()
    
    var body: some View {
        VStack{
            Text(message).font(.largeTitle)
            Text(progressMsg).font(.subheadline)
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                HStack{
                    Image(uiImage: imageShown!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                }
            }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                            imageShown = UIImage(data: selectedImageData!)
                        }
                    }
                }
            
            //Criar uma preddiction com a foto
            Button("Enviar predicao do modelo") {
                if let image = imageShown{
                    api.imagePredictionPipeline(fromImage: image, progressUpdate:{progress in
                        progressMsg = "\(progress)%"
                        
                    }){ result in
                        api.imagePredictionPipelineCleanUp()
                        switch result {
                        case .success(let success):
                            imageShown = success
                        case .failure(let failure):
                            print(failure.asString)
                        }
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(21)
            
            //Salvar foto
            Button("Salvar Foto") {
                UIImageWriteToSavedPhotosAlbum(imageShown!, nil, nil, nil)
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(21)
            
            
            
        }
    }
}



