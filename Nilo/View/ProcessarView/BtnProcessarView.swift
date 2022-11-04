//
//  BtnProcessarView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 31/10/22.
//

import SwiftUI

struct BtnProcessarView: View {
    @State var usedAlgo: APIAlgorithm
    @State var btnText:LocalizedStringKey
    var action:()->Void
    var body: some View {
        Button(action: {
            action()
        }){
            
                ZStack{
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.melhorarfoto)
                            .frame(width: 200, height: 70)
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                        Text(btnText)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title2)
                            .font(.custom("Poppins-SemiBold", size: 20))
                   
                    }
                .padding(.bottom,50)
                .padding(.leading,90)
            
            Color.corDeFundo

        }.onAppear{
            switch usedAlgo {
            case .GFPGAN:
                btnText = "Melhorar"
            case .colorizeML:
                btnText = "BotaoColorir"
            case .firstOrderModel:
                btnText = "BotaoAnimar"
            }
        }
    }
}

