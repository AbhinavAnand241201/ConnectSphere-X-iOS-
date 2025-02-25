//
//  TabBarView.swift
//  threadsTuT
//
//  Created by ABHINAV ANAND  on 14/02/25.
//


import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0 // Tracks the selected tab

    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: Feed View
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    Text("Home")
                }
                .onAppear { selectedTab = 0 }
                .tag(0)

            // Tab 2: Explore
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                .onAppear { selectedTab = 1 }
                .tag(1)

            // Tab 3: Upload Thread
            Text("Upload Thread")
                .tabItem {
                    Image(systemName: "plus")
                    Text("Upload")
                }
                .onAppear { selectedTab = 2 }
                .tag(2)

            // Tab 4: Activity
            Text("Activity")
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                    Text("Activity")
                }
                .onAppear { selectedTab = 3 }
                .tag(3)

            // Tab 5: Profile
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                    Text("Profile")
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }
        .tint(.black) // Set the tab bar item tint color to black
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
