import Foundation
import SwiftUI


struct TelaResultado: View {
    @State var backImage = Image("ImagemAnneFinal")

    var body: some View {
        
        
        ZStack {
                   Image("ImagemAnneFinal")
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(minWidth: 0, maxWidth: .infinity)
                       .edgesIgnoringSafeArea(.all)
                   VStack {
                      
                   }
               }
           }
}

