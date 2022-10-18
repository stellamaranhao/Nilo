//
//  ColorirViewTakePhoto.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 18/10/22.
//

import Foundation
import SwiftUI

extension ColorirView{
    
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
    
}
