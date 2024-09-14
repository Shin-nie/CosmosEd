//
//  PlanetVM.swift
//  CosmosEd

import Combine
import Foundation

class PlanetViewModel: ObservableObject {

    // Add a list of planets with name and image
    @Published var planets: [Planet] = [
        Planet(name: "Mercury", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Mercury"),
        Planet(name: "Venus", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Venus"),
        Planet(name: "Earth", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Earth"),
        Planet(name: "Mars", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Mars"),
        Planet(name: "Jupiter", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Jupiter"),
        Planet(name: "Saturn", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Saturn"),
        Planet(name: "Uranus", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Uranus"),
        Planet(name: "Neptune", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Neptune"),
        Planet(name: "Pluto", mass: nil, radius: nil, period: nil, semi_major_axis: nil, temperature: nil, distance_light_year: nil, host_star_mass: nil, host_star_temperature: nil, assetImageName: "Pluto")
    ]
    
    @Published var currentPlanet: String = "" // 
    
    //  MARK: - Function
    
    // Update the current planet name
    func updateCurrentPlanet(to planet: Planet) {
        self.currentPlanet = planet.name
    }
    
    func initialisedPlanet(){
        self.currentPlanet = planets[0].name;
    }
}
