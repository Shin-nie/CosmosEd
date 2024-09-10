//
//  Planet.swift
//  CosmosEd

import Foundation
import SwiftUI

// Define the structure to match the API's JSON response
struct Planet: Codable {
    let name: String
    let mass: Double
    let radius: Double
    let period: Int
    let semi_major_axis: Double
    let temperature: Int
    let distance_light_year: Double
    let host_star_mass: Double
    let host_star_temperature: Int
}

