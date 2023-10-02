//
//  FilterView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import SwiftUI

struct FilterView: View {
    
    let animatorSpace: Namespace.ID
    @Binding var toggle: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.clear)
                .frame(height: 400)
            
            HStack {
                Text(AccesoryButtonType.filters.title)
                    .fixedSize()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "\(AccesoryButtonType.filters.title)", in: animatorSpace)


                   
                Spacer()
                
                Button(action: {
                    withAnimation(.spring) {
                        toggle.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .foregroundColor(.green)
                        .transition(.scale)
                        .matchedGeometryEffect(id: "\(AccesoryButtonType.filters.icon)", in: animatorSpace)

                })
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
    }
}

#Preview {
    @Namespace var namespace
    return FilterView(animatorSpace: namespace, toggle: .constant(true))
}
