// ShimmerPlaceholderView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct ShimmerPlaceholderView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 170, height: 200)
                .modifier(ShimmerEffect())
//            VStack {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 150, height: 20)
//                    .modifier(ShimmerEffect())
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 150, height: 20)
//                    .modifier(ShimmerEffect())
//            }
        }
    }
}
