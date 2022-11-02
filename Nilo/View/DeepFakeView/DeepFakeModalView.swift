//
//  DeepFakeModalView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 01/11/22.
//

import SwiftUI


struct DeepFakeModalView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(){
            Color.corDeFundo.ignoresSafeArea(.all)
            VStack(alignment: .center,spacing: 15){
                Text("ACÁCIAS")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Alguns algoritmos de manipulações de imagens utilizados no Nilo necessitam de uma Placa de Video robusta, algo que nenhum dispositivo móvel pode oferecer. Para resolver essa questão, estamos criando um sistema de placas de video descentralizado.")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.85)
                    .multilineTextAlignment(.center)
                
                Text("Anunciaremos as placas de video em breve...")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.85)
                    .multilineTextAlignment(.center)
                
                MenuItemView(imageName: "acacia", objImageName: "deepfakes", title: "Acácias", description: "Anime fotos antigas")
                
                
                Button(action: {
                    self.dismiss()
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.melhorarfoto)
                            .frame(width: 200, height: 70)
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                        Text("Entendido !")
                            .foregroundColor(.corDeFundo)
                            .fontWeight(.bold)
                            .font(.title2)
                            .font(.custom("Poppins-SemiBold", size: 20))
                                                }
                    .padding(.bottom,50)
                    
                    
                }
            }
            
        }
    }
}


