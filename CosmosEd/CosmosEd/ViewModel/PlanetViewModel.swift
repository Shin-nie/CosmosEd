//
//  PlanetVM.swift
//  CosmosEd

import Combine
import Foundation

class PlanetViewModel: ObservableObject {

    // Published property to STORE a list of planets with its name and asset image
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
    
    // Published property to STORE the current planet name
    @Published var currentPlanet: String = ""
    //  put 1 planet name in here it'll display only 1 planet (e.g. "Mercury)
    //  otherwhise, empty string " " means all planets
    
    //  MARK: - Function
    //  Function to update the current planet name when a planet is selected
    func updateCurrentPlanet(to planet: Planet) {
        self.currentPlanet = planet.name
    }
    
    // Function to initialize the current planet with the first one in the list (Mercury by default)
    func initialisedPlanet(){
        self.currentPlanet = planets[0].name;
    }
}
