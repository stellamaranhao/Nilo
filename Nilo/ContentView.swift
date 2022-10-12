//
//  ContentView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 04/10/22.
//

import SwiftUI

struct ContentView: View {
    let api = ReplicateAPI(fromToken: "c7a7ef617f35f71f74a7ce1d0ef45853d6b58cec")
    @State var imageName = ""
    
    
    @StateObject var networkMonitor = NetworkMonitor.shared
    
    var body: some View {
        
        
        VStack {
            AsyncImage(url: URL(string: imageName)) { image in
                image.resizable()
                image.scaledToFill()
                
            } placeholder: {
                Image("ImageAnne")
                    .resizable()
            }
            .frame(width: 250, height: 250)
            
            VStack {
                Text(networkMonitor.isConnected ? "Conectado" : "Não conectado")
            }
            .onTapGesture{
                print("tap tap")
                api.validateToken(){erro in}
//
//
//                let replicatePrediction = ReplicateAPIInput()
//                replicatePrediction.GFPGAN(image: UIImage(imageLiteralResourceName: "ImageAnne"), version: "v1.3", scaleFactor: 2)
//
//
//                api.createPrediction(using:replicatePrediction, sucessCallback: {print("2Sucesso2!")}, errorCallback: {print("2Erro!2")})
            }
            .onAppear {
                NetworkMonitor.shared.startMonitoring()
            }
            .padding()
        }
    }
    
    func updateImageFromResponse(newURL:String){
        self.imageName = newURL
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
