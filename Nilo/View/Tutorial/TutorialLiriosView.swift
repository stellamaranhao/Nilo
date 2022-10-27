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
                Text("LÍRIOS")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Hora de dar vida a suas fotos! Use **LÍROS** para dar cor as suas memórias mais antigas.")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.85)
                    .multilineTextAlignment(.center)
                
                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "Lirios", description: "Colorize fotos antigas")
                
                SliderView(imageBeforeName: "MachadoAntes",imageAferName: "MachadoDepois",
                           containerWidth: 364, containerHeight: 384)
                    .cornerRadius(18)
                    .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
                
                
            }
            .padding(.bottom,45)
        }
    }
}
