//
//  NiloTutorialFinalView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct NiloTutorialFinalView: View {
    @Binding var encerrar:Bool
    let generator = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack(){
            VStack(alignment: .center,spacing: 15){
                Text("NILO")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("TFinal" )
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.80)
                    .multilineTextAlignment(.center)
                    .padding(.bottom,50)
                
                Image("tutorialFinal")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                
                Button(action: {
                    encerrar.toggle()
                    UserDefaults.standard.set(false, forKey: "tutorial")
                    generator.notificationOccurred(.success)
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.melhorarfoto)
                            .frame(width: 200, height: 70)
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                        Text("BotaoComecar")
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
