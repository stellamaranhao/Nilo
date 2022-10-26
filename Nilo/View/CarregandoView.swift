//
//  CarregandoView.swift
//  Nilo
//
//  Created by Stella Maranhao on 20/10/22.
//

import SwiftUI

struct CarregandoView: View{
    @State private var spinXLarge = false
    
    var body: some View {
        
        ZStack{
            Color.fundoEsperaView
                .ignoresSafeArea()
            VStack{
                                Image("WaitingScreen")
                                    .padding(.bottom,80)
                               
                                    LoadingSpinnerView()
                                    .padding(.bottom,30)
                                
                                Text("   Por favor não feche o app!\nEstamos melhorando sua foto. ")
                                    .foregroundColor(.corTexto)
                                    .padding(.bottom,80)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                                        .frame(width: 181, height: 42)
                                        .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                                    Text("Cancelar")
                                        .foregroundColor(.letratelarestauracao)
                                        .fontWeight(.light)
                                        .font(.title2)
                                        .font(.custom("Poppins-SemiBold", size: 20))
                                }
                            }
                    }
                }
            }
struct CarregandoView_Previews: PreviewProvider {
    static var previews: some View {
        CarregandoView()
    }
}

