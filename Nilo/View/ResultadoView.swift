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
    @State var isShowingMenu: Bool = false
    @State private var isShowingDetailView = false

    
    @State private var image : Bool = true
    @State var progressMsg:String = "progress: not started"
    @State var message:String = "GFP-GAN"
    let apicolor = ColorizeML()
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                
//                Color.gray
//                    .ignoresSafeArea()
                
                ZStack {
                    if (!isClicked) { ImageDetailView(image:imageShown!) }
                    else {ImageDetailView(image:oldImage!)}
                    
                    HStack {
                        VStack {
//                            NavigationLink(destination: MenuView(showingTutorial: $showingTutorial)) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .font(.system(size: 30))
//                                    .padding(.top, UIScreen.main.bounds.height / 15)
//                                    .padding(.leading)
//                            }
                            
                            
                            
                            NavigationLink(destination: MenuView(showingTutorial: $showingTutorial), isActive: $isShowingDetailView) { EmptyView() }
                            Button(action: {
                                if !shared {
                                    showAlert = true
                                    
                                } else{
                                    isShowingDetailView = true
                                }
                                
                                
                            }){
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 30))
                                    .padding(.top, UIScreen.main.bounds.height / 15)
                                    .padding(.leading)
                            }.alert(isPresented: $showAlert) {
                                
                                Alert(title: Text("Tem certeza?")
                                      ,message: Text("Gostaria de salvar a foto antes de sair ou fazer outra alteração?")
                                      ,primaryButton: .default(Text("Salvar foto")){
                                    shareButton()
                                },secondaryButton: .destructive(Text("Continuar mesmo assim")){
                                    isShowingDetailView = true

                                }
                                      
                                )
                            }
                            
                            
                            
                            
                        
                    
                            
                            
                            
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.corDeFundo)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                                .shadow(color: Color.letratelarestauracao.opacity(0.50), radius: 15, y: 8)
                            VStack(spacing: 5){
                                HStack {
                                    VStack (spacing: 5){
                                        Text("Memória Resgatada!")
                                            .foregroundColor(Color.melhorarfoto)
                                            .font(.custom("Poppins-SemiBold", size: 20))
                                            .font(.title3)
                                        Text("Não pare por aqui:")
                                            .foregroundColor(Color.melhorarfoto)
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
                                        
//                                        Button {
//                                            
//                                        } label: {
//                                            ButtonsView(imgSistema: "arrow.turn.down.left", texto: "Outra Função")
//                                        }
//                                        
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
    
    var eyeButton: some View {
        Button {
            isClicked.toggle()
        } label: {
            Image(systemName: isClicked ? "eye.slash.circle" : "eye.circle")
                .foregroundColor(Color.melhorarfoto)
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

