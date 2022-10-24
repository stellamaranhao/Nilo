//
//  ButtonsView.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 23/10/22.
//

import SwiftUI

struct ButtonsView: View {
    var body: some View {
        VStack{
        Button {

        } label: {
            Image("exportarMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)

        }.frame(width: 170)

            VStack{
                
                Image(systemName: "square.and.arrow.up")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 30, height: 30)


                Text("Exportar Memória")
                    .font(.custom("Poppins-Regular", size: 20))
  .foregroundColor(.white)
                    
                    
            }.background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.melhoriaQualidade)
                    .frame(width:120 ,height: 90)
            )
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
