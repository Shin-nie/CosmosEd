//
//  CardView.swift
//  CosmosEd

import Foundation
import SwiftUI

//  MARK: Step 4: Refactor CardView to Work with FlashcardTask
//  We can modify CardView to interact with the protocol FlashcardTask instead of concrete classes. This way, it can work with any flashcard type that conforms to the protocol.

//  MARK: Step 4.1: Update CardView to Work with ViewModel
//  We can keep the CardView mostly the same, but we ensure that CardView interacts with the flashcard via the ViewModel’s exposed methods if needed.

struct CardView: View {
    @State private var isFlipped = false // Track flip state for each card
    @State private var isEditing = false // Track if the card is in edit mode
    @State private var flashcard: FlashcardTask // Use protocol for flexibility
    
    var deleteAction: () -> Void // Closure for deleting the flashcard
    
    init(flashcard: FlashcardTask, deleteAction: @escaping () -> Void) {
        _flashcard = State(initialValue: flashcard)
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        ZStack() {
            if !isFlipped {
                // Front of the card
                VStack {
                    if isEditing {
                        TextField("Edit Front Text", text: $flashcard.frontText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    } else {
                        Text(flashcard.frontText)
                            .textStyle(Title_1())
                    }
                    
                    Text(flashcard.category)
                        .textStyle(Footnote___Bold())
                    
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Done" : "Edit")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    // Delete button
                    Button(action: {
                        deleteAction() // Call delete action when pressed
                    }) {
                        Text("Delete")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 320, alignment: .center)
                .background(Color.white.opacity(0.9))
                .shadow(color: .white.opacity(0.25), radius: 2, x:0, y:2)
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color(hex: 0x42b53), lineWidth: 2)
                )
                .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
                .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
                .onTapGesture {
                    // Only flip the card if it's not in editing mode
                    if !isEditing {
                        withAnimation {
                            isFlipped.toggle()
                        }
                    }
                }
            } else {
                // Back of the card
                VStack {
                    if isEditing {
                        TextField("Edit Back Text", text: $flashcard.backText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundStyle(.black)
                            .padding()
                    } else {
                        Text(flashcard.backText)
                    }
                    
                    //                    Spacer()
                    
                    Text(flashcard.category)
                        .textStyle(Footnote___Bold())
                    
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Done" : "Edit")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    // Delete button
                    Button(action: {
                        deleteAction() // Call delete action when pressed
                    }) {
                        Text("Delete")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 320, alignment: .center)
                .foregroundStyle(.white)
                .background(Color(hex: 0x212121))
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color(hex: 0xc7c7cc), lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)

                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) // Ensure back is upright
                .onTapGesture {
                    // Only flip the card if it's not in editing mode
                    if !isEditing {
                        withAnimation {
                            isFlipped.toggle()
                        }
                    }
                }
            }
        }
        .padding()
        .frame(width: 366, height: 320)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0)) // Flip effect
        .animation(.spring(), value: isFlipped)
    }
    
    // MARK: additional structs for Text Styles (like Footnote___Bold, Title_1, etc.)
    struct Footnote___Bold: ViewModifier {
        var lineSpacing: CGFloat {
            return 16 - UIFont.systemFont(ofSize: 17).lineHeight
        }
        func body(content: Content) -> some View {
            content
                .font(.system(size: 17))
                .tracking(1.00)
                .opacity(0.2)
                .padding([.horizontal, .top], 16)
                .padding(.bottom, 24)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(lineSpacing)
        }
    }
    
    struct Title_1: ViewModifier {
        var lineSpacing: CGFloat {
            return 26 - UIFont.systemFont(ofSize: 17).lineHeight
        }
        func body(content: Content) -> some View {
            content
                .font(.system(size: 17))
                .tracking(0.36)
                .foregroundStyle(Color(hex: 0x9266be))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(lineSpacing)
        }
    }
    
    // Similarly, Implement other text styles here...
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
