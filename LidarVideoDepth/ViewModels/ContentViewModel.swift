//
//  ContentViewModel.swift
//  LidarVideoDepth
//
//  Created by Triumph on 26/09/2023.
//

import CoreImage

class ContentViewModel: ObservableObject {
    
    @Published var frame: CGImage?
    @Published var error: Error?
    
    private let frameManager = FrameManager.shared
    private let cameraManager = CameraManager.shared
    
    var comicFilter = false
    var monoFilter = false
    var crystalFilter = false
    private let context = CIContext()

    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { cvPixelBuffer in
                guard let cgImage = CGImage.create(from: cvPixelBuffer) else { return nil }
                var ciImage = CIImage(cgImage: cgImage)
                
                if self.comicFilter {
                    ciImage = ciImage.applyingFilter(CIFilter.CIComicEffect.rawValue)
                }
                
                if self.monoFilter {
                    ciImage = ciImage.applyingFilter(CIFilter.CIPhotoEffectNoir.rawValue)
                }
                
                if self.crystalFilter {
                    ciImage = ciImage.applyingFilter(CIFilter.CICrystallize.rawValue)
                }
                
                return self.context.createCGImage(ciImage, from: ciImage.extent)
            }
            .assign(to: &$frame)
        
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map{ $0 }
            .assign(to: &$error)
    }
}
