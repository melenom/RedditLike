//
//  Main.swift
//  RedditLikeAPP
//
//  Created by melenom on 2023/7/21.
//

import SwiftUI

struct Main: View {
    @State private var selection: Int = 0
    @EnvironmentObject var notify: NotifyModel
    
    private var gradientColor = LinearGradient(colors: [.blue, .green], startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1, y: 0.5))
    private var normalColor: Color = .cyan
    
    var body: some View {
        NavigationStack{
            VStack {
                TabView(selection: $selection) {
                    Rectangle()
                        .background(normalColor, ignoresSafeAreaEdges: .top)
                        .foregroundStyle(.red)
                        .badge(0)
                        .tag(0)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        
                    Rectangle()
                        .background(gradientColor, ignoresSafeAreaEdges: .top)
                        .foregroundStyle(.blue)
                        .tag(1)
                        .tabItem {
                            Label("Discovery", systemImage: "suit.diamond").tint(.black)
                        }
                    Rectangle()
                        .background(normalColor, ignoresSafeAreaEdges: .top)
                        .foregroundStyle(.green)
                        .badge(0)
                        .tag(2)
                        .tabItem {
                            Label("Create", systemImage: "plus")
                        }
                    Rectangle()
                        .background(normalColor, ignoresSafeAreaEdges: .top)
                        .foregroundStyle(.gray)
                        .badge(0)
                        .tag(3)
                        .tabItem {
                            Label("Chat", systemImage: "captions.bubble")
                        }
                    Rectangle()
                        .background(normalColor, ignoresSafeAreaEdges: .top)
                        .foregroundStyle(.orange)
                        .badge(0)
                        .tag(4)
                        .tabItem {
                            Label("Inbox", systemImage: "bell")
                        }
                }
            }
            //.navigationBarTitleDisplayMode(.inline)
            //.navigationTitle("asd")
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        notify.showSlider.toggle()
                    } label: {
                        Image(systemName: "text.line.first.and.arrowtriangle.forward")
                    }
                }
            }
        }
        
       
    }
}

#Preview {
    Main()
}
