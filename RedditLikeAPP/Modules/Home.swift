//
//  Home.swift
//  RedditLikeAPP
//
//  Created by melenom on 2023/7/21.
//

import SwiftUI

struct Home: View {
    @State private var selection: Int = 0
    var body: some View {
        
            TabView(selection: $selection) {
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(1)
                    .tabItem {
                        Label("Discovery", systemImage: "suit.diamond").tint(.black)
                    }
                Rectangle()
                    .foregroundStyle(.green)
                    .badge(0)
                    .tag(2)
                    .tabItem {
                        Label("Create", systemImage: "plus")
                    }
                Rectangle()
                    .foregroundStyle(.gray)
                    .badge(0)
                    .tag(3)
                    .tabItem {
                        Label("Chat", systemImage: "captions.bubble")
                    }
                Rectangle()
                    .foregroundStyle(.orange)
                    .badge(0)
                    .tag(4)
                    .tabItem {
                        Label("Inbox", systemImage: "bell")
                    }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
       
        
    }
}

#Preview {
    Home()
}
