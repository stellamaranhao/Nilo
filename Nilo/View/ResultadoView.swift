//
//  ResultadoView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 18/10/22.
//

import SwiftUI

struct ResultadoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageShown:UIImage?
    
    
    var body: some View {
        ZStack{
            VStack{
                Image(uiImage: imageShown!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x:0,y:-60)
                
                
                Button("Resgatar outra memoria"){
                    presentationMode.wrappedValue.dismiss()
                }.frame(width: 170)
            }
            
        }
    }
}

//struct ResultadoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultadoView()
//    }
//}
