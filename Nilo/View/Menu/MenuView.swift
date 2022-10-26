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
    let feedbackGenerator = UISelectionFeedbackGenerator()
    
    //Pages
    @State private var restauracaoViewNavigation = false
    @State private var colorirViewNavigation = false
    
    //Animations
    @State private var yOffsetTitle: Double = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                NavigationView {
                    ZStack{
                        Color.corDeFundo
                            .ignoresSafeArea()
                        
                        MenuTitleView()
                            .ignoresSafeArea()
                            .offset(y:yOffsetTitle)
                            .onAppear{
                                withAnimation(.easeInOut(duration: 1).delay(2.5)){
                                    self.yOffsetTitle = -geometry.size.height*0.7
                                }
                            }
                            
                        
                        
                        VStack(spacing:30){
                            NavigationLink(destination: RestauracaoView(),isActive: $restauracaoViewNavigation) {
                                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "Lotus", description: "Restaure fotos danificadas e antigas")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                    .onTapGesture {
                                        restauracaoViewNavigation = true
                                        feedbackGenerator.selectionChanged()
                                    }
                            }
                            
                            NavigationLink(destination: ColorirView(),isActive: $colorirViewNavigation) {
                                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "Lirio", description: "Colorize fotos antigas")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                    .onTapGesture {
                                        colorirViewNavigation = true
                                        feedbackGenerator.selectionChanged()
                                    }
                            }
                            
                            
                        }
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.linear(duration: 0.5).delay(3)){
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
