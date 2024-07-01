////
////  InfoPage.swift
////  WYA
////
////  Created by William Gross on 6/30/24.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//
//struct UploadImagePage: View {
//    @EnvironmentObject var imageViewModel: ImageViewModel
//    @State private var isImagePickerPresented = false
//    
//    var body: some View {
//        VStack {
//            if let selectedImage = imageViewModel.selectedImage {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                Text("Group Name")
//                NavigationLink(destination: PinPage()) {
//                    Text("Next")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                
//            } else {
//                Text("No Image Selected")
//                    .font(.headline)
//            }
//            Button(action: {
//                isImagePickerPresented = true
//            }) {
//                Text("Upload Image")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .sheet(isPresented: $isImagePickerPresented) {
//                ImagePicker(image: $imageViewModel.selectedImage)
//            }
//        }
//        .padding()
//    }
//}
//
//// ImagePicker struct to handle image selection
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//        
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
