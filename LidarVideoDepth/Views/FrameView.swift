//
//  FrameView.swift
//  LidarVideoDepth
//
//  Created by Triumph on 26/09/2023.
//

import SwiftUI

struct FrameView: View {
  
  var image: CGImage?
  private let label = Text("Camera Feed")
  
    var body: some View {
      if let image = image {
        GeometryReader { geometry in
          Image(image, scale: 1.0, orientation: .upMirrored, label: label) // use .up for the back camera
            .resizable()
            .scaledToFit()
            .frame(
              width: geometry.size.width,
              height: geometry.size.height,
              alignment: .center)
            .clipped()
        }
      } else {
        Color.black
      }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
