//
//  MenuTitleView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 25/10/22.
//

import SwiftUI

struct MenuTitleView: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .bottomLeading){
                Image("MenuTitle")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    //.scaledToFit()
                    //.aspectRatio(contentMode: .fill)
                    //.offset(y:geometry.size.height*0.30)
                
                VStack(alignment: .leading){
                    Text("Nilo")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.custom("Poppins", size: 56))
                    
                    Text("Ferramentas de Restauração")
                        .foregroundColor(.white)
                        .fontWeight(.ultraLight)
                        .font(.custom("", size: 16))
                    
                }.padding(58)
                .offset(y:-50)
                
            }
            
        }.cornerRadius(18)
            .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
            
    }
}

struct MenuTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitleView()
    }
}
