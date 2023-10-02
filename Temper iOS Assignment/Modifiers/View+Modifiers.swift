//
//  View+Modifiers.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 30/09/2023.
//

import SwiftUI

struct ShadowConfiguration {
    let color: Color
    let radius: CGFloat
    let position: CGPoint
    
    static var basic: Self {
        .init(color: .black.opacity(0.7), radius: 5, position: CGPoint(x: 0, y: 10))
    }
}

struct CardModifier: ViewModifier {
    let border: Bool
    let cornerRadius: CGFloat
    let fillColor: Color
    let shadowConfiguration: ShadowConfiguration?
    
    func body(content: Content) -> some View {
        if let shadowConfiguration = shadowConfiguration {
            content
                .clipShape(RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                ))
                .background(
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(fillColor)
                    .overlay(border ?  RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    ).stroke(Color.black) : nil)
                    .shadow(
                        color: shadowConfiguration.color,
                        radius: shadowConfiguration.radius,
                        x: shadowConfiguration.position.x,
                        y: shadowConfiguration.position.y
                    )
                )
               
        } else {
            content
                .clipShape(RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                ))
                .background(
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(fillColor)
                    .overlay(border ?  RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    ).stroke(Color.black) : nil)
                )
                
        }
        
    }
}


struct LoaderModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                isLoading ?
                    LoadingView()
                : nil
            )
            .animation(.spring(response: 0.5), value: isLoading)
    }
}
