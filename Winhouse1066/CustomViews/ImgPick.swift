import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var imageString: String?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator () -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectImage = info[.editedImage] as? UIImage{
                let date = Date()
                let imgStr = "blaze\(date)"
                saveImage(image: selectImage, withName: imgStr)
                self.parent.imageString = imgStr
            }
            
            picker.dismiss(animated: true)
        }
        
        func saveImage(image: UIImage, withName name: String) {
            if let data = image.jpegData(compressionQuality: 1.0) {
                if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = url.appendingPathComponent(name)
                    do {
                        try data.write(to: fileURL)
                    } catch {
                        print("Error saving image: \(error)")
                    }
                }
            }
        }
    }
    
}

