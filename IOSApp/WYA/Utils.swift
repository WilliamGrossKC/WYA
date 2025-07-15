//
//  Utils.swift
//  WYA
//
//  Created by William Gross on 7/1/24.
//

import Foundation
import SwiftUI
import UIKit

struct CenteredTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
                
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)]
            }
    }
}

extension View {
    func centeredTitle() -> some View {
        self.modifier(CenteredTitleModifier())
    }
}
