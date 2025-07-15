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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(ImageViewModel())
                .environmentObject(AppData())
        }
    }
}
