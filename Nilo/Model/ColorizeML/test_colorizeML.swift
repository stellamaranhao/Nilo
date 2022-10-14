//
//  test_colorizeML.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 06/10/22.
//

import SwiftUI

struct test_colorizeML: View {
        let colorize = ColorizeML()
        @State var minhaimagem: UIImage = UIImage(named: "chopin")!
        
        var body: some View {
            VStack {
                if let minhaimagem {
                    Image(uiImage: minhaimagem)
                        .resizable()
                    //.imageScale()
                        .foregroundColor(.accentColor)
                        .frame(width: 360, height: 517)
                    
                }
                
            }
            .onTapGesture {
                print("hey hey ")
                colorize.colorize(image: UIImage(named: "chopin")!) { resposta in
                    if case let .success(imagem) = resposta {
                        self.minhaimagem = imagem
                    }
                    
                }
            }
            .padding()
        }
    }

struct test_colorizeML_Previews: PreviewProvider {
    static var previews: some View {
        test_colorizeML()
    }
}
