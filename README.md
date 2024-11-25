![App Icon](https://i.sstatic.net/3GV5CYBl.png)

# FiveSquare Project

This project demonstrates a simple application using **SwiftUI** for showcasing a feature set based on maps and lists. The architecture and design choices are aimed at balancing usability, maintainability, and performance.

## Features

- **Primary Map View:** The app opens to a map view, prioritizing geospatial data as the primary user interaction point.  
- **Secondary List View:** A list view is available as a secondary interface to complement the map view, ensuring seamless navigation and data access.  
- **Dark & Light Mode Support:** The UI is fully compatible with both dark and light modes, adapting to the user’s device settings dynamically.

## Design Decisions

- **Map as Primary UX:** The user experience is tailored with the map view as the primary page and the list view secondary. This decision was based on the app's core functionality and user focus on location-based data.
- **Load what you see:** Due to SwiftUI's known large memory footprint, I have decided to unload the map view when it is covered by the list sheet to maintain optimal performance. 
- **KISS & YAGNI Principles:** Simplicity and avoiding over-engineering were core to development. Features were implemented only when needed, keeping the app clean and focused.

## Codebase Overview

- **Dependency Management:** The app uses the `live` versions of all dependencies. These can easily be swapped with `dummy` versions for testing or other purposes, ensuring flexibility during development and maintenance.  
- **Core System Manager Tests:** Simple tests have been included for the core manager to verify its functionality and ensure a stable foundation for the app.

## Testing API

***For the reviewer’s convenience***, a testing API is included directly within the project. Although in production builds, API keys are injected via CI pipelines, this setup simplifies the review process.  

## Getting Started

### Prerequisites

- Xcode 15+

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shadiGhelman/FiveSquare
   ```
2. open the `FiveSquare.xcodeproj`

3. Run the App with <kbd>⌘ command</kbd>+<kbd>R</kbd>.

Note: You can use your own API key if desired, but a testing key is included for now. Also, don't forget to use your own developer account to run the app on a real device.

### Running Tests

To execute tests for the core manager and other components, just open the project and hit the <kbd>⌘ command</kbd>+<kbd>U</kbd> for running tests in Xcode.

---

Feel free to reach out for any further questions.
Thanks.
