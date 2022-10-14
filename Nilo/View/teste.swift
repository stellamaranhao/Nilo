//
//  teste.swift
//  Nilo
//
//  Created by Stella Maranhao on 13/10/22.
//
import SwiftUI

import Foundation
@State private var showingImagePicker = false
showingImagePicker = true
@State private var inputImage: UIImage?
func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
}
    .onChange(of: inputImage) { _ in loadImage() }
    .sheet(isPresented: $showingImagePicker) {
        ImagePicker(image: $inputImage)
    }
