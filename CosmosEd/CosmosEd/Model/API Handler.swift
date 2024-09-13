//
//  ContentView.swift
//  TestAPI2-NasaAPI

import SwiftUI
import AVKit
import Foundation

//  MARK: - Step 1: Create a model for the response
//  You will need to create a MediaObject struct to parse the JSON response into Swift objects.

struct MediaObject: Codable {
    let nasaID: String
    let title: String
    let description: String
    let mediaType: String
    let dateCreated: String
    let keywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case nasaID = "nasa_id"
        case title, description, mediaType = "media_type", dateCreated = "date_created", keywords
    }
}

struct VideoLink: Identifiable{
    let id = UUID();
    
    let url: String;
}

struct MediaObjectItem: Codable {
    let href: String;
    let data: [MediaObject]
    let links: [MediaObjectLink]?
}

//  used to handle the media URLs (href), and render tells us whether it’s an image or video.
struct MediaObjectLink: Codable {
    let href: String
    let rel: String
    let render: String?
}

struct MediaObjectSearchResponse: Codable {
    let collection: MediaObjectCollection
}

struct MediaObjectCollection: Codable {
    let items: [MediaObjectItem]
}


//  MARK: - Step 2: Make an API request
//  You will use URLSession to fetch data from the API. Make sure to handle errors and decode the JSON response properly.
//  Now, let’s update the API call to extract image and video links for each MediaObjectItem.

class MediaObjectAPI: ObservableObject {
    @Published var planets = [MediaObjectItem]()
    
    let apiKey = "c27PNpJEi5tdIgo3lBeSR0gd9e0tBNosInFbSxKq"
    let apiRoot = "https://images-api.nasa.gov/search" //https://images-api.nasa.gov/search
    
    func fetchMediaObjects(searchQuery: String) {
        let urlString = "\(apiRoot)?q=\(searchQuery)&media_type=image,video"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MediaObjectSearchResponse.self, from: data)
                DispatchQueue.main.async {
//                    print("Data fetched successfully")
//                    print("Fetched items count: \(decodedResponse.collection.items.count)")
                    self.planets = decodedResponse.collection.items
                }
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
            }
        }.resume()
    }
}


func convertToHTTPS(urlString: String) -> String {
    // Check if the URL starts with 'http://'
    if urlString.hasPrefix("http://") {
        // Replace 'http://' with 'https://'
        let httpsURLString = urlString.replacingOccurrences(of: "http://", with: "https://")
        return httpsURLString
    } else {
        // Return the original URL if it does not start with 'http://'
        return urlString
    }
}

//  MARK: - Info API

class InfoAPI: ObservableObject {
    @Published var planets: [Planet] = [] // Store multiple planets here
    private let apiKey = "ZtK3G/gPhJPPevcqPAjtwQ==lqklW02aFzQ4C68y"
    private let baseUrl = "https://api.api-ninjas.com/v1/planets"
    private var offset = 0 // Start with 0 offset for exoplanets
    private let limit = 30 // Max results per API call for exoplanets
    private var isFetching = false // To prevent multiple API calls at once

    // Fetch all planets (solar system and exoplanets)
    func fetchAllPlanets() {
        fetchSolarSystemPlanets() // Fetch solar system planets by name
        fetchExoplanets() // Fetch exoplanets using min_radius or other parameters
    }

    // Fetch solar system planets by their names dynamically
    public func fetchSolarSystemPlanets() {
        let solarSystemPlanets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
        for planetName in solarSystemPlanets {
            let urlString = "\(baseUrl)?name=\(planetName)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL for planet: \(planetName)")
                continue
            }

            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
            
            // Asynchronous data task
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    print("Error fetching data for \(planetName): \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data returned for \(planetName)")
                    return
                }

                do {
                    // Decode the response and set the assetImageName
                    if var planet = try JSONDecoder().decode([Planet].self, from: data).first {
                        planet.assetImageName = self?.getAssetImageName(for: planetName) ?? "default_planet_image" // Assign the correct image name
                        
                        DispatchQueue.main.async {
                            self?.planets.append(planet)
                        }
                    }
                } catch {
                    print("Error decoding data for \(planetName): \(error.localizedDescription)")
                }
            }.resume()
        }
    }

    // Helper function to map planet names to image assets
    private func getAssetImageName(for planetName: String) -> String {
        let imageMapping = [
            "Mercury": "Mercury",
            "Venus": "Venus",
            "Earth": "Earth", //Eearth_image
            "Mars": "Mars",
            "Jupiter": "Jupiter",
            "Saturn": "Saturn",
            "Uranus": "Uranus",
            "Neptune": "Neptune",
            "Pluto": "Pluto"
        ]
        
        return imageMapping[planetName] ?? "default_planet_image"
    }

    // Fetch exoplanets dynamically using min_radius
    private func fetchExoplanets() {
        guard !isFetching else { return } // Prevent duplicate calls
        isFetching = true

        // Use min_radius to fetch exoplanets dynamically
        let minRadius = 0.1
        let urlString = "\(baseUrl)?min_radius=\(minRadius)&offset=\(offset)&limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isFetching = false // Reset the fetching status
            }

            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                // Decode the exoplanets response and append them to the list
                let planets = try JSONDecoder().decode([Planet].self, from: data)
                DispatchQueue.main.async {
                    self.planets.append(contentsOf: planets)
                    if planets.count == self.limit {
                        // If we fetched the max number of planets, increase the offset and fetch more
                        self.offset += self.limit
                        self.fetchExoplanets() // Fetch the next set of exoplanets
                    }
                }
            } catch {
                print("Error decoding exoplanet data: \(error)")
            }
        }.resume()
    }
}

