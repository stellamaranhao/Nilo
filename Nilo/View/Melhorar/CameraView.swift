//
//  CameraView.swift
//  Nilo
//
//  Created by Stella Maranhao on 05/10/22.
//

import Foundation
import SwiftUI

struct CameraView: View {
    var body: some View {
        HStack{
            Text("Conteúdo da câmera")
                .foregroundColor(.white)
                .padding(.vertical, 300)
                .padding(.horizontal, 70)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.gray)
                )
            
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
