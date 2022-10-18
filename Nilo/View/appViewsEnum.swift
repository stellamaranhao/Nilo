//
//  appViewsEnum.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 18/10/22.
//

import Foundation

enum AppPage:String, Identifiable {
    var id: String { self.rawValue }
    case menuPage = "menuPage"
    case colorirPage = "colorirPage"
    case melhorarPage = "melhorarPage"
}
