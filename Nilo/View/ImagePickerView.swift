//
//  ImagePickerView.swift
//  Nilo
//
//  Created by Stella Maranhao on 05/10/22.


import UIKit
import SwiftUI

import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: PickedPhoto?
    @Environment(\.presentationMode) var isPresented
    var camera: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        uiViewController.sourceType = context.coordinator.picker.camera ? .camera : .photoLibrary
    }
    
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = PickedPhoto(selectedImage: selectedImage)
        self.picker.isPresented.wrappedValue.dismiss()
        
        //var species: String?PickedPhoto


    }
    
}


