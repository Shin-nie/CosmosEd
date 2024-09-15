//
//  CardView.swift
//  CosmosEd

import Foundation
import SwiftUI

//  MARK: Step 4: Refactor CardView to Work with FlashcardTask
//  modify CardView to interact with the protocol FlashcardTask instead of concrete classes. This way, it can work with any flashcard type that conforms to the protocol.

//  MARK: Step 4.1: Update CardView to Work with ViewModel
//  keep the CardView mostly the same, but ensure that CardView interacts with the flashcard via the ViewModel’s exposed methods if needed.

import SwiftUI

struct CardView: View {
    
    //  MARK: - Properties
    
    // Tracks whether the card is flipped (front or back)
    @State private var isFlipped = false
    
    // Tracks whether the card is in edit mode
    @State private var isEditing = false
    
    // Holds the current flashcard data
    @State private var flashcard: FlashcardTask
    
    // ViewModel to manage flashcard actions
    @ObservedObject var viewModel: FlashcardViewModel
    
    // Callback to handle deletion of the flashcard
    var deleteAction: () -> Void
    
    //  MARK: - Initialisation
    //  Custom initializer to pass flashcard, ViewModel, and delete action
    init(flashcard: FlashcardTask, viewModel: FlashcardViewModel, deleteAction: @escaping () -> Void) {
        
        _flashcard = State(initialValue: flashcard) // Initialize the flashcard state
        self.viewModel = viewModel  // Assign ViewModel
        self.deleteAction = deleteAction // Assign the delete action callback
    }
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            // BGM_Color - dark background color
            
            // Display either the front or back of the card based on `isFlipped`
            if isFlipped {
                cardBack    // Show the back of the card
            } else {
                cardFront   // Show the front of the card
            }
        }
        // Set the size of the card
        .frame(width: 366, height: 320)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0)) // 3D Flip effect
        .animation(.spring(), value: isFlipped) // Spring animation for the flip
        
        //  MARK: OnTapGesture
        .onTapGesture {
            // Toggle the flip state when tapped if not in edit mode
            if !isEditing {
                withAnimation { isFlipped.toggle() }
            }
        }
        .padding()
    }
    
    // MARK: - Front of the card
    private var cardFront: some View {
        VStack {
            
            // MARK: Show edit view or display view based on `isEditing`
            if isEditing {
                editView(frontText: $flashcard.frontText, category: $flashcard.category)
            } else {
                displayTextView(text: flashcard.frontText, category: flashcard.category)
            }
            // MARK: Display control buttons (edit and delete)
            controlButtons
        }
        // MARK: Apply the card style
        .cardStyle()
    }
    
    // MARK: - Back of the card
    private var cardBack: some View {
        VStack {
            
            // MARK: Show edit view or display view based on `isEditing`
            if isEditing {
                editView(frontText: $flashcard.backText, category: $flashcard.category)
            } else {
                displayTextView(text: flashcard.backText, category: flashcard.category)
            }
            // MARK: Display control buttons (edit and delete)
            controlButtons
        }
        // MARK: Apply the card style with different parameters for the back
        .cardStyle(
            backgroundColor: Color(hex: 0x212121), // Dark background for the back of the card
            textColor: .white, // Toggle overlay dynamically
            hasOverlay: true,  // Toggle overlay dynamically
            overlayColor: Color(hex: 0xc7c7cc),  // Custom overlay color
            lineWidth: 2  // Custom stroke width
        )
        //  MARK: Rotate the back of the card
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
    
    // MARK: - Control buttons (Edit and Delete)
    private var controlButtons: some View {
        HStack {
            Spacer()
            Button(action: {
                if isEditing {
                    // Save changes to ViewModel when editing finishes
                    viewModel.editFlashcard(
                        flashcard as! Flashcard,  // Assuming flashcard is of type Flashcard
                        front: flashcard.frontText,
                        back: flashcard.backText,
                        category: flashcard.category
                    )
                }
                isEditing.toggle() // Toggle editing state
                viewModel.saveFlashcards() // Saved the card's data after editing state
            }) {
                Image(systemName: isEditing ? "checkmark" : "pencil")
                    .controlButtonStyle(isEditing: isEditing) // Apply custom button style
            }
            Spacer()
            // Trigger the delete action
            Button(action: deleteAction) {
                Image(systemName: "trash")
                    .controlButtonStyle(isEditing: false)
                    .foregroundColor(.red)
            }
            Spacer()
        }
    }
    
    //  Edit view to edit the flashcard text and category
    private func editView(frontText: Binding<String>, category: Binding<String>) -> some View {
        VStack {
            // TextField to edit the flashcard front text
            TextField("Edit Text", text: frontText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // TextField to edit the category
            TextField("Edit Category", text: category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .foregroundStyle(.black)
    }
    
    //  Display view for showing flashcard text and category
    private func displayTextView(text: String, category: String) -> some View {
        VStack {
            
            Text(text)
                .font(.system(size: 17, weight: .medium))
                .multilineTextAlignment(.center)
            
            Text(category)
            // Apply a custom style for the category
                .modifier(FootnoteBoldStyle())
        }
    }
}

// Custom style for the category text in the display view
struct FootnoteBoldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .tracking(1.00)
            .opacity(0.6)
            .padding([.horizontal, .top], 16)
            .padding(.bottom, 24)
    }
}

// MARK: - Extension to apply custom styles to the control buttons (edit and delete)
//  Control Button Styling

extension Image {
    func controlButtonStyle(isEditing: Bool) -> some View {
        self
            .font(.system(size: 18))
            .padding()
            .background(isEditing ? Color.green.opacity(0.2) : Color.blue.opacity(0.1))
            .clipShape(Circle())
    }
}

// MARK: - Extension to define a reusable card style, allowing dynamic changes like background color, text color, and overlay
//  Card Style with Dynamic Overlay
extension View {
    func cardStyle(
        backgroundColor: Color = .white,
        textColor: Color = .black,
        hasOverlay: Bool = true,  // Controls whether the overlay is applied
        overlayColor: Color = Color(hex: 0xc7c7cc),  // Default stroke color
        lineWidth: CGFloat = 2  // Default line width for the stroke
    ) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 320, alignment: .center)
            .background(backgroundColor.opacity(0.9))
            .shadow(color: .white.opacity(0.25), radius: 2, x:0, y:2)
            .foregroundColor(textColor)
            .cornerRadius(24)
        //            .shadow(radius: 10)
            .padding()
            .overlay(
                hasOverlay ?
                RoundedRectangle(cornerRadius: 24)
                    .stroke(overlayColor, lineWidth: lineWidth)
                    .frame(width: 335, height: 320, alignment: .center)
                : nil  // No overlay if `hasOverlay` is false
            )
        // Additional shadow
            .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
            .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
    }
}

//  MARK: - Preview structure
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            flashcard: Flashcard(frontText: "Front of the card", backText: "Back of the card", category: "Category"), viewModel: FlashcardViewModel(),
            deleteAction: {
                print("Delete action triggered")
            }
        )
    }
}
