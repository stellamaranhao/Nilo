//
//  NiloApp.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 04/10/22.
//

import SwiftUI

@main
struct NiloApp: App {
    @State var showingTutorial = UserDefaults.standard.bool(forKey: "tutorial")
    
    var body: some Scene {
        WindowGroup {
//            if showingTutorial{
//                TutorialView(showingTutorial: $showingTutorial)
//            }else{
//                MenuView(showingTutorial:  $showingTutorial)
//            }
            NiloMLTestView()

        }
    }
}
