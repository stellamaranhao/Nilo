//
//  Menu.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 16/10/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color.corDeFundo
                    .ignoresSafeArea(.all)
                ZStack{
                    mainImage
                    
                    VStack (alignment: .leading){
                        Text("Nilo")
                        // .offset(x:0,y:350)
                            .foregroundColor(Color.corDeFundo)
                        //  .aspectRatio(contentMode: .fill)
                            .fontWeight(.heavy)
                        //  .font(.title)
                            .font(.custom("Arial" , size: 64))
                        
                        Text("Ferramentas de Restauração")
                            .foregroundColor(Color.corDeFundo)
                            .fontWeight(.light)
                            .font(.body)
                    }
                    .offset(x:-70,y:-250)
                    
                    NavigationLink(destination: RestauracaoView()) {
                        ZStack{
                            Image("Lotus").resizable()
                                .edgesIgnoringSafeArea(.all)
                                .aspectRatio(contentMode: .fit)
                                .shadow(color: Color.letratelarestauracao.opacity(0.50), radius: 15, y: 8)
                            
                            VStack (alignment: .leading,spacing: .leastNormalMagnitude){
                                Text("Lótus")
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
                    .offset(x:0,y: -50)
                    
                    NavigationLink(destination: ColorirView()) {
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
                    .offset(x:0,y: 230)
                }
                .offset(y:-60)
            }
        }
        .navigationBarBackButtonHidden(true)
    }//.navigationBarBackButtonHidden(true)
    
    
  
    var mainImage: some View {
        Image("menuImage").resizable()
            .edgesIgnoringSafeArea(.all)
            .aspectRatio(contentMode: .fit)
            .offset(x:0,y:-250)
            .shadow(color: Color.letratelarestauracao.opacity(0.50), radius: 15, y: 8)
    }
}


//struct Menu_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}