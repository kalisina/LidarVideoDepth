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
    
    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { cvPixelBuffer in
                return CGImage.create(from: cvPixelBuffer)
            }
            .assign(to: &$frame)
        
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map{ $0 }
            .assign(to: &$error)
    }
}



