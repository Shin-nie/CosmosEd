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
            BGM_Color
            
            VStack(alignment: .leading) {
                //                ScrollView(.horizontal, showsIndicators: false) {
                //                    HStack(spacing: 16) {
                //                        ForEach(viewModel.flashcards) { flashcard in
                //                            VStack {
                //                                CardView(flashcard: flashcard, viewModel: viewModel, deleteAction: {
                //                                    viewModel.deleteFlashcard(flashcard)
                //                                })
                //                            }
                //                        }
                //                    }
                ////                    .padding(10)
                //                    .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                //
                //                }
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.flashcards) { flashcard in
                                VStack {
                                    CardView(flashcard: flashcard, viewModel: viewModel, deleteAction: {
                                        viewModel.deleteFlashcard(flashcard)
                                    })
                                }
                                .id(flashcard.id) // Give each flashcard an id
                            }
                            //  Make ScrollView not appear the line
                            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                        }
                        .onChange(of: viewModel.flashcards.count) { _ in
                            // Scroll to the newly added flashcard
                            if let lastFlashcard = viewModel.flashcards.last {
                                proxy.scrollTo(lastFlashcard.id, anchor: .center)
                            }
                        }
                    }
                    .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
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
