//
//  PlanetVM.swift
//  CosmosEd

import Combine
import Foundation

class PlanetViewModel: ObservableObject {
    @Published var planet: Planet?

    func fetchPlanetData(name: String) {
        let apiKey = "ZtK3G/gPhJPPevcqPAjtwQ==lqklW02aFzQ4C68y"
        let urlString = "https://api.api-ninjas.com/v1/planets?name=\(name)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        // Perform the API call
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                // Decode the JSON response
                let planets = try JSONDecoder().decode([Planet].self, from: data)
                DispatchQueue.main.async {
                    self.planet = planets.first
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}

//struct ContentView: View {
//    @StateObject var viewModel = PlanetViewModel()
//    
//    var body: some View {
//        VStack {
//            if let planet = viewModel.planet {
//                Text("Planet: \(planet.name)")
//                Text("Mass: \(planet.mass)")
//                Text("Radius: \(planet.radius)")
//                Text("Temperature: \(planet.temperature)K")
//                // Add more details as needed
//            } else {
//                Text("Loading planet data...")
//            }
//        }
//        .onAppear {
//            viewModel.fetchPlanetData(name: "Neptune")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
