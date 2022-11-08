//
//  TutorialLiriosView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct TutorialLiriosView: View {
    var body: some View {
        ZStack(){
            VStack(alignment: .center,spacing: 15){
                Text("LiriosNome")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("TLirios")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.85)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "LiriosNome", description: "LiriosTexto")
                
                SliderView(imageBeforeName: "MachadoAntes",imageAferName: "MachadoDepois",
                           containerWidth: 264, containerHeight: 284)
                    .cornerRadius(18)
                    .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
                
                
            }
            
        }
    }
}
