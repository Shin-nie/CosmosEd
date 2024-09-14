//
//  FlashcardViewModel.swift
//  CosmosEd

//  MARK: Step 3.1: Create the ViewModel
//  Create a FlashcardViewModel class that will manage the flashcards. This class will expose properties and methods for the view to interact with, keeping the business logic separate from the view.
//     •    ViewModel: The FlashcardViewModel class is responsible for managing flashcards, including adding, deleting, and editing them. It exposes the flashcards list to the view (ContentView), which observes changes.


import SwiftUI
import Combine

class FlashcardViewModel: ObservableObject {
    // Published properties to allow views to observe changes
    //    @Published var flashcards: [Flashcard] = [
    //        Flashcard(frontText: "What is the hottest planet in the solar system?", backText: "Venus", category: "SOLAR SYSTEM"),
    //        QuizFlashcard(frontText: "Who discovered the law of universal gravitation?", backText: "Isaac Newton", category: "UNIVERSE", correctAnswer: "Isaac Newton"),
    //        Flashcard(frontText: "What is the largest planet in our solar system?", backText: "Jupiter", category: "UNIVERSE"),
    //        Flashcard(frontText: "How many planets are in the solar system?", backText: "Eight", category: "SOLAR SYSTEM")
    //    ] {
    //        didSet {
    //            saveFlashcards()
    //            // This method is called automatically whenever items is updated, thanks to the didSet observer. - (1.2)
    //        }
    //    }
    
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
    
    let userDefaults = UserDefaults.standard
    
    init() {
        loadFlashcards()
    }
    
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
        //        saveFlashcards()
    }
    
    // MARK: - Persistence with UserDefaults
    
    // Save flashcards to UserDefaults
    func saveFlashcards() {
        if let encodedFlashcards = try? JSONEncoder().encode(flashcards) {
            userDefaults.setValue(encodedFlashcards, forKey: "Flashcards")
        }
    }
    
    // Load flashcards from UserDefaults or fallback to default flashcards
    func loadFlashcards() {
        if let savedFlashcardsData = userDefaults.data(forKey: "Flashcards"),
           let decodedFlashcards = try? JSONDecoder().decode([Flashcard].self, from: savedFlashcardsData) {
            flashcards = decodedFlashcards
        } else {
            // If there are no saved flashcards, use the default ones
            flashcards = defaultFlashcards
        }
    }
}
