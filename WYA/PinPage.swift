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
                    GeometryReader { geometry in
                        ZStack {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onEnded { value in
                                            currentLocation = value.location
                                            showingTimePicker = true
                                        }
                                )
                            
                            ForEach(currPerson.pins.values.sorted(by: { $0.id.uuidString < $1.id.uuidString }), id: \.id) { pin in
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
                
                Button(action: {
                    navigateToNextPage = true
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
            }
            .padding()
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

    private func addPin(at location: CGPoint, with time: Date) {
        let pin = Pin(location: location, time: time)
        currPerson.addPin(pin)
    }
}

struct TimePickerView: View {
    @State private var selectedTime = Date()
    var onSave: (Date) -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()

            HStack {
                Button("Cancel") {
                    onCancel()
                }
                .padding()

                Button("Save") {
                    onSave(selectedTime)
                }
                .padding()
            }
        }
        .padding()
    }
}
