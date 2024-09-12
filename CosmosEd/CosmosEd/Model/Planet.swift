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
}


