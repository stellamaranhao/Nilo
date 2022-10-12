//
//  TelaResultado.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 11/10/22.
//

import Foundation
import SwiftUI


struct TelaResultado: View {
    //@State var backImage = Image("ImagemAnneFinal")

    var body: some View {
        VStack {
            Image("ImagemAnneFinal")
                .resizable()
                .renderingMode(.original)
                .aspectRatio( contentMode: .fit)
            Spacer()

            
        }
        .ignoresSafeArea()
        
    }
}
