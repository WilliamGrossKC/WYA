//
//  NewPersonPage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData

struct NewPersonPage: View {
    @EnvironmentObject var appData: AppData
    @State private var selectedGroup: Group? = nil
    @State private var selectedPerson: Person? = nil
    @State private var groupName: String = ""
    @State private var personName: String = ""
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State private var navigateToNextPage = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    TextField("Enter Group Name", text: $groupName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: 300) // Adjust the width of the text field
                    TextField("Enter Person Name", text: $personName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: 300) // Adjust the width of the text field
                    Button(action: checkGroupAndPerson) {
                        Text("Enter Group")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: $showingAlert1) {
                Alert(
                    title: Text("Error"),
                    message: Text("Group does not exists."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $showingAlert2) {
                Alert(
                    title: Text("Error"),
                    message: Text("Name Already in Group."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(isPresented: $navigateToNextPage) {
                if let group = selectedGroup {
                    if let person = selectedPerson {
                        PinPage(currGroup: group, currPerson: person)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func checkGroupAndPerson() {
        if appData.getGroup(byName: groupName) == nil {
            showingAlert1 = true
        } else if appData.getGroup(byName:groupName)?.getPerson(byName: personName) != nil {
            showingAlert2 = true
        } else {
            let newPerson = Person(name: personName)
            appData.getGroup(byName: groupName)?.addPerson(newPerson)
            selectedGroup = appData.getGroup(byName:groupName)
            selectedPerson = newPerson
            navigateToNextPage = true
        }
    }
}


