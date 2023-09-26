//
//  ContentView.swift
//  LidarVideoDepth
//
//  Created by Triumph on 26/09/2023.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        ZStack {
            FrameView(image: vm.frame)
                .edgesIgnoringSafeArea(.all)
            
            ErrorView(error: vm.error)
            
            ControlView(comicSelected: $vm.comicFilter, monoSelected: $vm.monoFilter, crystalSelected: $vm.crystalFilter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
