//
//  TelaResultado3.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 21/10/22.
//
import SwiftUI
import PhotosUI

struct ResultadoView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var oldImage: UIImage?
    @Binding var selectedImageData: Data?
    @Binding var imageShown:UIImage?
    @State var isClicked: Bool = false
    @State private var shared = false
    @State var showAlert:Bool = false
    @State var showingTutorial:Bool

    
    
    @State private var image : Bool = true
    @State var progressMsg:String = "progress: not started"
    @State var message:String = "GFP-GAN"
    let apicolor = ColorizeML()
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                
                Color.gray
                    .ignoresSafeArea()
                
                ZStack {
                    if (!isClicked) { ImageDetailView(image:imageShown!) }
                    else {ImageDetailView(image:oldImage!)}
                    
                    HStack {
                        VStack {
                            NavigationLink(destination: MenuView(showingTutorial: $showingTutorial)) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 30))
                                    .padding(.top, UIScreen.main.bounds.height / 15)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.melhorarfoto)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                            VStack(spacing: 5){
                                HStack {
                                    VStack (spacing: 5){
                                        Text("Memória Resgatada!")
                                            .foregroundColor(Color.corDeFundo)
                                            .font(.custom("Poppins-SemiBold", size: 20))
                                            .font(.title3)
                                        Text("Não pare por aqui:")
                                            .foregroundColor(Color.corDeFundo)
                                            .font(.custom("Poppins-Regular", size: 16))
                                            .font(.body)
                                    }
                                    .padding(.leading, UIScreen.main.bounds.width / 4.5)
                                    Spacer()
                                    eyeButton.frame(width: 50)
                                    
                                    
                                }
                                .padding(.bottom)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .center, spacing: 50) {
                                        Button {
                                            shareButton()
                                            
                                        } label: {
                                            ButtonsView(imgSistema: "square.and.arrow.up", texto: "Exportar memória")
                                        }
                                        
                                        
                                        Button {
                                            
                                            if !shared {
                                                showAlert = true
                                                
                                            } else{
                                                linkApiRestauracao() //entra tela de carregamento
                                            }
                                        } label: {
                                            ButtonsView(imgSistema: "paintbrush.pointed", texto: "Colorir memória")
                                        }
                                        .alert(isPresented: $showAlert) {
                                            
                                            Alert(title: Text("Tem certeza?")
                                                  ,message: Text("Gostaria de salvar a foto antes de sair ou fazer outra alteração?")
                                                  ,primaryButton: .default(Text("Salvar foto")){
                                                shareButton()
                                            },secondaryButton: .destructive(Text("Continuar mesmo assim")){
                                                print ("foi")
                                                linkApiRestauracao() //entra tela de carregamento
                                            }
                                                  
                                            )
                                        }
                                        
                                        
                                        
                                        NavigationLink(destination: RestauracaoView(showingTutorial: showingTutorial)) {
                                            ButtonsView(imgSistema: "arrow.turn.down.left", texto: "Resgatar outra memória")
                                        }
                                        
                                        Button {
                                            
                                        } label: {
                                            ButtonsView(imgSistema: "arrow.turn.down.left", texto: "Outra Função")
                                        }
                                        
                                    }.padding(.horizontal,30)
                                    
                                }
                            }
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }  // Nav View
        .navigationBarBackButtonHidden(true)
    }
    
    //    var popUpAlert: some View {
    //        Button("Alerta") {
    //            showingPopover = true
    //        }.alert(isPresented: $showingPopover ) {
    //            Alert(title: Text("Tem certeza?")
    //                  ,message: Text("Gostaria de salvar a foto antes de sair ou fazer outra alteração?")
    //                  ,primaryButton: .default(Text("Salvar foto")){
    //                shareButton()
    //            },secondaryButton: .destructive(Text("Continuar mesmo assim")){
    //                print ("foi")
    //            }
    //
    //            )
    //        }
    //
    //    }
    
    var eyeButton: some View {
        Button {
            isClicked.toggle()
        } label: {
            Image(systemName: isClicked ? "eye.slash.circle" : "eye.circle")
                .foregroundColor(Color.corDeFundo)
                .font(.system(size: 40))
                .padding(.trailing, UIScreen.main.bounds.width / 10)
        }
        
    }
    
    func shareButton() {
        //        let image = Image(uiImage: imageShown!)
        
        let activityController = UIActivityViewController(activityItems: [imageShown!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: {shared = true})
        
    }
    
    func linkApiRestauracao (){
        if let image = imageShown{
            apicolor.colorize(image: image)
            { result in
                switch result {
                case .success(let success):
                    imageShown = success
                    //return imageShown!
                    
                case .failure(let failure):
                    print(failure.asString)
                    //return nil
                }
                
                
            }
        }
        
    }
}


//struct TelaResultado3_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaResultado3(selectedItem: .constant(.none), selectedImageData: ,imageShown:(UIImage(named: "ImageAnne"))),selectedImageData: .constant(.none))
//    }
//}


//xmark.circle.fill
//Button("Show Menu") {
//                                            showingPopover = true
//                                        }
//                                        .popover(isPresented: $showingPopover) {
//                                            VStack(spacing: -10){
//                                                Image(systemName: "exclamationmark.triangle")
//                                                    .resizable()
//                                                    .scaledToFit()
//                                                    .foregroundColor(Color.melhorarfoto)
//                                                    .frame(width: UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
//                                                    .padding(.bottom)
//                                                Text("Tem certeza?")
//                                                // .font(.title)
//                                                    .font(.custom("Poppins-SemiBold", size: 26))
//                                                    .padding()
//                                                    .foregroundColor(Color.melhorarfoto)
//                                                Text("Gostaria de salvar a foto antes de sair ou fazer outra alteração?")
//                                                    .font(.custom("Poppins-Regular", size: 18))
//                                                    .foregroundColor(Color.melhorarfoto)
//                                                    .multilineTextAlignment(.center)
//                                                    .padding()
//                                               // HStack{
//                                                    Button {
//                                                        shareButton()
//                                                    } label: {
//                                                        ButtonsView(imgSistema: "square.and.arrow.up", texto: "Exportar memória")
//                                                    }
//                                                    Button {
//                                                        shareButton()
//                                                    } label: {
//                                                        ButtonsView(imgSistema: "square.and.arrow.up", texto: "Exportar memória")
//                                                    }

// }
//                                            }
//                                        }.presentationDetents([.medium]).background(Color.corDeFundo)
//
