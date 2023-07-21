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
    
    @EnvironmentObject var notifyModel: NotifyModel
    
    var body: some View {
        VStack {
            HStack {
                Slider()
                    .frame(width: sliderViewWidth)
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width:emptyViewWidth)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct MainView: View {
    @State private var isDragging = false
    @State private var direction: DragDirection = .unknow
    
    @GestureState var state = false
    @EnvironmentObject private var notify: NotifyModel
    
    private enum DragDirection {
        case unknow
        case left, right
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 0)
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
            .onEnded { g in
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
    @EnvironmentObject var notifyModel: NotifyModel
    @State var expaned2: Bool = false
    let const:CGFloat = 0.9
    var body: some View {
        NavigationStack {
            
            VStack {
                
                List {
                    
                    Section {
                        ForEach (0 ..< 5) {
                            index in
                            HStack {
                                Image(systemName: "slider.horizontal.2.square")
                                Text("celll")
                                    .font(.callout)
                                    .foregroundStyle(Color.black)
                            }
                            .listRowSeparator(.hidden)
                        }
                        
                    } header: {
                        HStack {
                            Text("Recently Visted")
                                .font(.callout)
                                .foregroundStyle(Color.black)
                            Text("See all")
                                .foregroundStyle(Color.black)
                                .font(.caption)
                        }
                    }
                    
                    
                    Section(isExpanded: $expaned2) {
                        ForEach (0 ..< 20) {
                            index in
                            HStack {
                                Image(systemName: "sun.haze.fill")
                                Text("celll")
                                    .font(.callout)
                                    .foregroundStyle(Color.black)
                                Spacer()
                                Image(systemName: "star")
                            }
                            .listRowSeparator(.hidden)
                        }
                        
                    } header: {
                        HStack {
                            Text("Your Community")
                                .font(.callout)
                                .foregroundStyle(Color.black)
                            Spacer()
                           Image(systemName: "chevron.right")
                                .rotationEffect(.degrees(expaned2 ? 90 : 0))
                                .animation(.bouncy, value: expaned2)
                        }
                        .onTapGesture {
                            expaned2.toggle()
                        }
                       
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .scaleEffect(
                    .init(
                        width: ( notifyModel.mainViewOffsetX / sliderViewWidth / 10 + const),
                        height: ( notifyModel.mainViewOffsetX / sliderViewWidth / 10 + const)
                    ),
                    anchor: .center
                )
            }
        }
    }
}

#Preview {
    ContentView()
//    Slider()
//        .environmentObject(NotifyModel())
}
