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
    var time: Date?
}

class ImageViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
}

class Person: ObservableObject {
    @Published var name: String
    @Published var pins: [UUID: Pin] = [:] // Using a dictionary for pins with String keys

    init(name: String, pins: [Pin] = []) {
        self.name = name
        self.pins = Dictionary(uniqueKeysWithValues: pins.map { ($0.id, $0) })
    }
    
    // Add a pin to the person
    func addPin(_ pin: Pin) {
        pins[pin.id] = pin
    }
    
    // Get a pin by ID
    func getPin(byID id: UUID) -> Pin? {
        return pins[id]
    }
    
    // Delete a pin by ID
    func deletePin(byID id: UUID) {
        pins.removeValue(forKey: id)
    }
}

class Group: ObservableObject {
    @Published var groupName: String
    @Published var mapImage: ImageViewModel
    @Published var members: [String: Person] = [:] // Using a dictionary for members
    
    init(groupName: String, mapImage: ImageViewModel) {
        self.groupName = groupName
        self.mapImage = mapImage
    }
    
    // Add a person to the group
    func addPerson(_ person: Person) {
        members[person.name] = person
    }
    
    // Get a person by name
    func getPerson(byName name: String) -> Person? {
        return members[name]
    }
    
    // Delete a person by name
    func deletePerson(byName name: String) {
        members.removeValue(forKey: name)
    }
}

class AppData: ObservableObject {
    @Published var data: [String: Group] = [:] // Using a dictionary for groups
    
    // Add a group
    func addGroup(_ group: Group) {
        data[group.groupName] = group
    }
    
    // Get a group by name
    func getGroup(byName name: String) -> Group? {
        return data[name]
    }
    
    // Delete a group by name
    func deleteGroup(byName name: String) {
        data.removeValue(forKey: name)
    }
}




