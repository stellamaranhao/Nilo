//
//  MenuTitleView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 25/10/22.
//

import SwiftUI

struct MenuTitleView: View {
    @State var title = "Nilo"
    @State var titleEgypt = "πππΆ"
    
    @State var desc = "Ferramentas de RestauraΓ§Γ£o"
    @State var descEgypt = "π²πππΆππ¬π΅ππππ€"
  
    @State var egyptText:Bool = false
    
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .bottomLeading){
                
                ZStack{
                    Image("MenuTitle")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                }
                
                
                VStack(alignment: .leading,spacing: -10){
                    if(egyptText){
                        Text(titleEgypt)
                            .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 64))
                        
                        Text(descEgypt)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                        
                    }else{
                        Text(title)
                            .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 64))
                        
                        
                        Text(desc)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                    }
                    
            
                    
                }.padding(58)
                .offset(y:-30)
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
