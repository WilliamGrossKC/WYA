//
//  UploadGroupInfoPage.swift
//  WYA
//
//  Created by William Gross on 6/30/24.
//

import Foundation
import SwiftUI
import CoreData


struct UploadGroupInfoPage: View {
    @EnvironmentObject var appData: AppData
    @StateObject private var newGroup = Group(groupName: "", mapImage: ImageViewModel())
    @State private var groupName: String = ""
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State private var isImagePickerPresented = false
    @State private var addSuccess = false
    
    var body: some View {
        VStack {
            TextField("Enter Group Name", text: $groupName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(maxWidth: 220) // Adjust the width of the text field
            
            
            if newGroup.mapImage.selectedImage != nil {
                Text("Image Currently Selected")
                    .font(.headline)
                    .foregroundColor(.white)
            } else {
                Text("No Image Selected")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Upload Image")
                    .padding()
                    .font(.title)
                    .frame(width: 200, height: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $newGroup.mapImage.selectedImage)
            }
            .padding()
            Button(action: addGroup) {
                Text("Submit Group")
                    .padding()
                    .font(.title)
                    .frame(width: 200, height: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .alert(isPresented: $showingAlert1) {
            Alert(
                title: Text("Error"),
                message: Text("Group already exists."),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $showingAlert2) {
            Alert(
                title: Text("Error"),
                message: Text("Image not uploaded"),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationDestination(isPresented: $addSuccess) {
            ResultPage(selectedGroup: newGroup)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea(edges: .horizontal)
    }
    
    private func addGroup() {
        if appData.getGroup(byName: groupName) != nil {
            showingAlert1 = true
        } else if newGroup.mapImage.selectedImage == nil {
            showingAlert2 = true
        } else {
            newGroup.groupName = groupName
            appData.addGroup(newGroup)
            addSuccess = true
        }
    }
}

// ImagePicker struct to handle image selection
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
