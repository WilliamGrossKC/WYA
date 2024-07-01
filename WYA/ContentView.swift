//  ContentView.swift
//  WYA
//
//  Created by William Gross on 6/17/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var imageViewModel: ImageViewModel
    
    @StateObject private var appData = AppData()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("WYA")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                
                NavigationLink(destination: GroupNamePage()) {
                    Text("Check Group")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: NewPersonPage()) {
                    Text("Join Group")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: UploadGroupInfoPage()) {
                    Text("Create Group")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(ImageViewModel())
        .environmentObject(AppData())
}
