//
//  Menu.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 16/10/22.
//

import SwiftUI

struct MenuView: View {
    @Namespace var namespace
    @Binding var showingTutorial:Bool
    
    let generator = UINotificationFeedbackGenerator()
    let generatorSelection = UISelectionFeedbackGenerator()
    var motionManager = MotionManager()
    
    //Views
    @State var showFirstView:Bool = false
    @State var showSecondView:Bool = false
    
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
                        
                        Image(systemName: "questionmark.circle.fill")
                            .offset(x:geometry.size.width*0.35, y:-geometry.size.height*0.45)
                            .font(.title)
                            .foregroundColor(.white)
                            .onTapGesture {
                                showingTutorial.toggle()
                            }
                            .onLongPressGesture{
                                generator.notificationOccurred(.success)
                                UserDefaults.standard.set(true, forKey: "tutorial")
                                showingTutorial.toggle()
                            }
                            
                        
                        
                        VStack(spacing:30){
                            NavigationLink(destination: RestauracaoView(showingTutorial: showingTutorial), isActive: $showFirstView) {
                                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "Lotus", description: "Restaure fotos danificadas e antigas")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                    .onTapGesture {
                                        generatorSelection.selectionChanged()
                                        showSecondView.toggle()
                                    }
                            }
                            
                            NavigationLink(destination: ColorirView(), isActive: $showSecondView) {
                                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "Lirio", description: "Colorize fotos antigas")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                    .onTapGesture {
                                        generatorSelection.selectionChanged()
                                        showSecondView.toggle()
                                    }
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
