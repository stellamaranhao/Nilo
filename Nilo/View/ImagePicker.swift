//
//  ImagePicker.swift
//  Nilo
//
//  Created by Stella Maranhao on 05/10/22.
//

import Foundation

import PhotosUI
import SwiftUI
import MapKit
extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var pickedPhoto: PickedPhoto?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let photoLibrary = PHPhotoLibrary.shared()
        var config = PHPickerConfiguration(photoLibrary: photoLibrary)
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let firstResult = results.first else { return }
            let provider = firstResult.itemProvider
            
//            if let assetId = firstResult.assetIdentifier {
//                let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
//                DispatchQueue.main.async {
////                    print(assetResults.firstObject)
//                    self.parent.date = assetResults.firstObject?.creationDate
//                    assetResults.firstObject?.location?.fetchCityAndCountry { city, country, error in
//                            guard let city = city, let country = country, error == nil else { return }
//                            self.parent.location =  city + ", " + country  // Rio de Janeiro, Brazil
//                        }
////                    self.parent.location = assetResults.firstObject?.location?.coordinate
//                }
//            }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    guard let image = image as? UIImage else { fatalError() }
                    
                    //var species: String?
                    self.parent.pickedPhoto = PickedPhoto(selectedImage: image)
                }
            }
            
        }
    }
}
