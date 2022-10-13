import Foundation
import SwiftUI


struct TelaResultado: View {
    // @State var backImage = Image("ImagemAnneFinal")
    @State private var showingSheet = false
    @State var showAlbumView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Image("ImagemAnneFinal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x:0,y:-60)
                
                
                VStack {
                    
                    NavigationLink(destination: AlbumView()) {
                        Image("botaoSaida").resizable()
                        
                        
                    }
                    .frame(width: 25,height: 25)
                    .scaledToFit()
                    .offset(x: -160, y: -360)
                    
                    
                    
                    //                Button("Show Sheet") {
                    //                    showingSheet.toggle()
                    //                }
                    //                .sheet(isPresented: $showingSheet) {
                    //                    SheetView()
                    //                        .presentationDetents([.fraction(0.40)])
                    //                }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.corDeFundo)
                        .frame(width:.infinity,height: 300)
                        .offset(x:0,y:350)
                    
                    VStack{
                        HStack{
                            VStack (spacing: 5){
                                Text("Memória Resgatada!")
                                // .offset(x:0,y:350)
                                    .foregroundColor(Color.corTexto)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Text("Não pare por aqui:")
                                    .foregroundColor(Color.corTexto)
                                    .fontWeight(.ultraLight)
                                    .font(.body)
                            }
                            .offset(x:20,y:245)
                            
                            Image(systemName: "eye.circle").resizable()
                                .offset(x:50,y:235)
                                .frame(width: 30,height: 30)
                                .scaledToFit()
                                .foregroundColor(Color.corTexto)
                            
                        }
                        
                        

                    }
                    HStack{
                       
                        NavigationLink(destination: AlbumView()) {
                            Image("exportarMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                        }
                        .frame(width: 170)
                        
                        NavigationLink(destination: AlbumView()) {
                            Image("resgatarOutraMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                        }
                        .frame(width: 170)
                    }
                       .offset(x:0,y:340)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    //        struct SheetView: View {
    //             @Environment(\.dismiss) var dismiss
    //
    //
    //            var body: some View {
    //
    //
    //                ZStack{
    //                    Color.corDeFundo
    //                    Button("Press to dismiss") {
    //                        dismiss()
    //                    }
    //                    .font(.title)
    //                    .foregroundColor(Color.yellow)
    //                    .padding()
    //                }
    //                .ignoresSafeArea()
    //            }
    //        }
    //
    //    }
    //
}
