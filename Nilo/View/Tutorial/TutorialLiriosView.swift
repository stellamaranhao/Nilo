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
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Bold", size: 24))
                
                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "Lirios", description: "Colorize fotos antigas")
                    
                
                Text("Hora de dar vida a suas fotos! Use **LÍROS** para dar cor as suas memórias mais antigas.")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Regular", size: 16))
                    .frame(maxWidth: 350)
                    .multilineTextAlignment(.center)
                
                
                SliderView(imageBeforeName: "MachadoAntes",imageAferName: "MachadoDepois",
                           containerWidth: 364, containerHeight: 250)
                    .cornerRadius(18)
                    .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
                
                
            }
        }
    }
}
