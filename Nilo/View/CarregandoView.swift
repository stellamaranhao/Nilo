//
//  CarregandoView.swift
//  Nilo
//
//  Created by Stella Maranhao on 20/10/22.
//

import SwiftUI
import PhotosUI

struct CarregandoView: View{
    @State private var isShowingDetailView = false
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var oldImage: UIImage?
    @Binding var selectedImageData: Data?
    @Binding var imageShown:UIImage?
    @State var isClicked: Bool = false
    @State private var shared = false
    @State var showAlert:Bool = false
    @State var showingTutorial:Bool
    
    @Binding var showingMyself:Bool
    
    var apiUsada:APIProtocol
    

    
    @State private var image : Bool = true
    @State private var spinXLarge = false
    
    var body: some View {
       
            ZStack{
                
                Color.fundoEsperaView
                    .ignoresSafeArea()
                
                VStack{
                    
                    NavigationLink(destination: TelaResultado3(selectedItem: $selectedItem, oldImage: $oldImage, selectedImageData: $selectedImageData,imageShown: $imageShown,showingTutorial: showingTutorial), isActive: $isShowingDetailView) { EmptyView() }
                    
                    
                    Image("WaitingScreen")
                        .padding(.bottom,80)
                        .animation(.default)
                    
                    ProgressView()
                        .tint(.corTexto)
                        .padding(.bottom,30)
//                        .background(.red)
   
                    Text("   Por favor não feche o app!\nEstamos melhorando sua foto. ")
                        .bold()
                        .foregroundColor(.corTexto)
                        .padding(.bottom,80)
//                    ZStack{
//                        Button {
//                            print("presed na tela de carregar \(showingMyself)")
//                            showingMyself = false
//                        } label: {
//                            ZStack{
//                                RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
//                                    .frame(width: 181, height: 42)
//                                    .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
//
//                                Text("Cancelar")
//                                    .foregroundColor(.letratelarestauracao)
//                                    .fontWeight(.light)
//                                    .font(.title2)
//                                .font(.custom("Poppins-SemiBold", size: 20))
//
//                            }
//                        }
//
//                    }
                }
            }.onAppear
            {
                linkApiRestauracao()
            }
            
        
    }
    
    func linkApiRestauracao (){
        if let image = imageShown{
            apiUsada.predictImage(fromImage: image)
            { result in
                switch result {
                case .success(let success):
                    imageShown = success
                    print("foi")
                    isShowingDetailView = true
                    //return imageShown!
                    
                case .failure(let failure):
                    print(failure.asString)
                    //return nil
                }
                
                
            }
        }
        
    }

            }
//struct CarregandoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarregandoView()
//    }
//}

