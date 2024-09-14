//
//  CardView.swift
//  CosmosEd

import Foundation
import SwiftUI

//  MARK: Step 4: Refactor CardView to Work with FlashcardTask
//  We can modify CardView to interact with the protocol FlashcardTask instead of concrete classes. This way, it can work with any flashcard type that conforms to the protocol.

//  MARK: Step 4.1: Update CardView to Work with ViewModel
//  We can keep the CardView mostly the same, but we ensure that CardView interacts with the flashcard via the ViewModel’s exposed methods if needed.

import SwiftUI

struct CardView: View {
    @State private var isFlipped = false
    @State private var isEditing = false
    @State private var flashcard: FlashcardTask
    
    var deleteAction: () -> Void
    
    init(flashcard: FlashcardTask, deleteAction: @escaping () -> Void) {
        _flashcard = State(initialValue: flashcard)
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        ZStack {
//            BGM_Color
            if isFlipped {
                cardBack
            } else {
                cardFront
            }
        }
        .frame(width: 366, height: 320)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0)) // Flip effect
        .animation(.spring(), value: isFlipped)
        .onTapGesture {
            if !isEditing {
                withAnimation { isFlipped.toggle() }
            }
        }
        .padding()
    }
    
    // MARK: - Front of the card
    private var cardFront: some View {
        VStack {
            if isEditing {
                editView(frontText: $flashcard.frontText, category: $flashcard.category)
            } else {
                displayTextView(text: flashcard.frontText, category: flashcard.category)
            }
            controlButtons
        }
        .cardStyle()
    }
    
    // MARK: - Back of the card
    private var cardBack: some View {
        VStack {
            if isEditing {
                editView(frontText: $flashcard.backText, category: $flashcard.category)
            } else {
                displayTextView(text: flashcard.backText, category: flashcard.category)
            }
            controlButtons
        }
        .cardStyle(
                backgroundColor: Color(hex: 0x212121),
                textColor: .white,
                hasOverlay: true,  // Toggle overlay dynamically
                overlayColor: Color(hex: 0xc7c7cc),  // Custom overlay color
                lineWidth: 2  // Custom stroke width
            )
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
    
    // Control buttons (Edit and Delete)
    private var controlButtons: some View {
        HStack {
            Spacer()
            Button(action: { isEditing.toggle() }) {
                Image(systemName: isEditing ? "checkmark" : "pencil")
                    .controlButtonStyle(isEditing: isEditing)
            }
            Spacer()
            Button(action: deleteAction) {
                Image(systemName: "trash")
                    .controlButtonStyle(isEditing: false)
                    .foregroundColor(.red)
            }
            Spacer()
        }
    }
    
    // Edit view
    private func editView(frontText: Binding<String>, category: Binding<String>) -> some View {
        VStack {
            TextField("Edit Text", text: frontText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
               
            TextField("Edit Category", text: category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .foregroundStyle(.black)
    }
    
    // Display view
    private func displayTextView(text: String, category: String) -> some View {
        VStack {
            Text(text)
                .font(.system(size: 17, weight: .medium))
            Text(category)
                .modifier(FootnoteBoldStyle())
        }
    }
}


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

// MARK: - Control Button Styling
extension Image {
    func controlButtonStyle(isEditing: Bool) -> some View {
        self
            .font(.system(size: 18))
            .padding()
            .background(isEditing ? Color.green.opacity(0.2) : Color.blue.opacity(0.1))
            .clipShape(Circle())
    }
}

// MARK: - Card Style with Dynamic Overlay
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
            .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
            .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
    }
}

// Preview structure
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            flashcard: Flashcard(frontText: "Front of the card", backText: "Back of the card", category: "Category"),
            deleteAction: {
                print("Delete action triggered")
            }
        )
    }
}
