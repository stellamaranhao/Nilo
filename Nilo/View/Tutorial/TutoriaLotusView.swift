//
//  TutoriaLotusVIew.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct TutoriaLotusView: View {
    var body: some View {
        ZStack(){
            VStack(alignment: .center,spacing: 15){
                Text("LotusNome")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("TLotus")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 14))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.90)
                    .multilineTextAlignment(.center)
                
                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "LotusNome", description: "LotusTexto")

                
                
                SliderView(imageBeforeName: "AnneAntes",imageAferName: "AnneDepois",
                           containerWidth: 364, containerHeight: 384)
                    .cornerRadius(18)
                    .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
                
                
            }
            .padding(.bottom,45)
        }
    }
}
