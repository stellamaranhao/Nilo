import Foundation
import SwiftUI


struct TelaResultado: View {
    @State var backImage = Image("ImagemAnneFinal")
    @State private var showingSheet = false


    var body: some View {
        
        
        ZStack {
                   Image("ImagemAnneFinal")
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(minWidth: 0, maxWidth: .infinity)
                       .edgesIgnoringSafeArea(.all)
                   VStack {
                       Button("Show Sheet") {
                                   showingSheet.toggle()
                               }
                               .sheet(isPresented: $showingSheet) {
                                   SheetView()
                               }
                   }
               }
           }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        //.background(.black)
        
    }
}

