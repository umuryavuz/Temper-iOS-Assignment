//
//  FloatingAccesoryView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 30/09/2023.
//

import SwiftUI

typealias voidAction = () -> ()

enum AccesoryButtonType {
    case filters
    case kaart
    
    var icon: String {
        switch self {
        case .filters:
            "line.3.horizontal.decrease.circle"
        case .kaart:
            "map"
        }
    }
    
    var title: String {
        switch self {
        case .filters:
            "Filters"
        case .kaart:
            "Kaart"
        }
    }
}

struct FloatingAccesoryView: View {
    
    @Namespace var animatorSpace
    
    @State private var toggleFilters: Bool = false
    @State private var toggleKaart: Bool = false
    
    var body: some View {
        ZStack {
            if toggleFilters {
                FilterView(animatorSpace: animatorSpace, toggle: $toggleFilters)
            } else if toggleKaart {
                MapView(animatorSpace: animatorSpace, toggle: $toggleKaart)
            } else {
                actionCard
            }
        }
        .cardBackground()
        .ignoresSafeArea()
        .padding(.bottom, (!toggleFilters && !toggleKaart) ? 180 : 0)
        .padding(.horizontal, toggleFilters ? 16 : 0)
        .padding(.bottom, toggleFilters ? bottomSafeAreaHeight : 0)
    }
    
    var actionCard: some View {
        HStack(spacing: 15) {
            accesoryButton(.filters, action: {
                withAnimation(.spring) {
                    toggleFilters.toggle()
                }
            })
            seperator
            accesoryButton(.kaart, action: {
                withAnimation(.spring) {
                    toggleKaart.toggle()
                }
            })
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func accesoryButton(_ type: AccesoryButtonType, action: @escaping voidAction) -> some View {
        Button(action: action, label: {
            HStack {
                Image(systemName: type.icon)
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "\(type.icon)", in: animatorSpace)
                
                Text(type.title)
                    .fixedSize()
                    .font(.callout)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "\(type.title)", in: animatorSpace)
            }
        })
        .buttonStyle(.plain)
       

    }
    
    var seperator: some View {
        Rectangle()
            .fill(.gray)
            .frame(width: 1, height: 30)
            .padding(.vertical, 2)
    }
}

#Preview {
    FloatingAccesoryView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
