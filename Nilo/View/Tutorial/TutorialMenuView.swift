//
//  TutorialMenuView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import SwiftUI

struct TutorialMenuView: View {
    var motionManager = MotionManager()
    
    var body: some View {
        ZStack(){
            VStack(alignment: .center,spacing: 15){
                Text("MENU")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Bold", size: 24))
                
                Text("Na primeira tela você tem acesso as ferramentas de aperfeiçoamento disponivéis: **Restaurar** e **colorir** as fotos")
                    .foregroundColor(Color.corTexto)
                    .font(.custom("Poppins-Regular", size: 16))
                    .frame(maxWidth: UIScreen.main.bounds.width*0.80)
                    .multilineTextAlignment(.center)
                
                MenuItemView(imageName: "Lotus", objImageName: "Restaurar fotos", title: "Lotus", description: "Restaure fotos danificadas e antigas")
                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                
                MenuItemView(imageName: "Lirio", objImageName: "ColoringTool", title: "Lirio", description: "Colorize fotos antigas")
                    .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 12))
                
            }
        }
    }
}
