//
//  CachedAsyncImage.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 02/10/2023.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View{
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    
    
    init(url: URL,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cachedImage = AsyncImageCache[url] {
            content(.success(cachedImage))
        } else {
            AsyncImage(url: url, content: { phase in
                    render(phase)
            })
        }
    }
   
    func render(_ phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            AsyncImageCache[url] = image
        }
        
        return content(phase)
    }
}

fileprivate class AsyncImageCache {
    
    static private var cache: [URL: Image] = [:]
    static private let cacheQueue = DispatchQueue(label: "ImageCacheQueue")
    static private var lru: [URL] = [] // Least recently used items
    static private let maxCacheSize = 50 // 200 images to cache to limit memory usage
    
    static subscript(url: URL) -> Image? {
        get {
            return cacheQueue.sync {
                if let image = cache[url] {
                    lru.removeAll { $0 == url }
                    lru.append(url)
                    return image
                }
                return nil
            }
        }
        set {
            cacheQueue.sync {
                cache[url] = newValue
                lru.append(url)
                
                if lru.count > maxCacheSize {
                    let urlToRemove = lru.removeFirst()
                    cache.removeValue(forKey: urlToRemove)
                }
            }
        }
    }
}

//#Preview {
//    CachedAsyncImage()
//}
