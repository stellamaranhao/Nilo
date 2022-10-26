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
            VStack(alignment: .center,spacing: 20){
                Text("Bem Vindo!")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Antes de começar, veja algumas ferramentas disponíveis para que possa restaurar suas fotografias.")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Regular", size: 16))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.70)
                    .multilineTextAlignment(.center)
                
                Image("tutorial1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                
            }
        }
    }
}

struct TutorialBVView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialBVView()
    }
}
