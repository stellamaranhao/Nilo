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
    @State  var isShowingDetailView = false
     var importtake: Bool {imageShown != nil}
    @State  var image = UIImage()
    @State  var showSheet = false
 
    @State  var selectedItem: PhotosPickerItem? = nil
    @State  var selectedImageData: Data? = nil
    @State var imageShown:UIImage?
    @State var options = ["2x", "3x", "5x", "8x"]
    @State var teste = ["Melhor qualidade ", "Mais detalhes e personalidade"]
  
    @State var pickedPhotoName: String = ""
    @State  var selectedOptionPickerQualidade = "One"
    @State  var selectedOptionPickerMelhorias = "One"
    @State  var selectedOptionPickerTeste = "One"
    
    @State var message:String = "GFP-GAN"
    @State var progressMsg:String = "progress: not started"
    let apicolor = ColorizeML()
    
    
    var body: some View {
        VStack{
            //            Text(message).font(.largeTitle)
            Text(progressMsg).font(.subheadline)
            
            if let imageShown = imageShown{
                HStack{
                    Image(uiImage: imageShown)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                }
            }
            if !importtake {
                takePhotoButtom
                importPhotoButtom
            }


            
            //NavigationLink(destination: TelaResultado(imageShown: $imageShown), isActive: $isShowingDetailView) { EmptyView() }
            
            Button(action: {
                
                linkApiRestauracao()
                isShowingDetailView = true
            }){
                Text("Melhorar Foto")
                .padding()
                .foregroundColor(.letratelarestauracao)
                .background(.white)
                .cornerRadius(21)
            }
        }.fullScreenCover(isPresented: $isShowingDetailView){
            //EmptyView()
            //TelaResultado(imageShown: $imageShown)
            TelaResultado()
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



struct ColorirView_Previews: PreviewProvider {
    static var previews: some View {
        ColorirView()
    }
}
