//
//  MapView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import SwiftUI

struct MapView: View {
    
    let animatorSpace: Namespace.ID
    @Binding var toggle: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.clear)
            
            HStack {
                Text(AccesoryButtonType.kaart.title)
                    .fixedSize()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "\(AccesoryButtonType.kaart.title)", in: animatorSpace)


                   
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
                        .matchedGeometryEffect(id: "\(AccesoryButtonType.kaart.icon)", in: animatorSpace)

                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, topSafeAreaHeight)
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .ignoresSafeArea()
    }
}

#Preview {
    @Namespace var namespace
    return MapView(animatorSpace: namespace, toggle: .constant(true))
}
