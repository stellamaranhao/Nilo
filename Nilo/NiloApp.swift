//
//  NiloApp.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 04/10/22.
//

import SwiftUI

@main
struct NiloApp: App {
    @State var currentPage:AppPage = AppPage.menuPage
    
    
    var body: some Scene {
        WindowGroup {
            switch currentPage {
            case .menuPage:
                MenuView(currentPage:$currentPage)
            case .colorirPage:
                ColorirView().transition(.move(edge: .trailing))
            }
        }
    }
}
