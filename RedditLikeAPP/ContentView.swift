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
    
    
    var body: some View {
        ZStack {
            SliderView()
            MainView()
                
        }
    }
}

struct SliderView: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.blue)
                .ignoresSafeArea()
                .frame(width: sliderViewWidth)
            Rectangle()
                .foregroundStyle(.clear)
                .frame(width:emptyViewWidth)
        }
    }
}

struct MainView: View {
    @State private var isDragging = false
    @State private var direction: DragDirection = .unknow
    @State private var action: DragAction = .hideSliderView
    @State private var mainViewOffsetX: CGFloat = .zero
    
    private enum DragDirection {
        case unknow
        case left, right
    }
    
    private enum DragAction {
        case showSliderView
        case hideSliderView
    }
    
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { g in
                let w = g.translation.width
                direction = w > 0 ? .right : .left
                
                let startPoint = g.startLocation
                if action == .showSliderView && startPoint.x >= sliderViewWidth  && direction == .left {
                    
                    mainViewOffsetX = sliderViewWidth - abs(w)
                    mainViewOffsetX = mainViewOffsetX < 0 ? 0 : mainViewOffsetX
                }
                else if action == .hideSliderView && startPoint.x >= 0 && startPoint.x <= 30 && direction == .right{
                    mainViewOffsetX = abs(w)
                    mainViewOffsetX = mainViewOffsetX > sliderViewWidth ? sliderViewWidth : abs(w)
                }
                self.isDragging = true
            }
            .onEnded { _ in
                self.isDragging = false
                
                if action == .showSliderView {
                    mainViewOffsetX = mainViewOffsetX < screenWidth - 20 ? 0 : sliderViewWidth
                    action = mainViewOffsetX < screenWidth - 20 ? .hideSliderView : .showSliderView
                }
                else if action == .hideSliderView {
                    mainViewOffsetX = mainViewOffsetX >= 20 ? sliderViewWidth : 0
                    action = mainViewOffsetX >= 20 ? .showSliderView : .hideSliderView
                }
            }
    }
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.red)
            .ignoresSafeArea()
            .offset(x: mainViewOffsetX)
            .gesture(drag)
            .animation(.easeInOut(duration: 0.1), value: mainViewOffsetX)
    }
}



#Preview {
    ContentView()
}
