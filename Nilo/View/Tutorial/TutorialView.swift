//
//  TutorialView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct TutorialView: View {
    @State private var selectedTab = 1
    @Binding var showingTutorial:Bool
    
    var body: some View {
        //let yExtension: CGFloat = 50
        GeometryReader{ geometry in
                VStack(alignment: .leading, spacing: 0){
                    TabView(selection: $selectedTab){
                        
                        TutorialBVView()
                            .tabItem({
                                Image(systemName: "1.square")
                            })
                            .tag(1)
                        
                        TutorialMenuView().tabItem({
                            Image(systemName: "2.square")
                        }).tag(2)
                        
                        TutoriaLotusView().tabItem({
                            Image(systemName: "3.square")
                        }).tag(3)
                        
                        TutorialLiriosView().tabItem({
                            Image(systemName: "4.square")
                        }).tag(4)
                        
                        NiloTutorialFinalView().tabItem({
                            Image(systemName: "5.square")
                        }).tag(5)
                        
                        MenuTitleView().tabItem({
                            Image(systemName: "6.square")
                        }).tag(6)
                        
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    
                    Spacer().frame(height: 25)
                }
                
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.corDeFundo)
        .onChange(of: selectedTab) { value in
            print("selected tab = \(value)")
            if(value == 6){
                showingTutorial.toggle()
                UserDefaults.standard.set(false, forKey: "tutorial")
            }
            
        }
    }
}
