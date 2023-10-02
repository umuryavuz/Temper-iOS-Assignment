//
//  JobListView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 30/09/2023.
//

import SwiftUI

struct ListingsView: View {
    
    @ObservedObject var viewModel: ListingViewModel
    
    // MARK: Scroll Configurations
    internal var scrollContentBottomPadding: CGFloat = 100
    internal var scrollContentHorizontalPadding: CGFloat = 16
    
    @State private var showScrollToTop: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
        
            BottomButtonsView(action: viewModel.showAuthentication(type:))
            
            FloatingAccesoryView()
        }
        .animation(.spring(response: 0.3), value: showScrollToTop)
        .onAppear(perform: viewModel.onAppear)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    var content: some View {
        ScrollViewReader { reader in
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    EmptyView().id("top")
                    ForEach(Array((viewModel.listings ?? [:]).keys.sorted()), id: \.self) { date in
                        if let listings = viewModel.listings?[date] {
                            listingSection(by: listings, date: date)
                        }
                    }
                    
                    if let _ = viewModel.listings {
                        ProgressView()
                            .tint(.black)
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.horizontal, scrollContentHorizontalPadding)
                .padding(.bottom, scrollContentBottomPadding)
            }
            .refreshable {
                viewModel.refreshListing()
            }
            .foregroundStyle(.black)
            .padding(.top, topSafeAreaHeight)
            .loader($viewModel.isLoading)
            .overlay(
                showScrollToTop ? scrollToTopButton({
                    withAnimation {
                        reader.scrollTo("top", anchor: .top)
                        showScrollToTop = false
                    }
                }) : nil
            )
        }
    }
    
    @ViewBuilder
    func listingSection(by listings: [Listing], date: Date) -> some View {
        Section(header: sectionHeader(date: date)){
            ForEach(listings) { listing in
                JobItemView(listing: listing)
                    .task {
                        if listing == listings.last &&
                            date.format(.dashedDate) == viewModel.lastFetchDate.format(.dashedDate)
                        {
                            await viewModel.loadMore()
                        }
                        if let index = listings.firstIndex(of: listing) {
                            showScrollToTop = index >= 5
                        }
                    }
            }
        }
        
        
    }
    
    @ViewBuilder
    func sectionHeader(date: Date) -> some View {
        HStack {
            Text("\(date.format(.dayMonthReadable))")
                .foregroundStyle(.black)
                .font(.headline)
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .cardBackground(fillColor: .green)
            Spacer()
        }
    
    }
    
    @ViewBuilder
    func scrollToTopButton(_ action: @escaping voidAction) -> some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Button(action: action, label: {
                Image(systemName: "arrowshape.up.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
            })
            .background(
                Circle()
                .fill(Color.green)
                .padding(-8)
                .shadow(color: .black, radius: 5, y: 5)
            )
        }
        .padding(.top, topSafeAreaHeight + 10)
        .padding(.trailing, 32)
        .transition(.opacity)
    }
}

#Preview("Listing View") {
    ListingsView(
        viewModel: ListingViewModel(
            coordinator: MainCoordinator(
                dependencyContainer: .shared,
                parentController: UINavigationController()
            ),
            listingRepository: ListingRepository(networkLayer: DependencyContainer.shared.networkLayer)
        )
    )
}
