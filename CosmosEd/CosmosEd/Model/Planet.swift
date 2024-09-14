//
//  Planet.swift
//  CosmosEd

import Foundation
import SwiftUI

// Define the structure to match the API's JSON response
struct Planet: Codable, Identifiable {
    let id = UUID() // Add an id for the list
    let name: String
    let mass: Double?
    let radius: Double?
    let period: Double?
    let semi_major_axis: Double?
    let temperature: Int?
    let distance_light_year: Double?
    let host_star_mass: Double?
    let host_star_temperature: Int?
    
    // Change assetImageName to a stored property with a default value
    var assetImageName: String

    // Add CodingKeys for decoding only the API data
    enum CodingKeys: String, CodingKey {
        case name, mass, radius, period, semi_major_axis, temperature, distance_light_year, host_star_mass, host_star_temperature
    }

    // Default initializer for when not decoding from JSON
    init(name: String, mass: Double?, radius: Double?, period: Double?, semi_major_axis: Double?, temperature: Int?, distance_light_year: Double?, host_star_mass: Double?, host_star_temperature: Int?, assetImageName: String) {
        self.name = name
        self.mass = mass
        self.radius = radius
        self.period = period
        self.semi_major_axis = semi_major_axis
        self.temperature = temperature
        self.distance_light_year = distance_light_year
        self.host_star_mass = host_star_mass
        self.host_star_temperature = host_star_temperature
        self.assetImageName = assetImageName
    }
    
    // Custom initializer for decoding from JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.mass = try container.decodeIfPresent(Double.self, forKey: .mass)
        self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
        self.period = try container.decodeIfPresent(Double.self, forKey: .period)
        self.semi_major_axis = try container.decodeIfPresent(Double.self, forKey: .semi_major_axis)
        self.temperature = try container.decodeIfPresent(Int.self, forKey: .temperature)
        self.distance_light_year = try container.decodeIfPresent(Double.self, forKey: .distance_light_year)
        self.host_star_mass = try container.decodeIfPresent(Double.self, forKey: .host_star_mass)
        self.host_star_temperature = try container.decodeIfPresent(Int.self, forKey: .host_star_temperature)
        
        // Assign a default image based on the planet name
        self.assetImageName = name.lowercased() // Default value using the planet's name
    }
}

//  MARK: • The assetImageName is now a computed property that derives from the name field of the planet. 
//  MARK:   if have images named like “Mercury.png”, “Earth.png”, etc., this will work seamlessly.


