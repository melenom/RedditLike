//
//  NotifyModel.swift
//  RedditLikeAPP
//
//  Created by melenom on 2023/7/21.
//

import SwiftUI
import Combine

class NotifyModel: ObservableObject {
    @Published var showSlider: Bool = false {
        didSet {
            mainViewOffsetX = showSlider ? UIScreen.main.bounds.width * 0.75 : 0
        }
    }
    @Published var mainViewOffsetX: CGFloat = .zero
}
