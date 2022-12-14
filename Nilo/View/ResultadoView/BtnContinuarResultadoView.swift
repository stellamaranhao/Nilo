//
//  BtnContinuarResultadoView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 31/10/22.
//

import SwiftUI

struct BtnContinuarResultadoView: View {
    var apiUtilizada:APIProtocol
    
    var action:()->Void
    
    var body: some View {
        Button {
            action()
        } label: {
            switch apiUtilizada.algorithm{
            case .GFPGAN:
                ButtonsView(imgSistema: "paintbrush.pointed", texto: "Colorir memória")
            case .colorizeML:
                ButtonsView(imgSistema: "paintbrush.pointed", texto: "Melhoar Foto")
            case .firstOrderModel:
                EmptyView()
            }
        }
    }
}
