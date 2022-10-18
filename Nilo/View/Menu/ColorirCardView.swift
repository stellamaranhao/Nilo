//
//  ColorirCardView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 18/10/22.
//

import SwiftUI

struct ColorirCardView: View {
    var body: some View {
        ZStack{
            Image("Lirios").resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
            // .offset(x:0,y:-250)
                .shadow(color: Color.letratelarestauracao.opacity(0.50), radius: 15, y: 8)
            
            VStack (alignment: .leading,spacing: .leastNormalMagnitude){
                Text("Lírios")
                // .offset(x:0,y:350)
                    .foregroundColor(Color.corTexto)
                //  .aspectRatio(contentMode: .fill)
                    .fontWeight(.bold)
                //  .font(.title)
                    .font(.custom("Poppins-SemiBold", size: 32))
                
                Text("Restaure fotos danificadas e antigas")
                    .foregroundColor(Color.corTexto)
                    .fontWeight(.ultraLight)
                    .font(.custom("", size: 14))
            }
            .offset(x:-20,y: 50)
        }
        .frame(width: 350, height: 300)
    }
}

struct ColorirCardView_Previews: PreviewProvider {
    static var previews: some View {
        ColorirCardView()
    }
}
