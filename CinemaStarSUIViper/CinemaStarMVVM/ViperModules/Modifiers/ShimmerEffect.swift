// ShimmerEffect.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var isAnimating = false
    @State private var gradient = Gradient(colors: [Color.clear, Color.white.opacity(0.5), Color.clear])
    @State private var startPoint = UnitPoint(x: -10, y: 0.5)
    @State private var endPoint = UnitPoint(x: 10, y: 0.5)

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray, Color.gray.opacity(0.5)]),
                    startPoint: isAnimating ? .leading : .trailing,
                    endPoint: isAnimating ? .trailing : .leading
                )
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false), value: isAnimating)
            )
            .onAppear {
                isAnimating = true
            }
    }
}
