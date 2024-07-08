//
//  GroupNamePage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData

struct GroupNamePage: View {
    @EnvironmentObject var appData: AppData
    @State private var selectedGroup: Group? = nil
    @State private var groupName: String = ""
    @State private var showingAlert = false
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
                    
                    Button(action: checkGroup) {
                        Text("Lookup Group")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Group Does Not exists."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(isPresented: $navigateToNextPage) {
                if let currGroup = selectedGroup {
                    ResultPage(selectedGroup: currGroup)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea(edges: .horizontal)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func checkGroup() {
        if appData.getGroup(byName: groupName) == nil {
            showingAlert = true
        } else {
            let mapImage = ImageViewModel()
            selectedGroup = appData.getGroup(byName: groupName)
            navigateToNextPage = true
        }
    }
}
