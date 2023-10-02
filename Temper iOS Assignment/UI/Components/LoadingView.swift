//
//  LoadingView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 02/10/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        GeometryReader { geo in
            ProgressView()
                .tint(.white)
                .scaleEffect(1.5)
                .background(
                    Color.black
                        .opacity(0.3)
                        .frame(width: geo.size.width, height: geo.size.height)
                )
                .position(x: geo.size.width/2,y: geo.size.height/2)
                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
