//
//  Flashcard.swift
//  CosmosEd

import Foundation
import SwiftUI

//  MARK: Step 1: Create a Protocol for Flashcard Tasks
//  Define a protocol that encapsulates tasks related to a flashcard such as adding, editing, & deleting. This will ensure consistent behavior for all flashcards.
protocol FlashcardTask {
    var frontText: String { get set }
    var backText: String { get set }
    var category: String { get set }
    
    func addFlashcard()
    func editFlashcard(front: String, back: String, category: String)
    func deleteFlashcard()
}

//  MARK: Step 2: Create a Base Class for Flashcards - [ MODEL ]
//  Next, create a base class Flashcard that conforms to the FlashcardTask protocol. This class will implement the properties & methods defined in the protocol.
//  Flashcard class is responsible for managing the properties & behavior of individual flashcards.
class Flashcard: Identifiable, Codable, FlashcardTask {
    var id = UUID()
    var frontText: String
    var backText: String
    var category: String
    
    init(frontText: String, backText: String, category: String) {
        self.frontText = frontText
        self.backText = backText
        self.category = category
    }
    
    // Add flashcard functionality
    func addFlashcard() {
        // Implementation for adding a new flashcard
    }
    
    // Edit flashcard functionality
    func editFlashcard(front: String, back: String, category: String) {
        self.frontText = front
        self.backText = back
        self.category = category
    }
    
    // Delete flashcard functionality
    func deleteFlashcard() {
        // Implementation for deleting the flashcard
    }
}
