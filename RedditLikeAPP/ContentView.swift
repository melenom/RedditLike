//
//  ContentView.swift
//  RedditLikeAPP
//
//  Created by melenom on 2023/7/21.
//

import SwiftUI
//import OSLog
private let screenWidth = UIScreen.main.bounds.width
private let sliderViewWidth = UIScreen.main.bounds.width * 0.75
private let emptyViewWidth = UIScreen.main.bounds.width * 0.25

struct ContentView: View {
    let model = NotifyModel()
    
    var body: some View {
        ZStack {
            SliderView()
            MainView()
        }
        .environmentObject(model)
    }
}

struct SliderView: View {
    var body: some View {
        HStack {
            Slider()
                .frame(width: sliderViewWidth)
                .transition(.scale(0.4, anchor: .center))
            Rectangle()
                .foregroundStyle(.blue)
                .frame(width:emptyViewWidth)
        }
    }
}

struct MainView: View {
    @State private var isDragging = false
    @State private var direction: DragDirection = .unknow
    
    
    @EnvironmentObject private var notify: NotifyModel
    
    private enum DragDirection {
        case unknow
        case left, right
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { g in
                let w = g.translation.width
                direction = w > 0 ? .right : .left
                
                let startPoint = g.startLocation
                if notify.showSlider && startPoint.x >= sliderViewWidth  && direction == .left {
                    
                    notify.mainViewOffsetX = sliderViewWidth - abs(w)
                    notify.mainViewOffsetX = notify.mainViewOffsetX < 0 ? 0 : notify.mainViewOffsetX
                }
                else if !notify.showSlider && startPoint.x >= 0 && startPoint.x <= 30 && direction == .right{
                    notify.mainViewOffsetX = abs(w)
                    notify.mainViewOffsetX = notify.mainViewOffsetX > sliderViewWidth ? sliderViewWidth : abs(w)
                }
                self.isDragging = true
            }
            .onEnded { _ in
                self.isDragging = false
                
                if notify.showSlider {
                    notify.mainViewOffsetX = notify.mainViewOffsetX < screenWidth - 20 ? 0 : sliderViewWidth
                    notify.showSlider = notify.mainViewOffsetX < screenWidth - 20 ? false : true
                }
                else if !notify.showSlider {
                    notify.mainViewOffsetX = notify.mainViewOffsetX >= 20 ? sliderViewWidth : 0
                    notify.showSlider = notify.mainViewOffsetX >= 20 ? true : false
                }
            }
    }
    
    var body: some View {
        Main()
            .offset(x: notify.mainViewOffsetX)
            .gesture(drag)
            .animation(.easeInOut(duration: 0.1), value: notify.mainViewOffsetX)
    }
}

struct Slider: View {
    var body: some View {
        VStack {
            List {
                Text("celll")
                Text("celll")
                Text("celll")
                Text("celll")
                Text("celll")
                Text("celll")
            }
        }
        .background(Color.green)
    }
}

#Preview {
    ContentView()
}
