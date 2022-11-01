//
//  ButtonsView.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 23/10/22.
//
import SwiftUI

struct ButtonsView: View {
    @State var imgSistema: String
    @State var texto: String
    
    
    var body: some View {
        
        VStack(alignment:.center,spacing:-20 ){
            
            Image(systemName: imgSistema)
                .renderingMode(.original)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 22, height: 22)
                .foregroundColor(Color.corDeFundo)
                .padding(.top)
            
            Text(texto)
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(Color.corDeFundo)
                .lineLimit(2)
                .frame(width: 95 ,height: 95)
                .multilineTextAlignment(.center)
            
        }.background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.melhorarfoto)
                .frame(width:120 ,height: 90).padding(.bottom)
        )
        
    }
}
