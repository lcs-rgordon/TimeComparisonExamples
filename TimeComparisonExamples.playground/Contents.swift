import SwiftUI
import PlaygroundSupport

// Get the current date
let now = Date()

// Print the current date in various formats
print("====")
print("Current date and time is:")
print(now)
print("====")
print("Current date and time formatted in ISO8601 format is:")
print(now.formatted(.iso8601))

// Define a structure to describe current mood
struct Mood: Codable {
    let dateTime: Date
    let description: String
}

// How am I feeling?
let feeling = Mood(dateTime: now,
                   description: "Relaxed")

// What does this structure contain?
print("====")
print("Contents of original 'feeling' instance of Mood data type are:")
print(feeling)

// Create a JSON Encoder object
let encoder = JSONEncoder()

// Make sure output is easily read by humans
encoder.outputFormatting = .prettyPrinted

// Ensure dates are formatted the way we want
encoder.dateEncodingStrategy = .iso8601

// Decode the data
var encodedFeeling: Data? = nil
do {
    encodedFeeling = try encoder.encode(feeling)
} catch {
    print(error)
}

// What was encoded?
print("====")
print("Encoded contents of 'feeling' instance of Mood data type are:")
print(String(data: encodedFeeling!, encoding: .utf8)!)


// Create a JSON Decoder object
let decoder = JSONDecoder()

// Ensure that we can decode dates using format that was used to encode dates
decoder.dateDecodingStrategy = .iso8601

// Create a JSON Decoder object
var decodedFeeling: Mood? = nil
do {
    decodedFeeling = try decoder.decode(Mood.self, from: encodedFeeling!)
} catch {
    print(error)
}

// What is in this object?
print("====")
print("Decoded contents of 'decodedFeeling' instance of Mood data type are:")
print(decodedFeeling!)
print("If all has gone well, these should be identical.")

struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}

PlaygroundPage.current.setLiveView(ContentView())
