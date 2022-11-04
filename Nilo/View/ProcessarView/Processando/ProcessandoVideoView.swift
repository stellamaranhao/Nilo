//
//  ProcessandoView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 31/10/22.

import SwiftUI
import AVFoundation

enum ProcessandoVideoViewsList {
    case exit
    case carregando
    case resultado
    case erro
}

struct ProcessandoVideoView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var presentedView:ProcessandoVideoViewsList
    @State var apiUtilizada:APIProtocol
    @Binding var imgPre:UIImage?
    @State var videoFile:TemporaryMediaFile?
    
    var body: some View {
        ZStack{
            switch presentedView{
            case .exit:
                ResultadoVideoView(rootView: $presentedView,
                                   oldImage: $imgPre,
                                   videoFIle: $videoFile,
                                   apiUsada: $apiUtilizada)
                .onAppear{presentationMode.wrappedValue.dismiss()
                }
            case .carregando:
                CarregandoVideoView(rootView: $presentedView,
                                    oldImage: $imgPre,
                                    videoFile: $videoFile,
                                    apiUsada: apiUtilizada)
            case .resultado:
                ResultadoVideoView(rootView: $presentedView,
                                   oldImage: $imgPre,
                                   videoFIle: $videoFile,
                                   apiUsada: $apiUtilizada)
                .navigationBarBackButtonHidden(true)
            case .erro:
                DeepFakeModalView()
            }
            
            
        }
    }
}

