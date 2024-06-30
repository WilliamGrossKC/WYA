//
//  Classes.swift
//  WYA
//
//  Created by William Gross on 6/19/24.
//

import Foundation
import SwiftUI
import CoreData

struct Pin: Identifiable {
    let id = UUID()
    let location: CGPoint
    // var time: Date
}

class ImageViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var pins: [Pin] = []
    
//    func updatePin(_ pin: Pin, withTime time: Date) {
//        if let index = pins.firstIndex(where: { $0.id == pin.id }) {
//            pins[index].time = time
//        }
//    }
}
