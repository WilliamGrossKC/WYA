//
//  ResultPage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData

struct ResultPage: View {
    @EnvironmentObject var appData: AppData
    @State private var selectedPerson: Person?
    @StateObject private var selectedGroup: Group
    @State private var selectedPin: Pin?

    init(selectedGroup: Group) {
        self._selectedGroup = StateObject(wrappedValue: selectedGroup)
        configureNavigationBar()
    }

    var body: some View {
        SwiftUI.Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // iPad layout using NavigationSplitView
                NavigationSplitView {
                    List {
                        ForEach(selectedGroup.members.values.sorted(by: { $0.name < $1.name }), id: \.name) { person in
                            Button(action: {
                                selectedPerson = person
                            }) {
                                Text(person.name)
                            }
                        }
                    }
                    .listStyle(SidebarListStyle())
                    .navigationTitle("Members")
                } detail: {
                    VStack {
                        if let person = selectedPerson, let image = selectedGroup.mapImage.selectedImage {
                            GroupImageView(image: image, pins: Array(person.pins.values), selectedPin: $selectedPin)
                                .overlay(
                                    selectedPin.map { pin in
                                        GeometryReader { geometry in
                                            VStack {
                                                Text("Time: \(pin.time?.formatted() ?? "N/A")")
                                                    .padding()
                                                    .background(Color.white)
                                                    .cornerRadius(8)
                                                    .shadow(radius: 5)
                                                    .shadow(radius: 5)
                                                    .fixedSize()
                                            }
                                            // .position(x: pin.location.x, y: pin.location.y - 20)
                                            .position(
                                                x: clampedPosition(value: pin.location.x, minValue: 100, maxValue: geometry.size.width - 100),
                                                y: clampedPosition(value: pin.location.y, minValue: 100, maxValue: geometry.size.height - 100)
                                            )
                                        }
                                    }
                                )
                        } else {
                            Text("Select a person to view details")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle(selectedGroup.groupName)
                    .centeredTitle()
                }
            } else {
                // iPhone layout using NavigationView
                NavigationView {
                    List {
                        ForEach(selectedGroup.members.values.sorted(by: { $0.name < $1.name }), id: \.name) { person in
                            NavigationLink(destination: DetailView(person: person, selectedGroup: selectedGroup, selectedPin: $selectedPin)) {
                                Text(person.name)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Members")
                    .colorScheme(.dark)
                    .foregroundColor(.white)
                    .background(Color.black)
                }
            }
        }
    }
                                    
    private func clampedPosition(value: CGFloat, minValue: CGFloat, maxValue: CGFloat) -> CGFloat {
        return min(max(value, minValue), maxValue)
    }
                                    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct DetailView: View {
    let person: Person
    let selectedGroup: Group
    @Binding var selectedPin: Pin?

    var body: some View {
        VStack {
            if let image = selectedGroup.mapImage.selectedImage {
                GroupImageView(image: image, pins: Array(person.pins.values), selectedPin: $selectedPin)
                    .overlay(
                        selectedPin.map { pin in
                            VStack {
                                Text("Time: \(pin.time?.formatted() ?? "N/A")")
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 5)
                            }
                            .position(x: pin.location.x, y: pin.location.y - 20)
                        }
                    )
            } else {
                Text("No image available")
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .foregroundColor(.white)
        .colorScheme(.dark)
        .navigationTitle(person.name)
    }
}

struct GroupImageView: View {
    let image: UIImage
    let pins: [Pin]
    @Binding var selectedPin: Pin?
    @State private var navigateToNextPage = false

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()  // Change to fill the entire screen
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(
                            ForEach(pins) { pin in
                                PinShape()
                                    .fill(Color.red)
                                    .frame(width: 15, height: 30)
                                    .position(x: pin.location.x, y: pin.location.y)
                                    .onTapGesture {
                                        selectedPin = pin
                                    }
                            }
                        )
                }
                Button(action: {
                    navigateToNextPage = true
                }) {
                    Text("Edit")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
