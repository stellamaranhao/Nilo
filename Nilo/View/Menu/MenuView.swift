//
//  Menu.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 16/10/22.
//

import SwiftUI

struct MenuView: View {
    @Namespace var namespace
    var motionManager = MotionManager()
    
    //Animations
    @State private var yoffsetTitle: Double = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                NavigationView {
                    ZStack{
                        Color.corDeFundo
                            .ignoresSafeArea()
                        
                        MenuTitleView()
                            .drawingGroup()
                            .ignoresSafeArea()
                            .offset(y:yoffsetTitle)
                            .onAppear{
                                withAnimation(.linear(duration: 0.6)){
                                    self.yoffsetTitle = -geometry.size.height*0.7
                                }
                            }
                            
                        
                        
                        VStack(spacing:30){
                            NavigationLink(destination: RestauracaoView()) {
                                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "Lotus", description: "Restaure fotos danificadas e antigas")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                            }
                            
                            NavigationLink(destination: ColorirView()) {
                                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "Lirio", description: "Colorize fotos antigas")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                            }
                        }
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.linear(duration: 0.5).delay(0.5)){
                                opacity = 1
                            }
                        }
                        
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                
            }
            
        }
    }
    
}


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
