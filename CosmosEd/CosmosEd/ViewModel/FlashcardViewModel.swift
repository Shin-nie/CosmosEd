//
//  FlashcardViewModel.swift
//  CosmosEd

//  MARK: Step 3.1: Create the ViewModel
//  Create a FlashcardViewModel class that will manage the flashcards. 
//  This class will expose properties and methods for the view to interact with, keeping the business logic separate from the view.
//  • ViewModel: The FlashcardViewModel class is responsible for managing flashcards, including adding, deleting, and editing them. It exposes the flashcards list to the view (ContentView), which observes changes.


import SwiftUI
import Combine

class FlashcardViewModel: ObservableObject {
    
    @Published var flashcards: [Flashcard] = [] {
        didSet {
            saveFlashcards() // Automatically save whenever the array changes
        }
    }
    
    // Default flashcards to display if there are no saved flashcards
    let defaultFlashcards: [Flashcard] = [
        Flashcard(frontText: "What is the hottest planet in the solar system?", backText: "Venus", category: "SOLAR SYSTEM"),
        QuizFlashcard(frontText: "Who discovered the law of universal gravitation?", backText: "Isaac Newton", category: "UNIVERSE", correctAnswer: "Isaac Newton"),
        Flashcard(frontText: "What is the largest planet in our solar system?", backText: "Jupiter", category: "UNIVERSE"),
        Flashcard(frontText: "How many planets are in the solar system?", backText: "Eight", category: "SOLAR SYSTEM")
    ]
    
    //  MARK: UserDefaults
    let userDefaults = UserDefaults.standard
    
    //  MARK: Initialisation
    init() {
        loadFlashcards()
    }
    
    //  MARK: Functions 
    // Function to add a new flashcard
    func addFlashcard(frontText: String, backText: String, category: String) {
        let newFlashcard = Flashcard(frontText: frontText, backText: backText, category: category)
        flashcards.append(newFlashcard)
    }
    
    // Function to delete a flashcard
    func deleteFlashcard(_ flashcard: Flashcard) {
        flashcards.removeAll { $0.id == flashcard.id }
    }
    
    // Function to edit a flashcard
    func editFlashcard(_ flashcard: Flashcard, front: String, back: String, category: String) {
        if let index = flashcards.firstIndex(where: { $0.id == flashcard.id }) {
            flashcards[index].frontText = front
            flashcards[index].backText = back
            flashcards[index].category = category
        }
        //  After edit, it saved the flashcards to UserDefault again
        //  saveFlashcards()
    }
    
    // MARK: - Persistence with UserDefaults
    
    // Save flashcards to UserDefaults
    func saveFlashcards() {
        if let encodedFlashcards = try? JSONEncoder().encode(flashcards) {
            userDefaults.setValue(encodedFlashcards, forKey: "Flashcards")
        }
    }
    
    // Load flashcards from UserDefaults or use default flashcards only on the first run
    func loadFlashcards() {
        
        
        //  clear UserDefaults to ensure the default card appear
        //  userDefaults.removeObject(forKey: "Flashcards")
        
        if let savedFlashcardsData = userDefaults.data(forKey: "Flashcards"),
           let decodedFlashcards = try? JSONDecoder().decode([Flashcard].self, from: savedFlashcardsData) {
            
            if(decodedFlashcards.isEmpty) {
                //   If there is no saved flashcards, use default ones
                flashcards = defaultFlashcards
            }
            else {
                //   If there is a data in userDefault, get that data
                flashcards = decodedFlashcards
            }
            
            //                print("Loaded saved flashcards from UserDefaults")
            //                flashcards = decodedFlashcards
            //            } else {
            //                // No saved flashcards, load the default ones (first run scenario)
            //                print("No saved flashcards found, loading default flashcards")
            //                flashcards = defaultFlashcards
            //                saveFlashcards() // Save the default flashcards so they can be edited and persisted
            //            }
        }
    }
}
