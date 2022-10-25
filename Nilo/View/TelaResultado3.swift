//
//  TelaResultado3.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 21/10/22.
//

import SwiftUI
import PhotosUI

struct TelaResultado3: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var oldImage: UIImage?
    @Binding var selectedImageData: Data?
    @Binding var imageShown:UIImage?
    @State var isClicked: Bool = false
    @State private var showingAlert = false
 //   @State var savePic: Bool = false

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
                    if (!isClicked) {
                        Image(uiImage: imageShown!)
                        // Image("ImageAnne")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .padding(.bottom, UIScreen.main.bounds.height / 4.5)
                            .padding(.horizontal)
                          //  .background(RoundedRectangle(cornerRadius: 15))
                    } else {
                        Image(uiImage: oldImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .padding(.bottom, UIScreen.main.bounds.height / 4.5)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        VStack {
                            NavigationLink(destination: MenuView()) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 40))
                                    .padding(.top, UIScreen.main.bounds.height / 20)
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
                                .fill(Color.corDeFundo)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                            VStack(spacing: 18){
                                HStack {
                                    VStack (spacing: 5){
                                        Text("Memória Resgatada!")
                                            .foregroundColor(Color.corTexto)
                                            .font(.custom("Poppins-SemiBold", size: 20))
                                            .fontWeight(.bold)
                                            .font(.title3)
                                        Text("Não pare por aqui:")
                                            .foregroundColor(Color.corTexto)
                                            .font(.custom("Poppins-Regular", size: 16))
                                            .fontWeight(.ultraLight)
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
                                        //    savePic = true
                                        } label: {
                                            ButtonsView(imgSistema: "square.and.arrow.up", texto: "Exportar memória")
                                        }
                                        
                                        Button {
                                                linkApiRestauracao()
                                        } label: {
                                           
                                            ButtonsView(imgSistema: "paintbrush.pointed", texto: "Colorir memória")
                                        }
                                        
                                        NavigationLink(destination: RestauracaoView()) {
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
    var eyeButton: some View {
        Button {
            isClicked.toggle()
        } label: {
            Image(systemName: isClicked ? "eye.slash.circle" : "eye.circle")
                .foregroundColor(Color.corTexto)
                .font(.system(size: 40))
                .padding(.trailing, UIScreen.main.bounds.width / 10)
        }


    }
    
    func shareButton() {
        //        let image = Image(uiImage: imageShown!)
        
        let activityController = UIActivityViewController(activityItems: [imageShown!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
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
