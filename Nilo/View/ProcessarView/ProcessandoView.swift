//
//  ProcessandoView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 31/10/22.

import SwiftUI

enum ProcessandoViewsList {
    case exit
    case carregando
    case resultado
    case change
}

struct ProcessandoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentedView:ProcessandoViewsList
    @State var apiUtilizada:APIProtocol
    @Binding var imgPre:UIImage?
    @Binding var imgPos:UIImage?
    
    var body: some View {
        ZStack{
            switch presentedView{
            case .exit:
                ResultadoView(rootView: $presentedView,
                              oldImage: $imgPre,
                              imageShown: $imgPos,
                              apiUsada: $apiUtilizada).onAppear{
                        presentationMode.wrappedValue.dismiss()
                    }
                
            case .resultado:
                ResultadoView(rootView: $presentedView,
                              oldImage: $imgPre,
                              imageShown: $imgPos,
                              apiUsada: $apiUtilizada)
                .navigationBarBackButtonHidden(true)
                
            case .carregando:
                CarregandoView(
                    rootView: $presentedView,
                    oldImage: $imgPre,
                    imageShown: $imgPos,
                    apiUsada: apiUtilizada)
                .navigationBarBackButtonHidden(false)
                
            case .change:
                CarregandoView(
                    rootView: $presentedView,
                    oldImage: $imgPre,
                    imageShown: $imgPos,
                    apiUsada: apiUtilizada)
            }
            
            
        }
    }
}
