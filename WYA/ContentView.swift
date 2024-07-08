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
            VStack(spacing: 40) { // Increased spacing between elements
                Text("WYA")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white) // Ensure the text is visible on the blue background
                    .cornerRadius(10)
                
                NavigationLink(destination: GroupNamePage()) {
                    Text("Check Group")
                        .font(.title) // Larger text
                        .frame(width: 200, height: 60) // Bigger and square shape
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: NewPersonPage()) {
                    Text("Join Group")
                        .font(.title) // Larger text
                        .frame(width: 200, height: 60) // Bigger and square shape
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: UploadGroupInfoPage()) {
                    Text("Create Group")
                        .font(.title) // Larger text
                        .frame(width: 200, height: 60) // Bigger and square shape
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .ignoresSafeArea(edges: .horizontal)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(ImageViewModel())
        .environmentObject(AppData())
}
