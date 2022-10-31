//
//  TutorialBVView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct TutorialBVView: View {
    
    var body: some View {
        ZStack(){
            VStack(alignment: .center,spacing: 15){
                Text("BEM VINDO!")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Antes de começar, veja algumas ferramentas disponíveis para que possa restaurar suas fotografias.")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.80)
                    .multilineTextAlignment(.center)
                
                Image("tutorial1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                
            }
        }
    }
}
