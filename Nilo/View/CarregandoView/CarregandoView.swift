//
//  CarregandoView.swift
//  Nilo
//
//  Created by Stella Maranhao on 20/10/22.
//

import SwiftUI
import PhotosUI

struct CarregandoView: View{
    
    @Binding var rootView:ProcessandoViewsList
    @Binding var oldImage: UIImage?
    @Binding var imageShown:UIImage?

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
        
        if let image = imageShown{
            apiUsada.predictImage(fromImage: image)
            { result in
                switch result {
                case .success(let success):
                    imageShown = success
                    print("foi")
                    rootView = .resultado
                    //return imageShown!
                    
                case .failure(let failure):
                    print(failure.asString)
                    //return nil
                }
                
                
            }
        }
        
    }

}


