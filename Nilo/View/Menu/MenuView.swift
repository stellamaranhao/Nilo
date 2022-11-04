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
   // @State var lotusNome: LocalizedStringKey = 
    
    //Views
    
    @State var showFirstView:Bool = false
    @State var showSecondView:Bool = false
    @State var showThirdView:Bool = false
    
    //Animations
    @State private var yoffsetTitle: Double = 0
    @State private var opacity: Double = 0
    
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                NavigationStack {
                    ZStack{
                        Color.corDeFundo
                            .ignoresSafeArea()
                        
                        
                        MenuTitleView()
                            .drawingGroup()
                            .ignoresSafeArea()
                            .offset(y:yoffsetTitle)
                            .onAppear{
                                withAnimation(.linear(duration: 0.6)){
                                    self.yoffsetTitle = -geometry.size.height*0.8
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
                        
                        
                        
                        ScrollView{
                            NavigationLink(destination: ProcessarView(apiUtilizada: BasetenAPI()), isActive: $showFirstView) {
                                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "LotusNome", description: "LotusTexto")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                    .onTapGesture {
                                        generatorSelection.selectionChanged()
                                        showFirstView.toggle()
                                    }
                            }
                            
                            NavigationLink(destination: ProcessarView(apiUtilizada: ColorizeML()), isActive: $showSecondView) {
                                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "LiriosNome", description: "LiriosTexto")
                                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                    .onTapGesture {
                                        generatorSelection.selectionChanged()
                                        showSecondView.toggle()
                                    }
                            }.isDetailLink(false)
                            
                            
                            
                            MenuItemView(imageName: "acacia", objImageName: "deepfakes", title: "AcaciasNome", description: "AcaciasTexto")
                                .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                                .onTapGesture {
                                    generatorSelection.selectionChanged()
                                    showThirdView.toggle()
                                }
                                .padding(.bottom,120)
                            
                            //Text("").padding(.top,100)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y:geometry.size.height*0.2)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.linear(duration: 0.5).delay(0.5)){
                                opacity = 1
                            }
                        }
                        
                    }.navigationTitle("")
                    
                    
                }
                
            }
            
        }
    }
    
}

