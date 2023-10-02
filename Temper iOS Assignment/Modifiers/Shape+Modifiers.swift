//
//  Shape+Modifier.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CustomBackgroundShape: Shape {
    
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.minX - cornerRadius * 2, y: rect.maxY))
        
        
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                          control: CGPoint(x: rect.minX - 2, y: rect.maxY - 2))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius * 2 + 2, y: rect.minY),
                          control: CGPoint(x: rect.minX + 2, y: rect.minY + 2))
        
        
        path.addLine(to: CGPoint(x: rect.minX , y: rect.minY ))
        
        return path
    }
}
