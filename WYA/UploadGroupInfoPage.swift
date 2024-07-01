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
    @State private var groupName: String = ""
    @State private var newGroup = Group(groupName: "", mapImage: ImageViewModel())
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            TextField("Enter Group Name", text: $groupName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(maxWidth: 300) // Adjust the width of the text field
            
            
            if let selectedImage = newGroup.mapImage.selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                NavigationLink(destination: ResultPage(selectedGroup: newGroup)) {
                    Text("Continue")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
            } else {
                Text("No Image Selected")
                    .font(.headline)
            }
            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Upload Image")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $newGroup.mapImage.selectedImage)
            }
            
            Button(action: addGroup) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
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
        .padding()
    }
    
    private func addGroup() {
        if appData.getGroup(byName: groupName) != nil {
            showingAlert1 = true
        } else if newGroup.mapImage.selectedImage == nil{
            showingAlert2 = true
        } else {
            newGroup.groupName = groupName
            appData.addGroup(newGroup)
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
