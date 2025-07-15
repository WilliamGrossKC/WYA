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
    @State private var showFirework = true
    @State private var showButtons = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background with white border
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.white, lineWidth: 2)
                    .background(Color.black)
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: 40) { // Increased spacing between elements
                    Image("WYA_LOGO")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300) // Adjust the height as needed
                        .cornerRadius(10)
                    
                    if showButtons {
                        VStack(spacing: 40) {
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
                        }
                        .transition(.opacity)
                        .animation(.easeIn(duration: 1.0), value: showButtons)
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                
                if showFirework {
                    FireworkView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    showFirework = false
                                    showButtons = true
                                }
                            }
                        }
                }
            }
            .onAppear {
                // Call MongoDB connection here when the view appears
                //connectToMongoDB()
            }
        }
    }
}

struct FireworkView: View {
    @State private var particles: [Particle] = []
    @State private var animationStarted = false

    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: 10, height: 10)
                    .position(particle.startPosition)
                    .animation(.easeOut(duration: 1.5), value: animationStarted)
            }
        }
        .onAppear {
            generateParticles()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animationStarted = true
                for index in particles.indices {
                    particles[index].startPosition = particles[index].endPosition
                }
            }
        }
    }

    private func generateParticles() {
        let colors: [Color] = [.red, .blue, .yellow, .green, .orange, .purple]
        let center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
        for _ in 0..<100 {
            let angle = Double.random(in: 0..<360) * Double.pi / 180
            let radius = Double.random(in: 50...150)
            let endX = center.x + CGFloat(cos(angle) * radius)
            let endY = center.y + CGFloat(sin(angle) * radius)
            let color = colors.randomElement() ?? .white
            
            let particle = Particle(
                id: UUID(),
                startPosition: center,
                endPosition: CGPoint(x: endX, y: endY),
                color: color
            )
            particles.append(particle)
        }
    }
}

struct Particle: Identifiable {
    let id: UUID
    var startPosition: CGPoint
    let endPosition: CGPoint
    let color: Color
}















// OLD CODE HERE
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var imageViewModel: ImageViewModel
//    
//    @StateObject private var appData = AppData()
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 40) { // Increased spacing between elements
////                Text("WYA")
////                    .font(.largeTitle)
////                    .padding()
////                    .background(Color.blue)
////                    .foregroundColor(.white) // Ensure the text is visible on the blue background
////                    .cornerRadius(10)
//                Image("WYA_LOGO")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300) // Adjust the height as needed
//
//                    .cornerRadius(10)
//                
//                NavigationLink(destination: GroupNamePage()) {
//                    Text("Check Group")
//                        .font(.title) // Larger text
//                        .frame(width: 200, height: 60) // Bigger and square shape
//                        .background(Color.pink)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                NavigationLink(destination: NewPersonPage()) {
//                    Text("Join Group")
//                        .font(.title) // Larger text
//                        .frame(width: 200, height: 60) // Bigger and square shape
//                        .background(Color.purple)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                NavigationLink(destination: UploadGroupInfoPage()) {
//                    Text("Create Group")
//                        .font(.title) // Larger text
//                        .frame(width: 200, height: 60) // Bigger and square shape
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                Spacer()
//            }
//            .padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black)
//            .ignoresSafeArea(edges: .horizontal)
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        .environmentObject(ImageViewModel())
//        .environmentObject(AppData())
//}
