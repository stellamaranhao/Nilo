//
//  ColorizeML.swift
//  Nilo
//  Using https://github.com/richzhang/colorization.git converted to coreML
//  Created by Joao Pedro Monteiro Maia on 06/10/22.
//

import Foundation
import UIKit
import CoreML
import AVFoundation

final class ColorizeML:APIProtocol{
    func predictVideo(fromImage image: UIImage, onCompletion completionCallback: @escaping (Result<AVAsset, Error>) -> Void) {
        fatalError("Not supported")
    }
    
    var algorithm: APIAlgorithm = .colorizeML
    
    static let inputDimension = 256
    static let inputSize = CGSize(width: inputDimension, height: inputDimension)
    static let coremlInputShape = [1, 1, NSNumber(value: inputDimension), NSNumber(value: inputDimension)]
    
    func predictImage(fromImage image: UIImage, onCompletion completionCallback: @escaping (Result<UIImage, Error>) -> Void) {
        colorize(image: image)
        { result in
            switch result {
            case .success(let success):
                completionCallback(.success(success))
                
            case .failure(let failure):
                completionCallback(.failure(Error.self as! Error))
                
            }
        }
        
    }
    
    func cancelImage() {
        return
    }
    
    
    
    
    func colorize(image inputImage: UIImage, completion: @escaping (Result<UIImage, Error>) -> Void)  {
        DispatchQueue.background.async {
            let result = self.colorize(image: inputImage)
            DispatchQueue.main.async { completion(result) }
        }
    }
    
    private func colorize(image inputImage: UIImage) -> Result<UIImage, Error> {
        print("Starting colorization")
        do {
            let inputImageLab = try preProcess(inputImage: inputImage)
            let input = try coloriserInput(from: inputImageLab)
            let output = try coremlColorizer(configuration: MLModelConfiguration()).prediction(input: input)
            let outputImageLab = imageLab(from: output, inputImageLab: inputImageLab)
            let resultImage = try postProcess(outputLAB: outputImageLab, inputImage: inputImage)
            return .success(resultImage)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    
    /// Pre-processes the input, resizes an image to the model’s input size (256x256) and converts one from RGB to LAB color space.
    /// - Parameter inputImage: UIimage to be processed
    /// - Returns: Image in LAB color space struct
    private func preProcess(inputImage: UIImage) throws -> LAB {
        guard let lab = inputImage.resizedImage(with: ColorizeML.inputSize)?.toLab() else {
            throw ColorizerError.preprocessFailure
        }
        return LAB(l: lab[0], a: lab[1], b: lab[2])
    }
    
    private func coloriserInput(from imageLab: LAB) throws -> coremlColorizerInput {
        let inputArray = try MLMultiArray(shape: ColorizeML.coremlInputShape, dataType: MLMultiArrayDataType.float32)
        imageLab.l.enumerated().forEach({ (idx, value) in
            let inputIndex = [NSNumber(value: 0), NSNumber(value: 0), NSNumber(value: idx / ColorizeML.inputDimension), NSNumber(value: idx % ColorizeML.inputDimension)]
            inputArray[inputIndex] = value
        })
        return coremlColorizerInput(input1: inputArray)
    }
    
    private func imageLab(from colorizerOutput: coremlColorizerOutput, inputImageLab: LAB) -> LAB {
        var a = [NSNumber]()
        var b = [NSNumber]()
        for idx in 0..<ColorizeML.inputDimension * ColorizeML.inputDimension {
            let aIdx = [NSNumber(value: 0), NSNumber(value: 0), NSNumber(value: idx / ColorizeML.inputDimension), NSNumber(value: idx % ColorizeML.inputDimension)]
            let bIdx = [NSNumber(value: 0), NSNumber(value: 1), NSNumber(value: idx / ColorizeML.inputDimension), NSNumber(value: idx % ColorizeML.inputDimension)]
            a.append(NSNumber(value: colorizerOutput.var_518[aIdx].doubleValue))
            b.append(NSNumber(value: colorizerOutput.var_518[bIdx].doubleValue))
        }
        return LAB(l: inputImageLab.l, a: a, b: b)
    }
    
    private func postProcess(outputLAB: LAB, inputImage: UIImage) throws -> UIImage {
        guard let resultImageLab = UIImage.image(from: [outputLAB.l, outputLAB.a, outputLAB.b], size: ColorizeML.inputSize).resizedImage(with: inputImage.size)?.toLab(),
            let originalImageLab = inputImage.resizedImage(with: inputImage.size)?.toLab() else {
                throw ColorizerError.postprocessFailure
        }
        return UIImage.image(from: [originalImageLab[0], resultImageLab[1], resultImageLab[2]], size: inputImage.size)
    }
    
    
}

///struct representing the  LAB color space
private struct LAB {
    let l, a, b: [NSNumber]
}

private enum ColorizerError: Swift.Error {
    case preprocessFailure
    case postprocessFailure
}
