//
//  test_basetenView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 11/10/22.
//

import SwiftUI

//
//  test_replicateView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 08/10/22.
//

import SwiftUI
import PhotosUI

struct test_basetenView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var imageShown:UIImage?
    
    @State var message:String = "Hello World"
    let api = BasetenAPI()
    
    var body: some View {
        VStack{
            Text(message).font(.largeTitle)
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                HStack{
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFit()
//                    .frame(width: 250, height: 250)
                    
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
            
            
            //Validar Token
//            Button("Validar Token") {
//                api.validateToken{result in
//                    switch result {
//                    case .success(_):
//                        message = "Token Valido: \(api.authTokenValid.description)"
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            }
//            .padding()
//            .foregroundColor(.white)
//            .background(.blue)
//            .cornerRadius(21)
            
            
            //Criar uma preddiction com a foto
            Button("Enviar predicao do modelo") {
                if let image = imageShown{
                    let input = BasetenAPIInput()
                    input.GFPGAN(image: image)
                    api.createPrediction(using: input){
//                        switch result {
//                        case .success(let sucess):
//                            message = "Processando Modelo...\nURL:\(sucess)"
//                        case .failure(let failure):
//                            print(failure)
//                        }
                        
                        print("Bateu no callback")
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(21)
            
            //Receber preddiction de uma foto
//            Button("Mostrar resultado") {
//                api.getImagePrediction{ result in
//                    switch result {
//                    case .success(let success):
//                        if let image = success{
//                            imageShown = image
//                            message = "Exibindo imagem alterada"
//                        }else{
//                            message = "Trabalhando..."}
//                    case .failure(let failure):
//                        print(failure)
//                    }
//
//                }
//            }
//            .padding()
//            .foregroundColor(.white)
//            .background(.blue)
//            .cornerRadius(21)
            
            
            
        }
    }
}



