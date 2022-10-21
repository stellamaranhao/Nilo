import Foundation
import SwiftUI


struct TelaResultado: View {
    // @State var backImage = Image("ImagemAnneFinal")
    //    let api = BasetenAPI()
    @State private var showingSheet = false
    @State var showAlbumView = false
    
    @Binding var imageShown:UIImage?
    
    
    private var importtake: Bool {imageShown != nil}
    @State private var image : Bool = true
    @State private var showSheet = false
    @State var progressMsg:String = "progress: not started"
    @State var message:String = "GFP-GAN"

    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
     
    
    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                
                Image(uiImage: imageShown!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x:0,y:-60)
                
                Image(uiImage: image ? imageShown! : imageShown!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x:0,y:-60)
                
                
                
                VStack {
                    
                    NavigationLink(destination: RestauracaoView()) {
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
                                Text(progressMsg).font(.subheadline)
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
                            
                            Button {
                             
                            } label: {
                                Image(systemName: "eye.circle").resizable()
                                    .offset(x:50,y:235)
                                    .frame(width: 30,height: 30)
                                    .scaledToFit()
                                    .foregroundColor(Color.corTexto)
                            }
//                            .onLongPressGesture {
//                                <#code#>
//                            }
                             
                            
//                            Image(systemName: "eye.circle").resizable()
//                                .offset(x:50,y:235)
//                                .frame(width: 30,height: 30)
//                                .scaledToFit()
//                                .foregroundColor(Color.corTexto)
                            
                        }
                        
                        
                        
                    }
                    HStack{
                        Button {
                            shareButton()
                        } label: {
                            Image("exportarMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                            
                        }.frame(width: 170)
                        
                        //
                        //                        NavigationLink(destination: RestauracaoView()) {
                        //                            Image("exportarMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                        //                        }
                        //                        .frame(width: 170)
                        
                        NavigationLink(destination: RestauracaoView()) {
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
    func shareButton() {
        //        let image = Image(uiImage: imageShown!)
        
        let activityController = UIActivityViewController(activityItems: [imageShown!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    func recebeImg() {
            Image(uiImage: imageShown!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .offset(x:0,y:-60)
        
    }
    //    var resultButtom: UIImage{
    //                    if let image = imageShown{
    //                        api.imagePredictionPipeline(fromImage: image, progressUpdate:{progress in
    //                            progressMsg = "\(progress)%"
    //
    //                        }){ result in
    //                            api.imagePredictionPipelineCleanUp()
    //                            switch result {
    //                            case .success(let success):
    //                                imageShown = success
    //                            case .failure(let failure):
    //                                print(failure.asString)
    //                            }
    //                        }
    ////                    }
    //       return imageShown!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    //
    //struct TelaResultado_Previews: PreviewProvider {
    //    static var previews: some View {
    //        TelaResultado()
    //    }
    //}
    
}
