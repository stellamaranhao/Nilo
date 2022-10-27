//
//  NiloMLTestView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI
import PhotosUI
import AVFoundation
import _AVKit_SwiftUI

struct NiloMLTestView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var imageShown:UIImage?
    @State var message:String = "Hello World"
    @State var player:AVPlayer?
   
    let api = NiloMLAPI()
    
    var body: some View {
        VStack{
            Text(message).font(.largeTitle)
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                VStack{
                    if let player = player {
                        VideoPlayer(player: player)
                            .frame(width: 250, height: 250)
                    }
                    
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
                Task{
                    do{
                        let tempFile = try await api.createDeepFake(fromImage: imageShown!)
                        
                        if let asset = tempFile.avAsset {
                                self.player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
                            }
                        
                    }catch{
                        
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(21)
            
        }
    }
}
