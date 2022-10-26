//
//  TutorialView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct TutorialView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        let yExtension: CGFloat = 50
        GeometryReader{ geometry in
            VStack(spacing: -15){
                Button(){
                    print("tap tap btn")
                }label: {
                    Text("Pular")
                        .foregroundColor(Color.corTexto)
                        .font(.custom("Poppins-Regular", size: 16))
                        .padding(.leading, geometry.size.width*0.64)
                }.offset(y:geometry.size.width*0.25)
                

                
                TabView(selection: $selectedTab){
                    TutorialBVView()
                    
                    TutorialBVView()
                    
                }.tabViewStyle(.page)
                    .frame(width: geometry.size.width, height: geometry.size.height + yExtension+50)
                
            }
            
        }
        .offset(y: -yExtension)
        .edgesIgnoringSafeArea(.all)
        .background(Color.corDeFundo)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
