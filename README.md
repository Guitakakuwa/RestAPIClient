# RestAPIClient

The RestAPIClient is a Swift-based library designed to simplify the process of making HTTP requests to RESTful APIs. This project aims to provide a straightforward and efficient way to interact with web services, ensuring error handling, and supporting unit testing to verify the functionality.

## Features

- **Basic REST API Client Implementation**: Offers a foundational setup to perform GET, POST, PUT, and DELETE requests.
- **Error Handling**: Implements basic error handling to manage common HTTP errors and responses.
- **Unit Testing**: Includes a framework for unit testing with a focus on verifying the GET method's functionality.

## Getting Started

To integrate the RestAPIClient into your Swift project, clone this repository and import the necessary files into your project structure. Ensure you have Swift Package Manager configured, as this project utilizes `.swiftpm` for package management.

### Prerequisites

- Swift 5.0 or later
- Xcode 11.0 or later (if using Xcode for development)

### Installation

1. Clone the repository:

git clone https://github.com/Guitakakuwa/RestAPIClient.git

2. Include the project in your Swift project's dependencies.
3. Import `RestAPIClient` in your Swift files to start using the client.

## Usage

Here's a basic example of how to use the RestAPIClient to make a GET request:
```swift
let client = APIClient()
let request = CreatePostRequest(requestObject.requestCase)

do {
    let response: CreatePostResponse = try await client.sendRequest(request: request)
    print("Response:", response)
    // Here you can compare the response to your expectations or update your UI accordingly
} catch {
    print("Error:", error)
    // Handle any errors
}
````
Use Request Protocol to abstract the usage of requests

```swift
import Foundation

enum ExampleRequestsStubs: RequestProtocol {
    case getRequest
    case postRequest

    var method: HTTPMethod {
        switch self {
        case .getRequest:
            return .get
        case .postRequest:
            return .post
        }
    }

    var baseURL: URL {
        switch self {
        case .getRequest:
            return URL(string: "getUrl)!
        case .postRequest:
            return URL(string: "https://jsonplaceholder.typicode.com/")!
        }
    }

    var path: String {
        switch self {
        case .getRequest:
            return "get/endpoint"
        case .postRequest:
            return "post/endpoint"
        }
    }

    var headers: [String: String] {
        switch self {
        case .getRequest:
            return [
                "ApiKeyParameter": "YourAPIKey",
                "ApiKeyHost": "yourHost"
            ]
        case .postRequest:
            return ["Content-type": "application/json; charset=UTF-8"]
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getRequest:
            return nil
        case .postRequest:
            return [
                "parameter1": "parameters1",
                "parameter2": "parameter2"
            ]
        }
    }

    var responseObjectType: Codable.Type {
        switch self {
        case .getRequest:
            return [GetResponseObject].self
        case .postRequest:
            return PostResponseObject.self
        }
    }
}
```

