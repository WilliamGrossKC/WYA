//
//  NewPersonPage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData

enum NewPersonAlertType: Identifiable {
    case groupNotExist
    case nameAlreadyInGroup

    var id: Int {
        self.hashValue
    }
}

struct NewPersonPage: View {
    @EnvironmentObject var appData: AppData
    @State private var selectedGroup: Group? = nil
    @State private var selectedPerson: Person? = nil
    @State private var groupName: String = ""
    @State private var personName: String = ""
    @State private var navigateToNextPage = false
    @State private var activeAlert: NewPersonAlertType?

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    TextField("Enter Group Name", text: $groupName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: 220) // Adjust the width of the text field
                    TextField("Enter Person Name", text: $personName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: 220) // Adjust the width of the text field
                    Button(action: checkGroupAndPerson) {
                        Text("Enter Group")
                            .padding()
                            .font(.title)
                            .frame(width: 200, height: 60)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
            .padding()
            .alert(item: $activeAlert) { alertType in
                switch alertType {
                case .groupNotExist:
                    return Alert(
                        title: Text("Error"),
                        message: Text("Group does not exist."),
                        dismissButton: .default(Text("OK"))
                    )
                case .nameAlreadyInGroup:
                    return Alert(
                        title: Text("Error"),
                        message: Text("Name already in group."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .navigationDestination(isPresented: $navigateToNextPage) {
                if let group = selectedGroup, let person = selectedPerson {
                    PinPage(currGroup: group, currPerson: person)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea(edges: .horizontal)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func checkGroupAndPerson() {
        if appData.getGroup(byName: groupName) == nil {
            print("Group does not exist")
            activeAlert = .groupNotExist
        } else if appData.getGroup(byName: groupName)?.getPerson(byName: personName) != nil {
            print("Name already in group")
            activeAlert = .nameAlreadyInGroup
        } else {
            print("Proceeding to add person to group")
            let newPerson = Person(name: personName)
            appData.getGroup(byName: groupName)?.addPerson(newPerson)
            selectedGroup = appData.getGroup(byName: groupName)
            selectedPerson = newPerson
            navigateToNextPage = true
        }
    }
}

