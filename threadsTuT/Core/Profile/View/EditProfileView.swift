import SwiftUI

struct EditProfileView: View {
    @State private var name: String = "Charles Leclerc"
    @State private var username: String = "charles_leclerc"
    @State private var bio: String = "Formula 1 Driver for Scuderia Ferrari"
    @State private var profileImage: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @Binding var isEditingProfile: Bool // Binding to control navigation

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Profile Picture
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image("charles2")
                                .resizable()
                                .scaledToFill()  // Ensures the image fills the frame properly
                                .frame(width: 80, height: 80)
                                .clipShape(Circle()) // Clips the image into a circular shape
                                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional border

                        }
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $inputImage)
                    }

                    // Name Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Enter your name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    // Username Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Enter your username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    // Bio Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bio")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Enter your bio", text: $bio)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                saveProfileChanges()
                isEditingProfile = false // Navigate back to ProfileView
            })
            .navigationBarBackButtonHidden(true) // Disable back button
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }

    func saveProfileChanges() {
        // Save the profile changes here
        print("Name: \(name)")
        print("Username: \(username)")
        print("Bio: \(bio)")
        // You can also upload the profile image to your server
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(isEditingProfile: .constant(true))
    }
}
