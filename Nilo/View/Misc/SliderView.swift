//
//  SliderView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
// https://stackoverflow.com/questions/68608382/before-after-image-slider-in-swiftui

import SwiftUI

struct SliderView: View {
    
    var imageBeforeName:String
    var imageAferName:String

@State private var location: CGPoint = CGPoint(x: 0, y: 0)
@State private var maskWidth: CGFloat = 0.0

@State var startPoint: CGFloat = 0
@State var endPoint: CGFloat = 0
@State var yPoint: CGFloat = 0

var sliderWidth: CGFloat = 30
var containerWidth: CGFloat
var containerHeight: CGFloat 

var body: some View {
    
    ZStack {
        
        ZStack() {
            Image(imageBeforeName)
                .resizable()
                .frame(width: containerWidth, height: containerHeight)
                .background(Color.red)
                .clipped()
            
            Image(imageAferName)
                .resizable()
                .frame(width: containerWidth, height: containerHeight)
                .clipped()
                .background(Color.green)
                .mask(mask)
        }
        .clipped()
        
        Slider
        
    }
    .clipped()
    .frame(width: containerWidth, height: containerHeight)
    .onAppear {
        yPoint = containerHeight/2
        location = CGPoint(x: containerWidth/2, y: yPoint)
        maskWidth = containerWidth/2
        endPoint = containerWidth
    }
}

var dragAction: some Gesture {
    DragGesture()
        .onChanged { value in
            updateDragView(point: value.location)
            updateMaskView(point: value.translation)
        }
        .onEnded { value in
            setInitialPosition()
        }
}

var mask: some View {
    HStack {
        Spacer()
        Rectangle()
            .mask(Color.black)
            .frame(width: maskWidth, height: containerHeight)
    }
}

var Slider: some View {
    VStack(spacing: 0) {
        Rectangle()
            .fill(Color.white)
            .frame(width: 4)
        Image(systemName: "circle.circle.fill")
            .foregroundColor(.white)
            .frame(width: sliderWidth, height: sliderWidth)
            .font(.system(size: sliderWidth))
        Rectangle()
            .fill(Color.white)
            .frame(width: 4)
    }
    .position(location)
    .gesture(dragAction)
    .shadow(radius: 4)
}

func updateDragView(point: CGPoint) {
    let locX = point.x
    if locX > startPoint && locX < endPoint {
        self.location = CGPoint(x: point.x, y: yPoint)
    }
}

func updateMaskView(point: CGSize) {
    let width = -(point.width)
    let newWidth = ((containerWidth/2)+width)
    if newWidth > 0 {
        maskWidth = ((containerWidth/2)+width)
    } else {
        setInitialPosition()
    }
}

func setInitialPosition() {
    withAnimation {
        location = CGPoint(x: containerWidth/2, y: yPoint)
        maskWidth = containerWidth/2
    }
}
}

