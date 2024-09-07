//
//  FlashcardView.swift
//  CosmosEd


import SwiftUI

//  MARK: - Step 5.1: Update ContentView to Use the ViewModel
//  Next, we refactor the ContentView so it interacts with the FlashcardViewModel. This way, the view is only responsible for rendering the UI and reacting to changes from the ViewModel.

struct FlashcardView: View {
    @StateObject var viewModel = FlashcardViewModel() // Use the ViewModel
    
    var body: some View {
        ZStack {
            // Background gradient that fills the entire screen
            LinearGradient(gradient: Gradient(stops: [
                .init(color: Color(hex: 0x5856d6), location: 0.6),
                .init(color: Color(hex: 0xdbaf0), location: 0)
            ]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all) // Ignore safe area to cover the entire screen
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.flashcards) { flashcard in
                            VStack {
                                CardView(flashcard: flashcard, deleteAction: {
                                    viewModel.deleteFlashcard(flashcard)
                                })
                            }
                        }
                    }
                    .padding(10)
                    .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                    .background(LinearGradient(gradient:
                                                Gradient(stops: [.init(color: Color(hex: 0x5856d6), location: 0.8), .init(color: Color(hex: 0xdbaf0), location: 1)]),
                                               startPoint: .top, endPoint: .bottom))//0xdba9f0
                }
                
                // Button to add new flashcard
                Button(action: {
                    viewModel.addFlashcard(frontText: "New Front", backText: "New Back", category: "Category")
                }) {
                    Spacer()
                    Text("Add Flashcard")
                        .font(.headline)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: 0xc7c7cc), lineWidth: 2)
                        )
                        .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 10)
                        .padding(.top)
                    Spacer()
                }
                .offset(y: -100)
            }// End of VStack
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
        }
    }
}



#Preview {
    FlashcardView()
}
