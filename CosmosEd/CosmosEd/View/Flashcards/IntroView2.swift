//
//  QuizView.swift
//  CosmosEd

import SwiftUI

struct IntroView2: View {
    @State var geo: CGSize = .zero
    //  MARK: - Body
    var body: some View {
        
        ZStack {
            //  MARK: Background Color
            BGM_Color
            VStack {
                Spacer()
                //  MARK: - Display Quizzes Overview
                //  DISPLAY QUIZZES' LABEL
                VStack() {
                    
                    Text("Flashcards")
                        .font(.system(size: 26, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(hex: 0xff7600))
                        .padding(.vertical, 5)
                        .tracking(3.0)
                    
                    Text("Expand your knowledge of space through flashcards on planets, stars, galaxies, and more. \nSwipe through and test yourself!")
                        .font(.system(size: 22, weight: .light, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .tracking(3.0)
                        .padding()
                    
                }// (I) - End Of VStack2
                
                //  DISPLAY QUIZZES' TAB
                VStack {
                    ZStack(alignment: .leading) {
                        // Background with rounded corners
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.4))
                            .frame(width: 350, height: 400)
                            .shadow(color: .black.opacity(0.25), radius: 2, x:0, y:2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                            )
                            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 10, x: 0, y: 5)
                        
                        VStack(alignment: .leading, spacing: 32) {
                            // Overlay content
                                Image("Earth")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                
                                Text("Dive into the depths of space with questions on planets, stars, galaxies, and more. Challenge yourself and see how much you really know about the universe!")
                                    .textStyle(Quote())
                                
                                // Overlay content 2 - QUESTION
                                VStack(alignment: .leading, spacing:4) {
                                    Text("Question")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Text("5 Flashcards")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                        .opacity(0.4)
                                }
                                
                                // Overlay content 3 - TIME
                                VStack(alignment: .leading, spacing:4) {
                                    
                                    Text("Estimate Time")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                        .clipped()
                                    Text("None")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                        .opacity(0.4)
                                    
                                }
                                
                            
                            
                        }// End Of VStack2
                        .padding()
                        .padding(.top, 5)

                    } // End of ZStack 2
                    
                }// (I) - End Of VStack - Quizzes Tab
                .padding(20)
                
                Spacer()
                
                //  MARK: - Display Join Button
                NavigationLink {
                    //  ACTION GOES HERE
                    FlashcardView()
                }label: {
                    ZStack {
                        HStack(spacing:4) {
                            Image(systemName: "bubbles.and.sparkles.fill")
                              .font(.system(size: 22, weight: .regular))
                              .imageScale(.small)
                              .symbolRenderingMode(.hierarchical)
                              .foregroundStyle(Color(hex: 0xff7600))
                              .frame(width: 32, height: 32)
                            Text("JOIN")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                              .foregroundStyle(Color(hex: 0xf7f7f7))
                              .tracking(2.0)
                              .shadow(color: .white.opacity(0.5), radius: 4, x:0, y:2)
                    
                        }// End of HStack Button's Details
                        .frame(maxWidth: 300, maxHeight: 50, alignment: .center)
                        .background(Color(hex: 0x4a4b50, alpha: 0.4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                        )
                        //  Button Designing
                        .shadow(color: .black.opacity(0.5), radius: 4, x:6, y:9)
                        .shadow(color: .white.opacity(0.7), radius: 4, x:2, y:-5)
                        .cornerRadius(32)
                    }
                }
                Spacer()
            }// (O) - End Of Main VStack
        }// (O) - End Of Main ZStack
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
    
    // MARK: additional structs
    struct Quote: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProDisplay-Regular", size: 16), size: 16)
            return 20 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
                .font(.custom("SFProDisplay-Regular", size: 16))
                .clipped()
                .foregroundStyle(.white)
                .opacity(0.75)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(lineSpacing)
        }
    }
}

//  MARK: - EXTENSION
extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

//  MARK: - Preview
#Preview {
    NavigationStack {
        IntroView2()
    }
}
