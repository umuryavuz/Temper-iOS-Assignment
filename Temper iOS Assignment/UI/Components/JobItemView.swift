//
//  JobItemView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 30/09/2023.
//

import SwiftUI

struct JobItemView: View {
    
    let listing: Listing
    
    internal var imageHeight: CGFloat = 220
    internal var cardBackgroundCornerRadius: CGFloat = 10
    internal var mainSpacing: CGFloat = 10
    internal var footerSpacing: CGFloat = 5
    internal var placeholderImage: String = "questionmark"
    
    @State private var isImageLoaded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: mainSpacing) {
            
            CachedAsyncImage(url: listing.job.clientImage) {
                phase in
                switch phase {
                case .success(let image):
                    GeometryReader { geometry in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: min(geometry.size.height, imageHeight))
                            .clipped()
                    }
                case .failure(_):
                    Image(systemName: placeholderImage)
                        .resizable()
                case .empty:
                    ProgressView()
                        .tint(.green)
                @unknown default:
                    Image(systemName: placeholderImage)
                        .resizable()
                }
            }
            .frame(height: imageHeight)
            .frame(maxWidth: .infinity)
            .cardBackground(border: false, cornerRadius: cardBackgroundCornerRadius, fillColor: .white, shadowConfiguration: nil)
            .overlay(
                earningOverlay(listing.earningsPerHour)
            )
            info(listing)
            
        }
        .padding(.vertical, 15)
        
    }
    
    @ViewBuilder
    func earningOverlay(_ earning: (amount: Double, currency: Currency)) -> some View {
        GeometryReader { geo in
            ZStack {
                Text("\(earning.currency.sign) \(String(format: "%.2f", earning.amount) )")
                    .foregroundStyle(Color.black)
                    .font(.subheadline.bold())
                    .frame(maxHeight: 30)
                    .padding(.horizontal, 5)
                    .background(Color.white.customCornerShape(8))
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomTrailing)
        }
    }
    
    @ViewBuilder
    func info(_ listing: Listing) -> some View {
        VStack(alignment: .leading, spacing: footerSpacing) {
            Text("\(listing.job.categoryLocalized)  \u{2022}  \(listing.job.distance) km")
                .foregroundStyle(Color.purple)
                .font(.footnote.bold())
            
            Text("\(listing.job.clientName)")
                .foregroundStyle(Color.black)
                .font(.headline)
            
            Text("\(listing.startAt.format(.hourAndMin24h)) - \(listing.endsAt.format(.hourAndMin24h))")
                .foregroundStyle(Color.black)
                .font(.callout)
        }
    }
    
}

#Preview {
    JobItemView(
        listing: try! Listing(
            dto: ListingDTO(
                id: "1",
                startsAt: "",
                endsAt: "",
                earningsPerHour: ListingDTO.EarningsPerHour(
                    currency: "EUR",
                    amount: 15),
                job: JobDTO(
                    id: "",
                    title: "",
                    project: JobDTO.ProjectDTO(
                        client: JobDTO.ClientDTO(
                            name: "hELLO",
                            links: JobDTO.ClientDTO.LinksDTO.init(
                                heroImage: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/115928.jpg",
                                thumbImage: "")
                        )
                    ),
                    category: JobDTO.CategoryDTO(
                        nameTranslation: JobDTO.CategoryDTO.NameTranslationDTO(
                            en_GB: "Hello"
                        )
                    ), address: JobDTO.AddressDTO(
                        coordinates: JobDTO.AddressDTO.CoordinatesDTO(
                            latitude: 0,
                            longitude: 0
                        )
                    )
                )
            )
        )
    )
}

