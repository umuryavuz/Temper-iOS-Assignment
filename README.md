# Temper-iOS-Assignment
## Table of Contents
- [Technologies Used](#technologies-used)
  - [UIKit](#uikit)
  - [SwiftUI](#swiftui)
  - [Asynchronous Programming](#asynchronous-programming)
  - [Architecture](#architecture)
  - [Dependency Injection](#dependency-injection)
  - [Network Layer](#network-layer)
- [Known Issues / Limitations](#known-issues--limitations)
  - [Image Caching](#image-caching)
  - [API Response Handling](#api-response-handling)
- [Potential Improvements](#potential-improvements)
  - [Image Caching](#image-caching-1)
  - [Repository Errors and ViewModels](#repository-errors-and-viewmodels)
- [External Libraries Used](#external-libraries-used)

## Technologies Used
In this project, SwiftUI and UIKit are used as a hybrid to build up the UI of the project. 

### UIKit
UIKit is mainly used for containing navigation controllers and normal controllers. 

### SwiftUI
SwiftUI is used to fill up those UIKit containers with actual view components. 

Custom modifiers and extensions are stored in separate files in corresponding folders. 

LazyVStack in a ScrollView is used to ensure a smooth user experience and resource management by:
- lazily loading listing items
- unloading off-screen items
- not loading unseen items

### Asynchronous Programming
Swift Concurrency is used for async functions from NetworkLayer to Repository, ensuring code cleanliness and a native approach simultaneously.

Combine is used to subscribe to dynamic data from repositories to ensure that data manipulation is not done in ViewModels. 

### Architecture
MVVM + Coordinator architecture is used to conform to data-UI connection and app-wide navigational control. 

Coordinators allow us to navigate through the app using UIKit-based presentations. 

### Dependency Injection
Dependency injection is made to ensure code simplicity and separation of concern. 

Repositories are used for handling scenario-specific data manipulation. In this project, data manipulation is for receiving requested data from the Network Layer.
After that, a Published variable is to be subscribed to for use cases. 

Repositories are stored in a Dependency Container (a single class) and are injected into the ViewModel to be used by the Main Coordinator. 

The ViewModel used in this project is completely separated from data manipulation and is only responsible for handling received data from the corresponding repository. 

### Network Layer
The Network Layer is a generic package to handle all kinds of network requests.

A generic model type T is used to ensure that the mapping model is also given in use cases. 

Network-related errors are handled inside the Network Layer, and subscription to these errors is optional. 

## Known Issues / Limitations

### Image Caching
Images are cached in a customly made CacheAsyncImage component, which is a fork of SwiftUI's AsyncImage. 
Caching is performed by a fileprivate class containing a static subscript, which is where the storing is performed. 
The method used for caching uses a FIFO (first-in, first-out) methodology, which might not be the best use case for user experience. 

### API Response Handling
Data objects used in this project are made this way to ensure they are not the same solution as the given example in the project document. 
Not using a decoder with pre-defined coding keys leads to many structs for inner JSON objects, which may not be the best solution if most of the data will not be used. 

## Potential Improvements
### Image Caching
One approach to improve image caching while maintaining UX might be listening to scroll direction. 
By listening to the direction, we can also change the direction of how FIFO affects the LRU (least recently used) array. This way, we ensure that when scrolling up, the cache eviction process will start removing the images left in the opposite direction. 

### Repository Errors and ViewModels
As mentioned before, error handling is performed separately in corresponding scopes; the errors related to Repositories might concern the UI as well. In this project, error handling in the ListingRepository is only handled by printing out the error descriptions.
What we can do is convert the getListing method to a throwing function, and further errors emitted from this function can be caught in ViewModels, which can be used to adjust the UI accordingly. 

## External Libraries Used
Alamofire - Network Module
