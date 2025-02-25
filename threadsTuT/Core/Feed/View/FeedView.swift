import SwiftUI

struct FeedView: View {
    @State private var threads: [Thread] = mockThreads // Mock data for threads
    @State private var isRefreshing = false // Track refresh state

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) { // Remove spacing between cells for a cleaner look
                    ForEach($threads) { $thread in
                        ThreadCell(thread: $thread)
                            .padding(.vertical, 8) // Add vertical padding for spacing
                    }
                }
            }
            .refreshable {
                // Simulate a refresh action
                await refreshThreads()
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Manual refresh action
                        Task {
                            await refreshThreads()
                        }
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 18, weight: .medium)) // Slightly larger refresh icon
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }

    // Function to simulate refreshing threads
    private func refreshThreads() async {
        isRefreshing = true
        // Simulate a network request delay
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        threads = mockThreads.shuffled() // Shuffle mock data for demonstration
        isRefreshing = false
    }
}

// ThreadCell View
struct ThreadCell: View {
    @Binding var thread: Thread // Use @Binding to update the thread's liked state

    var body: some View {
        VStack(alignment: .leading, spacing: 12) { // Increased spacing for better readability
            HStack(alignment: .top) {
                // User Avatar (Dynamically Assigned)
                Image(thread.avatar)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle()) // Make avatar circular
                    .foregroundColor(.gray)

                // Username and Timestamp
                VStack(alignment: .leading, spacing: 4) {
                    Text(thread.username)
                        .font(.system(size: 16, weight: .bold)) // Bolder font for username
                        .foregroundColor(.primary)
                    Text(thread.timestamp)
                        .font(.system(size: 14, weight: .regular)) // Better font for timestamp
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            // Thread Content
            Text(thread.content)
                .font(.system(size: 16, weight: .medium)) // Bolder font for content
                .foregroundColor(.primary)
                .lineLimit(3) // Limit to 3 lines for preview
                .padding(.top, 4) // Add padding to separate content from username

            // Thread Actions (Like, Comment, Share, etc.)
            HStack(spacing: 24) { // Increased spacing between action buttons
                Button(action: {
                    thread.isLiked.toggle() // Toggle the liked state
                }) {
                    Image(systemName: thread.isLiked ? "heart.fill" : "heart") // Change icon based on state
                        .font(.system(size: 18, weight: .regular)) // Better font for icons
                        .foregroundColor(thread.isLiked ? .red : .gray) // Change color based on state
                }
                Button(action: {}) {
                    Image(systemName: "bubble.right")
                        .font(.system(size: 18, weight: .regular)) // Better font for icons
                }
                Button(action: {}) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 18, weight: .regular)) // Share icon
                }
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18, weight: .regular)) // More options icon
                }
                Spacer()
            }
            .foregroundColor(.gray)
            .padding(.top, 8) // Add padding to separate actions from content
        }
        .padding(.horizontal, 16) // Add horizontal padding for better alignment
        .padding(.vertical, 12) // Add vertical padding for better spacing
        .background(Color(.systemBackground)) // Use system background color
    }
}

// Thread Model
struct Thread: Identifiable {
    let id = UUID()
    let username: String
    let timestamp: String
    let content: String
    let avatar: String // Added property for avatar image
    var isLiked: Bool = false // Track if the thread is liked
}

// Updated Mock Data with Different Avatars
let mockThreads: [Thread] = [
    Thread(username: "charles_leclerc", timestamp: "10m", content: "Home race in Monaco was amazing!", avatar: "charles1"),
    Thread(username: "charles_leclerc", timestamp: "11m", content: "Ferrari driver in Formula 1. Trying to win a championship!", avatar: "charles2"),
    Thread(username: "maxverstappen1", timestamp: "12m", content: "Still dominating. Nothing new here. Hoping someone can give me a decent fight", avatar: "max1"),
    Thread(username: "maxverstappen1", timestamp: "3w", content: "Formula 1 champion", avatar: "max2"),
    Thread(username: "maxverstappen1", timestamp: "3w", content: "This season feels easy to be honest...", avatar: "max3"),
]

// Preview
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

