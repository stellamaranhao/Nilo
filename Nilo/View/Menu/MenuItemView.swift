//
//  MenuItemView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 24/10/22.
//

import SwiftUI

struct MenuItemView: View {
    @State var imageName:String
    @State var objImageName:String
    @State var title:String
    @State var description:String
    
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            HStack(spacing:-64){
                Image(imageName)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .offset(x:-50, y:-5)
                
                Image(objImageName)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .offset(y:-20)
                
            }.padding(5)
            
            VStack(alignment: .leading,spacing: -5){
                Text(title)
                    .foregroundColor(Color.corTexto)
                    .fontWeight(.bold)
                    .font(.custom("Poppins-SemiBold", size: 48))
                    .offset(x:30)
                
                Text(description)
                    .foregroundColor(Color.corTexto)
                    .fontWeight(.ultraLight)
                    .font(.custom("", size: 16))
                    .offset(x:30)
            }.padding(5)
            
        }
        //PAding na view TODO: padding
        .background(Color.corDeFundo)
        .cornerRadius(18)
        .shadow(color: Color.corTexto.opacity(0.3), radius: 25, y: 8)
        .frame(idealWidth: 350, idealHeight: 300)
        
    }
}
