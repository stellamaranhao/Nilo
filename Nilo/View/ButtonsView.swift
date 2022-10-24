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
                    .foregroundColor(.white)
                    .padding(.top)

                Text(texto)
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(width: 90 ,height: 90)
                    .multilineTextAlignment(.center)
                    
            }.background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.melhorarfoto)
                    .frame(width:120 ,height: 90).padding(.bottom)
            )
        
    }
}

//struct ButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonsView()
//    }
//}
//VStack{
//Button {
//
//} label: {
//    Image("exportarMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
//
//}.frame(width: 170)
//
//    VStack(alignment:.center,spacing:-20 ){
//
//        Image(systemName: "square.and.arrow.up")
//            .renderingMode(.original)
//            .resizable()
//            .aspectRatio( contentMode: .fit)
//            .frame(width: 22, height: 22)
//            .foregroundColor(.white)
//            .padding(.top)
//
//
//        Text("Exportar Memória")
//            .font(.custom("Poppins-Regular", size: 12))
//            .foregroundColor(.white)
//            .lineLimit(2)
//            .frame(width: 90 ,height: 90)
//            .multilineTextAlignment(.center)
//
//    }.background(
//        RoundedRectangle(cornerRadius: 20)
//            .fill(Color.melhoriaQualidade)
//            .frame(width:120 ,height: 90).padding(.bottom)
//    )
//}
