# Temper-iOS-Assignment
## Table of Contents
- [Technologies Used](#technologies-used)
  - [UIKit](#uikit)
  - [SwiftUI](#swiftui)
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
In this project SwiftUI and UIKit is used as hybrid to build up the UI of the project. 

### UIKit
UIKit is mainly used for containing navgiation controllers and normal controllers. 

### SwiftUI
SwiftUI is used for fill up those UIKit continers with actualy view components. 
Custom modifiers and Extension are stored in seperate files in correspoing folders. 

### Arhitecture
MVVM + Coordinator architecture is used to conform data - UI connection and app wise navigational control. 
Coordinators allow us to navigate through the app using UIKit based presentations. 

### Dependency injection
Dependency injection is also made to make sure code simplicity and seperation of concern. 
Repositories are used for handling scenario speficic data manupilation. In this project data manipulation is to receving requested data from Network Layer.
After that, a Published variable is to be subscribed for use cases. 

Repositories are stored in Dependency Container (single class) and is injected to the viewModel to be used by the Main Coordinator. 

ViewModel used in this project is completely seperated from data manipulation only responsible for handling recevied data from corresponding repository. 

### Network Layer
Network layer is a generic package to handle all kind of network requests.
A generic modal type T is used to ensure the mapping modal is also given in usecases. 
Network related errors are handled inside the NetworkLayer and subscription to these errors are optional. 

## Known Issues / Limitations

### Image Caching
Images are cached in customly made CacheAsyncImage component which is a fork of SwiftUI AsyncImage. 
Caching is made by a fileprivate class contains static subscript, which is where the storing is performed. 
Method used for caching using FIFO (first in first out) methodology which might not be the best usecase for user experince. 

### API Response Handling
Data objects used in this project made this way to ensure its not the same solution with the given example in the project document. 
Not using a decoder with pre-defined coding keys, leads to many Structs for inner json objects, which may not be a best solution if most of the data will not be used. 

## Potential Improvements
### Image Caching
One approach to improve image caching and keeping UX still at the same time might be listening to scroll direction. 
By listening the direction, we can also change direction of how FIFO effect the LRU(least recently used) array. This way we make sure that when scroll up, cache eviction process will start removing the images left in the opposite direction. 

### Repository Errors and ViewModels
As I said before about error handling perform seperately in corresponding scopes, the errors related to Repositories might concerning UI as well. In this project error handling in ListingRepository is only handled by printing out the error descriptions.
What we can do is converting getListing method to throw function and further errors emitted from this function can be catched in ViewModels, which can be used to show them or adjust the UI accordingly. 

## External Libraries Used
Alamofire - Network Module
