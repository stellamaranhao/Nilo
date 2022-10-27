//
//  ColorirView.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 17/10/22.
//

import Foundation

import SwiftUI
import PhotosUI

struct ColorirView: View {
    @State var showingTutorial:Bool
    @State private var isShowingDetailView = false
    private var importtake: Bool {imageShown != nil}
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var imageShown:UIImage?
    @State var options = ["2x", "3x", "5x", "8x"]
    @State var teste = ["Melhor qualidade ", "Mais detalhes e personalidade"]

    @State var oldImage: UIImage?
  
    @State var pickedPhotoName: String = ""
    @State private var selectedOptionPickerQualidade = "One"
    @State private var selectedOptionPickerMelhorias = "One"
    @State private var selectedOptionPickerTeste = "One"
    
    @State var message:String = "GFP-GAN"
    @State var progressMsg:String = "progress: not started"
    let apicolor = ColorizeML()
    var body: some View {
        NavigationView{
            VStack{
                //            Text(message).font(.largeTitle)

                
                if let imageShown = imageShown{
                    HStack{
                        Image(uiImage: imageShown)
                            .resizable()
                            .scaledToFit()
                            .scaledToFill()
                            .cornerRadius(8)
                            .frame(width: 214, height: 476)
                            .padding(.bottom, 80)
                        
                    }
                }
                if !importtake {
                    takePhotoButtom
                    importPhotoButtom
                }
                
                 
                NavigationLink(destination: CarregandoView(selectedItem: $selectedItem, oldImage: $oldImage, selectedImageData: $selectedImageData,imageShown: $imageShown,showingTutorial: showingTutorial, showingMyself: $isShowingDetailView, apiUsada: ColorizeML()), isActive: $isShowingDetailView) { EmptyView() }
                
                Button(action: {
                    
                    linkApiRestauracao()
                    isShowingDetailView = true
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.melhorarfoto)
                            .frame(width: 200, height: 70)
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                        Text("Melhorar Foto")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title2)
                            .font(.custom("Poppins-SemiBold", size: 20))
                    }
                    .padding(.bottom,50)
                    }.disabled((imageShown != nil) ? false : true)
                }
            }
        
       
    }
    
    var takePhotoButtom: some View {
        ZStack{
            Image("tirarFoto")//rever
                .position(x: 325, y: 40)
                .background(
                    RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                        .frame(width: 275, height: 200)
                        .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8))
           
             
                    Text("Tirar uma Foto")
                        .foregroundColor(.letratelarestauracao)
                        .fontWeight(.bold)
                        .font(.title2)
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .onTapGesture {
                        showSheet = true
                        }
                        .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .camera, selectedImage: self.$image)
                                                    }
                .onChange(of: image) { newItem in
                    imageShown = newItem
//                        Task {
                        // Retrieve selected asset in the form of Data
//                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                                selectedImageData = data
//                                imageShown = UIImage(data: selectedImageData!)
//                            }
//                        }
                }
             
        }
    }
    var importPhotoButtom: some View{

        ZStack{
            Image("importarFoto")//rever
                .position(x: 325, y: 40)
                .background(
                    RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                        .frame(width: 275, height: 200)
                        .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8))
            PhotosPicker(
                
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    
                    Text("Importar uma Foto")
                        .foregroundColor(.letratelarestauracao)
                        .fontWeight(.bold)
                        .font(.title2)
                        .font(.custom("Poppins-SemiBold", size: 20))
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                            imageShown = UIImage(data: selectedImageData!)
                        }
                    }
                }
            
        }
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


