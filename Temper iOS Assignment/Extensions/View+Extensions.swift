//
//  View+Extension.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 30/09/2023.
//

import Foundation
import SwiftUI

extension View {
    func cardBackground(
        border: Bool = false,
        cornerRadius: CGFloat = 25.0,
        fillColor: Color = .white,
        shadowConfiguration: ShadowConfiguration? = .basic
    ) -> some View {
        self.modifier(
            CardModifier(
                border: border,
                cornerRadius: cornerRadius,
                fillColor: fillColor,
                shadowConfiguration: shadowConfiguration
            )
        )
    }
    
    func customCornerShape(_ radius: CGFloat) -> some View {
        self.clipShape(CustomBackgroundShape(cornerRadius: radius))
    }
    
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func loader(_ isLoading: Binding<Bool>) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
