//
//  PlanetVM.swift
//  CosmosEd

import Combine
import Foundation
//
//class PlanetViewModel: ObservableObject {
//    @Published var currentPlanet: String = "Jupiter";
//   
//}

class PlanetViewModel: ObservableObject {
    
    @Published var currentPlanet: String = "Jupiter" // Default planet
    // Add a list of planets with name and image
    @Published var planets: [Planet] = [
        Planet(name: "Mercury", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Mercury"),
        Planet(name: "Venus", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Venus"),
        Planet(name: "Earth", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Earth")
    ]
    
    // Update the current planet name
    func updateCurrentPlanet(to planet: Planet) {
        self.currentPlanet = planet.name
    }
}
