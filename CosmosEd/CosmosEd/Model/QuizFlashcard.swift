//
//  QuizFlashcard.swift
//  CosmosEd

import Foundation
import SwiftUI

//  MARK: Step 3: Implement Inheritance for Specialized Flashcards
//  If you want to manage different types of flashcards, you can create subclasses of Flashcard. For example, you might have QuizFlashcard or VocabularyFlashcard that inherit from the base Flashcard class.

class QuizFlashcard: Flashcard {
    var correctAnswer: String
    
    init(frontText: String, backText: String, category: String, correctAnswer: String) {
        self.correctAnswer = correctAnswer
        super.init(frontText: frontText, backText: backText, category: category)
    }
    
    // Required initializer for decoding
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.correctAnswer = try container.decode(String.self, forKey: .correctAnswer)
        try super.init(from: decoder) // Call the superclass' decoder
    }
    
    // Required method for encoding
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(correctAnswer, forKey: .correctAnswer)
        try super.encode(to: encoder) // Call the superclass' encoder
    }
    
    // Define coding keys for the new property
    private enum CodingKeys: String, CodingKey {
        case correctAnswer
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        return answer == correctAnswer
    }
}
