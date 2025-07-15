//
//  PinPage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData

// MARK: - Custom Pin Shape
struct PinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let circleRadius = rect.width / 2
        let circleCenter = CGPoint(x: rect.midX, y: circleRadius)
        
        // Circle part of the pin
        path.addEllipse(in: CGRect(x: circleCenter.x - circleRadius, y: 0, width: circleRadius * 2, height: circleRadius * 2))
        
        // Triangle part of the pin
        path.move(to: circleCenter)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        path.addLine(to: CGPoint(x: rect.midX - circleRadius, y: circleRadius))
        path.addLine(to: CGPoint(x: rect.midX + circleRadius, y: circleRadius))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        
        return path
    }
}

// MARK: - PinPage View
struct PinPage: View {
    @EnvironmentObject var appData: AppData
    @ObservedObject var currGroup: Group
    @ObservedObject var currPerson: Person
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOffset: CGSize = .zero
    @State private var showingTimePicker = false
    @State private var currentLocation: CGPoint?
    @State private var navigateToNextPage = false

    var body: some View {
        NavigationStack {
            VStack {
                if let selectedImage = currGroup.mapImage.selectedImage {
                    ZStack {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()  // Change to fill the entire screen
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()  // Ensures the image does not overflow
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onEnded { value in
                                        currentLocation = value.location
                                        showingTimePicker = true
                                    }
                            )
                        // Display pins
                        ForEach(currPerson.pins.values.sorted(by: { $0.id.uuidString < $1.id.uuidString }), id: \.id) { pin in
                            PinShape()
                                .fill(Color.red)
                                .frame(width: 15, height: 30)
                                .position(x: pin.location.x, y: pin.location.y)
                        }
                    }
                    .padding()
                } else {
                    // Fallback text if no image is selected
                    Text("No Image Selected")
                        .font(.headline)
                        .foregroundColor(.white)
                }

                // Submit button
                Button(action: { navigateToNextPage = true }) {
                    Text("Submit")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
            .background(Color.black)
            .sheet(isPresented: $showingTimePicker) {
                TimePickerView(
                    onSave: { selectedTime in
                        if let location = currentLocation {
                            addPin(at: location, with: selectedTime)
                        }
                        showingTimePicker = false
                    },
                    onCancel: {
                        showingTimePicker = false
                    }
                )
            }
            .navigationDestination(isPresented: $navigateToNextPage) {
                ResultPage(selectedGroup: currGroup)
            }
        }
    }

    // MARK: - Helper Method to Add Pin
    private func addPin(at location: CGPoint, with time: Date) {
        let pin = Pin(location: location, time: time)
        currPerson.addPin(pin)
    }

}

// MARK: - TimePickerView
struct TimePickerView: View {
    @State private var selectedTime = Date()
    var onSave: (Date) -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            // Date Picker for selecting time
            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()

            HStack {
                // Cancel button
                Button("Cancel") {
                    onCancel()
                }
                .padding()

                // Save button
                Button("Save") {
                    onSave(selectedTime)
                }
                .padding()
            }
        }
        .padding()
    }
}





////
////  PinPage.swift
////  WYA
////
////  Created by William Gross on 6/30/24.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//// Custom Pin Shape
//struct PinShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let circleRadius = rect.width / 2
//        let circleCenter = CGPoint(x: rect.midX, y: circleRadius)
//        
//        // Circle part of the pin
//        path.addEllipse(in: CGRect(x: circleCenter.x - circleRadius, y: 0, width: circleRadius * 2, height: circleRadius * 2))
//        
//        // Triangle part of the pin
//        path.move(to: circleCenter)
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
//        path.addLine(to: CGPoint(x: rect.midX - circleRadius, y: circleRadius))
//        path.addLine(to: CGPoint(x: rect.midX + circleRadius, y: circleRadius))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
//        
//        return path
//    }
//}
//
//// Putting pins page
//struct PinPage: View {
//    @EnvironmentObject var appData: AppData
//    @ObservedObject var currGroup: Group
//    @ObservedObject var currPerson: Person
//    @State private var imageScale: CGFloat = 1.0
//    @State private var imageOffset: CGSize = .zero
//    @State private var showingTimePicker = false
//    @State private var currentLocation: CGPoint?
//    @State private var navigateToNextPage = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                if let selectedImage = currGroup.mapImage.selectedImage {
//                    GeometryReader { geometry in
//                        ZStack {
//                            Image(uiImage: selectedImage)
//                                .resizable()
//                                .scaledToFit()
//                                .gesture(
//                                    DragGesture(minimumDistance: 0)
//                                        .onEnded { value in
//                                            currentLocation = value.location
//                                            showingTimePicker = true
//                                        }
//                                )
//                            
//                            ForEach(currPerson.pins.values.sorted(by: { $0.id.uuidString < $1.id.uuidString }), id: \.id) { pin in
//                                PinShape()
//                                    .fill(Color.red)
//                                    .frame(width: 15, height: 30) // Pin shape size
//                                    .position(x: pin.location.x, y: pin.location.y)
//                            }
//                        }
//                        .frame(width: geometry.size.width, height: geometry.size.height)
//                    }
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                    .padding()
//                } else {
//                    Text("No Image Selected")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                }
//                
//                Button(action: {
//                    navigateToNextPage = true
//                }) {
//                    Text("Submit")
//                        .padding()
//                        .background(Color.purple)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding()
//            }
//            .padding()
//            .background(Color.black)
//            .sheet(isPresented: $showingTimePicker) {
//                TimePickerView(
//                    onSave: { selectedTime in
//                        if let location = currentLocation {
//                            addPin(at: location, with: selectedTime)
//                        }
//                        showingTimePicker = false
//                    },
//                    onCancel: {
//                        showingTimePicker = false
//                    }
//                )
//            }
//            .navigationDestination(isPresented: $navigateToNextPage) {
//                ResultPage(selectedGroup: currGroup)
//            }
//        }
//    }
//
//    private func addPin(at location: CGPoint, with time: Date) {
//        let pin = Pin(location: location, time: time)
//        currPerson.addPin(pin)
//    }
//}
//
//struct TimePickerView: View {
//    @State private var selectedTime = Date()
//    var onSave: (Date) -> Void
//    var onCancel: () -> Void
//
//    var body: some View {
//        VStack {
//            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
//                .datePickerStyle(WheelDatePickerStyle())
//                .labelsHidden()
//
//            HStack {
//                Button("Cancel") {
//                    onCancel()
//                }
//                .padding()
//
//                Button("Save") {
//                    onSave(selectedTime)
//                }
//                .padding()
//            }
//        }
//        .padding()
//    }
//}
