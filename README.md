# Movie Discovery App

A simple iOS app built with **Swift & UIKit** that allows users to **discover movies**, **search**, and **view movie details**. Users can also **save movies as favorites** for quick access later.

## Features
-  **Movie Listing**: Fetches and displays popular movies from TMDB API.
-  **Search Functionality**: Search for movies dynamically.
-  **Movie Detail View**: Displays full movie details (title, overview, release date, and poster).
-  **Favorites System**: Allows users to save and manage favorite movies.
-  **Image Caching**: Uses `NSCache` to optimize poster image loading.
-  **Unit Tests**: Includes ViewModel unit tests with a mock movie service.

## Architecture
The project follows the **MVVM (Model-View-ViewModel) architecture** for better separation of concerns:

```
MovieDiscoveryApp/
│── Models/          # Data models (MovieAPIResponse)
│── Services/        # Handles networking (MovieService, NetworkManager)
│── ViewModels/      # Business logic and state management (MovieListViewModel)
│── Views/           # UI Components (ViewControllers, Custom Cells)
│── Utilities/       # Helper classes (ImageCacheManager, FavMoviesManager)
│── Tests/           # Unit Tests (MovieListViewModelTests)
│── Resources/       # Assets, Launch Screen
│── App/             # AppDelegate, SceneDelegate
```

## Setup & Installation
### Prerequisites
- **Xcode 14+**
- **iOS 15+** Simulator or Device
- **TMDB API Key** (Get one from [TMDB](https://www.themoviedb.org/))

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_GITHUB_USERNAME/MovieDiscoveryApp.git
   cd MovieDiscoveryApp
   ```
2. Open `MovieDiscoveryApp.xcodeproj` in Xcode.
3. Add your **TMDB API Key** in `MovieService.swift`:
   ```swift
   private let apiKey = "YOUR_API_KEY"
   ```
4. Run the app on a **simulator or real device** (`Cmd + R`).
5. Run tests with:
   ```bash
   Cmd + U  # Runs unit tests in Xcode
   ```

## 🛠 Dependencies & Technologies
- **UIKit** for UI
- **URLSession** for networking
- **NSCache** for image caching
- **UserDefaults** for storing favorites
- **Unit Testing** with `XCTest`
