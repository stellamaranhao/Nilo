//
//  ImageDetailView.swift
//  Nilo
//
//  Created by Stella Maranhao on 26/10/22.
//
import SwiftUI

struct ImageDetailView: View {
    let image: UIImage
    @State var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0
    @State var isDragging = false
//    @State var panOffset? = nil

    var body: some View {
        
        PhotoView(image: image as UIImage)
//        image
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .cornerRadius(15)
//            .padding(.bottom, UIScreen.main.bounds.height / 4.5)
//            .padding(.horizontal)
//            .scaleEffect(scale)
//            .modifier(ImageResultModifier(contentSize: CGSize(width: UIScreen.main.bounds.width*0.90, height: UIScreen.main.bounds.height*0.90)))
            //.offset(x: panOffset.x, y: panOffset.y)
            //.gesture(magnification)
            //.simultaneousGesture(drag)
    }
    
    func adjustScale(from state: MagnificationGesture.Value) {
        let delta = state / lastScale
        scale *= delta
        lastScale = state
    }
    
    func getMinimumScaleAllowed() -> CGFloat {
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat {
        return min(scale, maxScale)
    }
    
    func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
}




extension CGPoint {
    static func +(lhs:CGPoint, rhs:CGPoint)->CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func +(lhs:CGPoint, rhs:CGSize)->CGPoint {
        return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }
}

extension CGSize {
    var cgPoint:CGPoint {CGPoint(x: self.width, y: self.height)}
}
