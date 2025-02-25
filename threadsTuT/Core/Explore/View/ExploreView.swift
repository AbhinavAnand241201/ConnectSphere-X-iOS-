import SwiftUI

struct ExploreView: View {
    @State private var searchedText: String = "" // State variable for search text
    @State private var users: [User] = mockUsers // Mock data for users

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) { // No spacing between cells for a cleaner look
                    ForEach(users.filter { searchedText.isEmpty || $0.username.localizedCaseInsensitiveContains(searchedText) }) { user in
                        UserRow(user: user)
                            .padding(.vertical, 8) // Add vertical padding for spacing
                        Divider() // Add a divider between rows
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchedText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        }
    }
}

// UserRow View
struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            // User Avatar
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1)) // Optional border

            // Username and Follow Status
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.system(size: 16, weight: .bold)) // Bolder font for username
                    .foregroundColor(.primary)
                Text(user.followStatus)
                    .font(.system(size: 14, weight: .regular)) // Regular font for follow status
                    .foregroundColor(.gray)
            }

            Spacer() // Push follow button to the right
        }
        .padding(.horizontal, 16) // Add horizontal padding for better alignment
        .padding(.vertical, 12) // Add vertical padding for better spacing
    }
}

// User Model
struct User: Identifiable {
    let id = UUID()
    let username: String
    let followStatus: String
    let imageName: String // New property for image name
}

// Mock Data with assigned image names
let mockUsers: [User] = [
    User(username: "Max Verstappen", followStatus: "Following", imageName: "max1"),
    User(username: "Lewis Hamilton", followStatus: "Follow", imageName: "max2"),
    User(username: "Charles Leclerc", followStatus: "Follow", imageName: "charles1"),
    User(username: "Lando Norris", followStatus: "Follow", imageName: "charles2"),
    User(username: "Batman", followStatus: "Follow", imageName: "max3"),
    User(username: "Daniel Ricciardo", followStatus: "Follow", imageName: "charles1"),
    User(username: "Sergio Perez", followStatus: "Follow", imageName: "charles2"),
]

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

