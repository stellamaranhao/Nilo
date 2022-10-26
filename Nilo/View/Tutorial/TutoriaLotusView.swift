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
                Text("LÓTUS")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Use **LÓTUS** para restaurar imagens reduzindo \nos ruídos e desgastes indesejáveis, além de\n aprimorar a nitidez e resolução.")
                    .foregroundColor(Color.TextoTelaTutorial)
                    .font(.custom("Poppins-Regular", size: 12))
                    .frame(maxWidth: 350)
                    .multilineTextAlignment(.center)
                
                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "Lotus", description: "Restaure fotos danificadas e antigas")

                
                
                SliderView(imageBeforeName: "AnneAntes",imageAferName: "AnneDepois",
                           containerWidth: 364, containerHeight: 250)
                    .cornerRadius(18)
                    .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
                
                
            }
            .padding(.bottom,45)
        }
    }
}
