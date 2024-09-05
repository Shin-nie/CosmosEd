//
//  ContentView.swift
//  CosmosEd

import SwiftUI
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaTop = window?.safeAreaInsets.top
let safeAreaBottom = window?.safeAreaInsets.bottom
struct ContentView: View {
    @State var geo1: CGSize = .zero
    @State var geo2: CGSize = .zero
    @State var geo: CGSize = .zero
    @State private var selection_mhx: String = "X Axis"
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack (spacing: 0) {
                    VStack(spacing:16) {
                        Picker("", selection: $selection_mhx) {
                            ForEach(["Sun","Mecury","Venus","Earth"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: .infinity)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing:0) {
                                ZStack() {
                                    Text("Sun")
                                      .font(.custom("SFProDisplay-Regular", size: 17))
                                      .frame(width: 406 * 0.7, height: 56, alignment: .center)
                                      .cornerRadius(12).opacity(0.5)
                                      .multilineTextAlignment(.center)
                                      .clipped()
                                      .offset(y: -180)
                                    
                                    Image("Sun")
                                        .resizable()
                                        .frame(width: 350, height: 350)
                                }
                                .padding(.horizontal, 16)
                                .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                                .frame(width: 406, alignment: .center)


                                //  ANOTHER PLANET - MERCURY
                                ZStack() {
                                    Text("Mercury")
                                      .font(.custom("SFProDisplay-Regular", size: 17))
                                      .frame(maxWidth: .infinity, alignment: .center)
                                      .opacity(0.4)
                                      .multilineTextAlignment(.center)
                                      .fixedSize(horizontal: false, vertical: true)
                                      .clipped()
                                      .offset(y: -180)
                                    Image("Mercury")
                                        .resizable()
                                        .frame(width: 300, height: 300)
                                }
                                .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                                .frame(width: 406, alignment: .center)
//                                .background(alignment: .top) {
//                                   
//                                }
                                
                                
                                //  ANOTHER PLANET -
                                ZStack() {
                                    Text("Venus")
                                    // MARK: Add SFProDisplay-Regular file to Xcode, and reference it below:
                                      .font(.custom("SFProDisplay-Regular", size: 17))
                                      .frame(maxWidth: .infinity, alignment: .center)
                                      .opacity(0.4)
                                      .multilineTextAlignment(.center)
                                      .fixedSize(horizontal: false, vertical: true)
                                      .clipped()
                                      .offset(y: -180)
                                    Image("Venus")
                                        .resizable()
                                        .frame(width: 300, height: 300)
                                }
                                .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                                .frame(width: 406, alignment: .center)
//                                .background(alignment: .top) {
//                                   
//                                }
                            }
                        }
                    }
                    //  BOTTOM-MENU ALIGNMENT
                    .padding(.top, safeAreaTop)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .frame(height: geo.height * 0.84, alignment: .top)
                    
                    ZStack() {
                        HStack(spacing:8) {
//                            Text("Examples")
//                            // MARK: Add SFProText-Medium file to Xcode, and reference it below:
//                              .font(.custom("SFProText-Medium", size: 14))
//                              .opacity(0.5)
//                              .fixedSize(horizontal: false, vertical: true)
//                              .clipped()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        //  MARK: BOTTOM-MENU
                        VStack(alignment: .leading, spacing:8) {
                            HStack(spacing:4) {
                                Text("General Information")
                                  .font(.custom("SFProRounded-Medium", size: 16))
                                  .fixedSize(horizontal: false, vertical: true)
                                  .clipped()
                                Spacer()
                                Image(systemName: "square.3.layers.3d.down.right")
                                  .font(.system(size: 20, weight: .regular))
                                  .imageScale(.small)
                                  .symbolRenderingMode(.hierarchical)
                                  .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 44, alignment: .center)
                            .background(.black.opacity(0.1))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            
                            
                            
                            HStack(spacing:4) {
                                Text("Panorama")
                                // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                                  .font(.custom("SFProRounded-Medium", size: 16))
                                  .fixedSize(horizontal: false, vertical: true)
                                  .clipped()
                                Spacer()
                                Image(systemName: "pano.fill")
                                  .font(.system(size: 20, weight: .regular))
                                  .imageScale(.small)
                                  .symbolRenderingMode(.hierarchical)
                                  .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 44, alignment: .center)
                            .background(.black.opacity(0.1))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            HStack(spacing:4) {
                                Text("Glowing Button")
                                // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                                  .font(.custom("SFProRounded-Medium", size: 16))
                                  .fixedSize(horizontal: false, vertical: true)
                                  .clipped()
                                Spacer()
                                Image(systemName: "aqi.medium")
                                  .font(.system(size: 20, weight: .medium))
                                  .symbolRenderingMode(.hierarchical)
                                  .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 44, alignment: .center)
                            .background(.black.opacity(0.1))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            HStack(spacing:4) {
                                Text("Cover Flow")
                                // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                                  .font(.custom("SFProRounded-Medium", size: 16))
                                  .fixedSize(horizontal: false, vertical: true)
                                  .clipped()
                                Spacer()
                                Image(systemName: "square.stack", variableValue: 1.00)
                                  .font(.system(size: 20, weight: .regular))
                                  .imageScale(.small)
                                  .symbolRenderingMode(.hierarchical)
                                  .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 44, alignment: .center)
                            .background(.black.opacity(0.1))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            HStack(spacing:4) {
                                Text("Directions")
                                // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                                  .font(.custom("SFProRounded-Medium", size: 16))
                                  .fixedSize(horizontal: false, vertical: true)
                                  .clipped()
                                Spacer()
                                Image(systemName: "arrow.up.forward.circle.fill")
                                  .font(.system(size: 20, weight: .regular))
                                  .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 44, alignment: .center)
                            .background(.black.opacity(0.1))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            HStack(spacing:4) {
                                Text("Flashlight")
                                // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                                  .font(.custom("SFProRounded-Medium", size: 16))
                                  .fixedSize(horizontal: false, vertical: true)
                                  .clipped()
                                Spacer()
                                Image(systemName: "flashlight.on.fill")
                                  .font(.system(size: 20, weight: .regular))
                                  .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 44, alignment: .center)
                            .background(.black.opacity(0.1))
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.bottom, safeAreaBottom)
                    .padding([.horizontal, .top], 16)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .frame(height: geo.height * 0.6, alignment: .top)
                    .background(.white)
                    .cornerRadius(24, corners: [.topRight, .topLeft])
                    }
                }
                .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .top)
                .background(LinearGradient(gradient:
                Gradient(stops: [.init(color: .white, location: CGFloat(0)), .init(color: Color(hex: 0xc7cccd), location: CGFloat(0.9701334635416666))])
                    , startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
                    .ignoresSafeArea())
                    .saveSize(in: $geo)
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
                .overlay(
                VStack {}
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(height: 200, alignment: .topLeading)
                .background(.white)
                .opacity(0)
                , alignment: .bottom).overlay(
                VStack(spacing:0) {
                    Text("CosmosEd")
                    // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                      .font(.custom("SFProRounded-Medium", size: 24))
                      .frame(maxWidth: .infinity, alignment: .center)
                      .frame(height: 32, alignment: .center)
                      .opacity(0.85)
                      .multilineTextAlignment(.center)
                      .clipped()
                }
                .offset(y: -50)
                .padding(.top, safeAreaTop)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(LinearGradient(gradient:
                Gradient(stops: [.init(color: .white, location: CGFloat(0)), .init(color: .white.opacity(0), location: CGFloat(1))])
                , startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
                )
                , alignment: .top).overlay(
                HStack(spacing:0) {
                    Image(systemName: "square.grid.2x2.fill")
                      .font(.system(size: 18, weight: .regular))
                      .imageScale(.small)
                      .foregroundStyle(.white)
                      .frame(width: 28, height: 28)
                    Text("Gallery")
                    // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
                      .font(.custom("SFProText-Semibold", size: 14))
                      .foregroundStyle(.white)
                      .fixedSize(horizontal: false, vertical: true)
                      .clipped()
                }
                .padding(.trailing, 12)
                .padding(.leading, 8)
                .frame(height: 40, alignment: .center)
                .background(.black)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 48, style: .continuous))
                .shadow(color: .black.opacity(0.24), radius: 12, x: 0, y: 4)
                .padding(.bottom, safeAreaBottom)
                , alignment: .bottom)
                .ignoresSafeArea(.all, edges: [.bottom])
                }
}

//  MARK: - Color
extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

// MARK: Allows for percentage based layouts
struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear
                .onAppear { size = proxy.size }
            }
        )
    }
}

// MARK: Enables setting individual vales per corner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//  MARK: - EXTENSION VIEW
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

//  MARK: - PREVIEW
#Preview {
    ContentView()
}
