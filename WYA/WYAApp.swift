//
//  WYAApp.swift
//  WYA
//
//  Created by William Gross on 6/17/24.
//

import SwiftUI

@main
struct WYAApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var imageViewModel = ImageViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(imageViewModel)
                .environmentObject(AppData())
        }
    }
}
