//
//  CarregandoView.swift
//  Nilo
//
//  Created by Stella Maranhao on 20/10/22.
//

import SwiftUI
import PhotosUI

struct CarregandoVideoView: View{
    
    @Binding var rootView:ProcessandoVideoViewsList
    @Binding var oldImage: UIImage?
    @Binding var videoFile:TemporaryMediaFile?

    var apiUsada:APIProtocol
    
    var body: some View {
       
            ZStack{
                
                Color.fundoEsperaView
                    .ignoresSafeArea()
                
                VStack{
       
                    Image("WaitingScreen")
                        .padding(.bottom,80)
                        .animation(.default)
                    
                    ProgressView()
                        .tint(.corTexto)
                        .padding(.bottom,30)

                    Text("   Por favor não feche o app!\nEstamos melhorando sua foto. ")
                        .bold()
                        .foregroundColor(.corTexto)
                        .padding(.bottom,80)
                }
            }
            .onAppear{
                linkApiRestauracao()
            }
            .onDisappear{
                apiUsada.cancelImage()
            }
            
        
    }
    
    func linkApiRestauracao (){
        
        if let image = oldImage{
            apiUsada.predictVideo(fromImage: image){ result in
                switch result {
                case .success(let success):
                    videoFile = success
                    rootView = .resultado
                case .failure(let failure):
                    print("beteu aqui...")
                    rootView = .erro
                }
                
            }
            
            
        }
        
    }

}



