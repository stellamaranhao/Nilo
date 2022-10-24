//
//  TelaResultado3.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 21/10/22.
//

import SwiftUI

struct TelaResultado3: View {
    
    @Binding var imageShown:UIImage?
    
    @State private var image : Bool = true
    @State var progressMsg:String = "progress: not started"
    @State var message:String = "GFP-GAN"
    
    var body: some View {
        NavigationView{
            ZStack {
                
                Color.gray
                    .ignoresSafeArea()
                
                VStack(spacing: 50){
                    Spacer()
                  //  Image(uiImage: imageShown!)
                        Image("ImageAnne")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
  
                    HStack(spacing: 20.0) {
                        Button {

                        } label: {
                            Text("Fazer ABCD")
                        }
                        Button {

                        } label: {
                            Text("Fazer XYZ")
                        }
                    }
                    .padding(.vertical, 90)
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                                    .background (
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.corDeFundo)
                            .ignoresSafeArea()
                            )
                    
                }// VStack 1
            } // ZStack
        }  // Nav View
        .navigationBarBackButtonHidden(true)
    }
}

func botao1 () {
    
    Button {

    } label: {
        Text("Fazer ABCD")
    }
    Button {

    } label: {
        Text("Fazer XYZ")
    }
.padding(.vertical, 100)
.buttonStyle(.borderedProminent)
.frame(maxWidth: .infinity)
      
    
    
    
}



struct TelaResultado3_Previews: PreviewProvider {
    static var previews: some View {
        TelaResultado3(imageShown: .constant(.actions))
    }
}
