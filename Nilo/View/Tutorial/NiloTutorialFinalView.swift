//
//  NiloTutorialFinalView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct NiloTutorialFinalView: View {
    var body: some View {
        ZStack(){
            VStack(alignment: .center,spacing: 15){
                Text("NILO")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Agora é com você! Desfrute das ferramentas do **NILO** para preservar suas memórias e recordações. ")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Regular", size: 16))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.70)
                    .multilineTextAlignment(.center)
                
                Image("tutorialFinal")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                
            }
        }
    }
}

struct NiloTutorialFinalView_Previews: PreviewProvider {
    static var previews: some View {
        NiloTutorialFinalView()
    }
}
