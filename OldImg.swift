//
//  OldImg.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 21/10/22.
//

import SwiftUI

struct OldImg: View {
    var recebeImg: UIImage?
    var body: some View {

        Image(uiImage: recebeImg!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 0, maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
            .offset(x:0,y:-60)

    }
}

struct OldImg_Previews: PreviewProvider {
    static var previews: some View {
        OldImg()
    }
}
