import Foundation
import SwiftUI


struct TelaResultado: View {
    @State var backImage = Image("ImagemAnneFinal")
 let api = BasetenAPI()
    @State private var showingSheet = false
    @State var showAlbumView = false
    @Binding var imageShown:UIImage?
    @State private var image : Bool = true
    @State var progressMsg:String = "progress: not started"
    @State var message:String = "GFP-GAN"

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
    
                VStack {
                
                    NavigationLink(destination: RestauracaoView()) {
                        Image("botaoSaida").resizable()
                        
                        
                
                Image(uiImage: image ? imageShown! : imageShown!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x:0,y:-60)
                                    
                    NavigationLink(destination: MenuView()) {
                        Image("botaoSaida").resizable().scaledToFit()
                    }
                    .frame(width: 25,height: 25)
                    
                    .offset(x: -160, y: -360)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.corDeFundo)
                        .frame(width:.infinity,height: 450)
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
                        
                        
                        
                    }.offset(x:0,y: -60)

                    scrowButtons
                  
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
    
    var scrowButtons: some View {
        
        ScrollView(.horizontal){
            HStack(spacing: -15){
                Button {
                    shareButton()
                } label: {
                    Image("exportarMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                    
                }.frame(width: 170)
                
                NavigationLink(destination: RestauracaoView()) {
                    Image("resgatarOutraMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                }
                .frame(width: 170)
                
                NavigationLink(destination: RestauracaoView()) {
                    Image("resgatarOutraMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                }
                .frame(width: 170)
                
                NavigationLink(destination: RestauracaoView()) {
                    Image("resgatarOutraMemoria").resizable().renderingMode(.original).aspectRatio( contentMode: .fit)
                }
                .frame(width: 170)
            }.frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}
