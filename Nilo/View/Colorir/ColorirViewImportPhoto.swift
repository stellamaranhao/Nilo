//
//  ColorirViewImportPhoto.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 18/10/22.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

extension ColorirView{
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
}
