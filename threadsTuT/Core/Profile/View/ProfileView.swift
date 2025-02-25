// MARK: - Profile Header View
import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    @State private var isEditingProfile = false // Track if editing profile

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Profile Header
                    ProfileHeaderView(isEditingProfile: $isEditingProfile)

                    Divider()

                    // Filter Bar (Threads/Replies)
                    FilterBarView(selectedFilter: $selectedFilter, animation: animation)

                    // Threads/Replies Section
                    ThreadsRepliesView(selectedFilter: selectedFilter)
                }
            }
            .navigationTitle("Profile")
            .background(
                NavigationLink(
                    destination: EditProfileView(isEditingProfile: $isEditingProfile),
                    isActive: $isEditingProfile
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}

// MARK: - Profile Header View
struct ProfileHeaderView: View {
    @Binding var isEditingProfile: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                // User Info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Charles Leclerc")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)

                    Text("charles_leclerc")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)

                    Text("Formula 1 Driver for Scuderia Ferrari")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.primary)
                        .padding(.top, 4)

                    Text("2 followers")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }

                Spacer()

                // Profile Picture
                Image("charles2")
                    .resizable()
                    .scaledToFill()  // Ensures the image fills the frame properly
                    .frame(width: 80, height: 80)
                    .clipShape(Circle()) // Clips the image into a circular shape
                    .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional border

            }

            // Edit Profile Button
            Button(action: {
                isEditingProfile = true // Navigate to EditProfileView
            }) {
                Text("Edit Profile")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
    }
}

// MARK: - Filter Bar View
struct FilterBarView: View {
    @Binding var selectedFilter: ProfileThreadFilter
    var animation: Namespace.ID

    var body: some View {
        HStack {
            ForEach(ProfileThreadFilter.allCases) { filter in
                VStack {
                    Text(filter.title)
                        .font(.system(size: 16, weight: selectedFilter == filter ? .bold : .regular))
                        .foregroundColor(selectedFilter == filter ? .primary : .gray)

                    if selectedFilter == filter {
                        Capsule()
                            .fill(Color.primary)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: 3)
                    }
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedFilter = filter
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Threads/Replies View
struct ThreadsRepliesView: View {
    var selectedFilter: ProfileThreadFilter

    var body: some View {
        VStack(spacing: 16) {
            ForEach(selectedFilter == .threads ? mockThreads1 : mockReplies) { post in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(post.username)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.primary)

                        Spacer()

                        Text(post.timestamp)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                    }

                    Text(post.content)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .cornerRadius(8)
            }
        }
        .padding(.top, 16)
    }
}

// MARK: - Mock Data
struct Post: Identifiable {
    let id = UUID()
    let username: String
    let timestamp: String
    let content: String
}

let mockThreads1: [Post] = [
    Post(username: "charles_leclerc", timestamp: "10m", content: "Home race in Monaco was amazing!"),
    Post(username: "charles_leclerc", timestamp: "11m", content: "Ferrari driver in Formula 1. Trying to win a championship!"),
]

let mockReplies: [Post] = [
    Post(username: "charles_leclerc", timestamp: "12m", content: "Still dominating. Nothing new here. Hoping someone can give me a decent fight"),
    Post(username: "charles_leclerc", timestamp: "3w", content: "Formula 1 champion"),
]

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
