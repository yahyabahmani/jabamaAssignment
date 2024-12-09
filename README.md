JabamaAssignment

This is an iOS app developed using Swift, SwiftUI, and Clean Architecture. The app allows users to search for places, view them in a list or on a map, and apply filters with pagination. The app is designed with an improved user experience (UX) to enhance usability and aesthetics.

Features

Enhanced UX for better usability and aesthetics


Search for places


Display results in a list and map view


Pagination for large datasets


Filter functionality for refined searches


Modular architecture adhering to SOLID principles


Fully tested Network Layer with 100% test coverage

Setup Instructions

Follow these steps to set up and run the project:

1. Clone the Repository
Clone this repository to your local machine:
git clone https://github.com/amirchoupanneadj2/jabamaAssignment.git


cd jabamaAssignment


2. Configure API Keys
The app uses .xcconfig files to store sensitive information such as the API base URL and API key.

Navigate to the Configurations folder.
Copy the provided template files and replace placeholders with actual values:


cp Configurations/Debug.xcconfig.template Configurations/Debug.xcconfig


cp Configurations/Release.xcconfig.template Configurations/Release.xcconfig


Open Debug.xcconfig and Release.xcconfig in your editor of choice and update the placeholders. 


For example:

API_KEY = your_actual_api_key


3. Open the Project in Xcode
Open the project in Xcode:

open jabamaAssignment.xcodeproj
Ensure you select the correct scheme (Debug or Release) before building and running.

4. Build and Run
Build the project (Cmd + B) and run the app on a simulator or a real device (Cmd + R).

Important Notes

Crash Without Configuration Files:
The app will crash if the required .xcconfig files are missing or incorrectly set up. This is intentional and results in a fatal error to alert developers of the missing configuration.
Ensure you follow the setup instructions above to avoid this issue.


How to Run Tests

To verify the test coverage or run the test suite:

Open the project in Xcode.
Select the Product > Test menu option, or press Cmd + U.
View the test results in the Test Navigator or the Coverage Report to see the 100% coverage for the Network class.
Contact
