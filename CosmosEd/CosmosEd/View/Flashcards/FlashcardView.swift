//
//  FlashcardView.swift
//  CosmosEd


import SwiftUI

//  MARK: - Step 5.1: Update FlashcardView to Use the ViewModel
//  refactor the FlashcardView so it interacts with the FlashcardViewModel. This way, the view is only responsible for rendering the UI and reacting to changes from the ViewModel.

struct FlashcardView: View {
    
    //  MARK: - Propertities
    
    //  Use the ViewModel to manage flashcard data and logic
    @StateObject var viewModel = FlashcardViewModel()
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            
            //  MARK: Background color theme
            BGM_Color
            
            //  MARK:
            VStack(alignment: .leading) {
                
                // MARK: - ScrollViewReader
                // ScrollViewReader allows programmatic scrolling to specific flashcards based on their ID
                ScrollViewReader { proxy in
                    
                    // MARK: ScrollView - to horizontally scroll through flashcards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            
                            //  MARK: ForEach - Loop through each flashcard in the ViewModel
                            ForEach(viewModel.flashcards) { flashcard in
                                VStack {
                                    
                                    //  CardView to render each individual flashcard
                                    CardView(flashcard: flashcard, viewModel: viewModel, deleteAction: {
                                        viewModel.deleteFlashcard(flashcard) // Delete flashcard action
                                    })
                                }
                                .id(flashcard.id) // Give each flashcard an unique id, important for scrolling
                            }
                            //  Ensure the ScrollView takes the full width of the screen and centers the cards
                            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                        }
                        
                        // MARK: - Handle changes in flashcard count
                        //  When the number of flashcards changes, scroll to the last added flashcard
                        .onChange(of: viewModel.flashcards.count) { _ in
                            // Scroll to the newly added flashcard when the count changes
                            if let lastFlashcard = viewModel.flashcards.last {
                                proxy.scrollTo(lastFlashcard.id, anchor: .center)
                            }
                        }
                    }
                    // MARK: Framesize - Set the frame size for ScrollView
                    .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                }
                
                // MARK: - Button to add new flashcard
                Button(action: {
                    // Call ViewModel to add a new flashcard
                    viewModel.addFlashcard(frontText: "New Front", backText: "New Back", category: "Category")
                }) {
                    Spacer()
                    addFlashcard_Btn
                    Spacer()
                }
                .offset(y: -100) // Adjust button position
            }// End of VStack
            //  Ensure the VStack is full screen width
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
        }
    }
    
    //  MARK: - SubView
    //  MARK: Adding flashcard button
    //  Reusable button component for adding flashcards
    var addFlashcard_Btn: some View {
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
    }
    
    //  MARK: - BACKGROUND COLOR THEME
    var BGM_Color: some View {
        ZStack{}
            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(LinearGradient(gradient:
                                        Gradient(stops: [.init(color: Color(hex: 0x303030), location: CGFloat(0)), .init(color: Color(hex: 0x232323), location: CGFloat(0.518310546875)), .init(color: Color(hex: 0x202020), location: CGFloat(1))])
                                       , startPoint: UnitPoint(x: 0, y: 0.49999999999999994), endPoint: UnitPoint(x: 1, y: 0.5))
                .ignoresSafeArea())
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

//  MARK: - Previews
#Preview {
    FlashcardView()
}
