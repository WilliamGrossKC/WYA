//
//  PinPage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData


// Putting pins page
struct PinPage: View {
    @EnvironmentObject var imageViewModel: ImageViewModel
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOffset: CGSize = .zero

    var body: some View {
        VStack {
            if let selectedImage = imageViewModel.selectedImage {
                GeometryReader { geometry in
                    ZStack {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onEnded { value in
                                        addPin(at: value.location, in: geometry.size)
                                    }
                            )

                        ForEach(imageViewModel.pins) { pin in
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .position(x: pin.location.x, y: pin.location.y)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            } else {
                Text("No Image Selected")
                    .font(.headline)
            }
        }
        .padding()
    }

    private func addPin(at location: CGPoint, in size: CGSize) {
        let pin = Pin(location: location)
        imageViewModel.pins.append(pin)
    }
}
