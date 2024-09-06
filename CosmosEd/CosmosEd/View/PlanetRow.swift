//
//  PlanetRow.swift
//  CosmosEd
//
//  Created by Hang Vu on 5/9/2024.
//

//struct PlanetRow: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import SwiftUI
struct PlanetRow: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView([.vertical, .horizontal], showsIndicators: true) {
                    HStack (spacing: 0) {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(alignment: .leading, spacing:0) {}
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .frame(height: 100, alignment: .topLeading)
                        .clipped()
                        .overlay(alignment: .init(horizontal: .leading, vertical: .center)) {
                            ScrollView(.vertical, showsIndicators: true) {
                                HStack(spacing:8) {
                                    Image(systemName: "info.circle")
                                      .font(.system(size: 26, weight: .bold))
                                      .foregroundStyle(Color(hex: 0xc7c7cc))
                                      .frame(width: 44, height: 44)
                                    Text("General Information")
                                    // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                                      .font(.custom("SFProRounded-Medium", size: 30))
                                      .tracking(2.00)
                                      .foregroundStyle(Color(hex: 0xc7c7cc))
                                      .fixedSize(horizontal: false, vertical: true)
                                      .clipped()
                                }
                            }
                            .frame(height: 32, alignment: .leading)
                            .clipped()
                            .offset(x: 6, y: -13)
                        }
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: "chevron.forward")
                              .font(.system(size: 20, weight: .semibold))
                              .foregroundStyle(Color(hex: 0x8e8e93))
                              .frame(width: 87, height: 78)
                        }
                    }
                }
                .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
                .background(LinearGradient(gradient:
                Gradient(stops: [.init(color: Color(hex: 0x303030), location: CGFloat(0)), .init(color: Color(hex: 0x232323), location: CGFloat(0.518310546875)), .init(color: Color(hex: 0x202020), location: CGFloat(1))])
                , startPoint: UnitPoint(x: 0, y: 0.49999999999999994), endPoint: UnitPoint(x: 1, y: 0.5))
                .ignoresSafeArea())
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            }
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
            .overlay(
            VStack {}
            .frame(width: 395, height: 1)
            .background(Color(hex: 0xaeaeb2))
            .offset(x: 3, y: 222)
            , alignment: .center).overlay(
            VStack {}
            
            //  THE LINE
            .frame(width: 395, height: 1)
            .background(Color(hex: 0xaeaeb2))
            .offset(x: 3, y: -145)
            //  THE LINE
            
            , alignment: .center)
            
            
            .overlay(
            ZStack() {}
            .frame(width: 230, height: 156, alignment: .bottomLeading)
            .overlay(alignment: .top) {
                ZStack() {
                    Text("Time")
                    // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                      .font(.custom("SFProRounded-Medium", size: 28))
                      .padding(12)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                      .frame(height: 54, alignment: .topLeading)
                      .foregroundStyle(Color(hex: 0x26201b))
                      .clipped()
                      .offset(x: 1)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: 55, alignment: .top)
                .background(Color(hex: 0xaeaeb2))
                
            }
            .background(alignment: .topLeading) {
                VStack {}
                .frame(width: 430, alignment: .topLeading)
            }
            .overlay(alignment: .center) {
                ZStack() {
                    VStack(alignment: .trailing, spacing:18) {
                        Text("24.65 hrs")
                        // MARK: Add SFProRounded-Regular file to Xcode, and reference it below:
                          .font(.custom("SFProRounded-Regular", size: 16))
                          .foregroundStyle(Color(hex: 0xe5e5ea))
                          .fixedSize(horizontal: false, vertical: true)
                          .clipped()
                        Text("0.0341")
                        // MARK: Add SFProRounded-Regular file to Xcode, and reference it below:
                          .font(.custom("SFProRounded-Regular", size: 16))
                          .foregroundStyle(Color(hex: 0xe5e5ea))
                          .fixedSize(horizontal: false, vertical: true)
                          .clipped()
                    }
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                    .frame(height: 69, alignment: .topTrailing)
                    .background(.white.opacity(0))
                    .offset(y: 15)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(height: 85, alignment: .topLeading)
                .overlay(alignment: .topLeading) {
                    HStack(spacing:1) {
                        Image(systemName: "hourglass")
                          .font(.system(size: 22, weight: .regular))
                          .foregroundStyle(Color(hex: 0xe5e5ea))
                          .frame(width: 50, height: 44)
                          .background(.white.opacity(0))
                        Text("Length of day")
                        // MARK: Add SFProRounded-Regular file to Xcode, and reference it below:
                          .font(.custom("SFProRounded-Regular", size: 17))
                          .foregroundStyle(Color(hex: 0xe5e5ea))
                          .background(.white.opacity(0))
                          .fixedSize(horizontal: false, vertical: true)
                          .clipped()
                    }
                    .frame(width: 147, alignment: .leading)
                }
                .overlay(alignment: .bottomLeading) {
                    HStack(spacing:12) {
                        Image(systemName: "bubbles.and.sparkles")
                          .font(.system(size: 19, weight: .regular))
                          .foregroundStyle(Color(hex: 0xe5e5ea))
                          .frame(width: 32, height: 44)
                          .background(.white.opacity(0))
                        Text("Length of year")
                        // MARK: Add SFProRounded-Regular file to Xcode, and reference it below:
                          .font(.custom("SFProRounded-Regular", size: 17))
                          .foregroundStyle(Color(hex: 0xe5e5ea))
                          .background(.white.opacity(0))
                          .fixedSize(horizontal: false, vertical: true)
                          .clipped()
                    }
                    .padding(.horizontal, 4)
                    .frame(width: 148, alignment: .leading)
                    .background(.white.opacity(0))
                    .offset(x: 7, y: -3)
                }
                .background(.white.opacity(0))
                .offset(x: -5, y: 25)
            }
            .background(.white.opacity(0.22))
            .cornerRadius(32)
            .overlay(
            RoundedRectangle(cornerRadius: 32)
            .stroke(Color(hex: 0xd1d1d6), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
            )
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            .scaleEffect(0.99)
            .offset(x: -81, y: -248)
            , alignment: .center).overlay(
            AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2FDVvv072fJjMTxKrFroV8%2FsharedAssets%2F3d40642e79ee00Az4K0-raw.png?alt=media&token=ab0d0973-8213-4b36-a213-2809f7222472")) { image in
                image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 141)
                .clipped()
            } placeholder: {
                ProgressView()
            }
            .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16)
            .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2)
            .offset(x: 123, y: -248)
            , alignment: .center).overlay(
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing:0) {}
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .frame(height: 100, alignment: .topLeading)
            .clipped()
            .offset(x: 6, y: -109)
            .overlay(alignment: .init(horizontal: .leading, vertical: .center)) {
                ScrollView([.vertical, .horizontal], showsIndicators: true) {
                        HStack(spacing:8) {
                            Image(systemName: "photo.circle")
                              .font(.system(size: 26, weight: .bold))
                              .foregroundStyle(Color(hex: 0xc7c7cc))
                              .frame(width: 44, height: 44)
                            Text("Images/ Video")
                            // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                              .font(.custom("SFProRounded-Medium", size: 30))
                              .tracking(2.00)
                              .frame(width: 298, alignment: .topLeading)
                              .foregroundStyle(Color(hex: 0xc7c7cc))
                              .fixedSize(horizontal: false, vertical: true)
                              .clipped()
                        }
                    }
                    .frame(width: 327, height: 32, alignment: .leading)
                    .clipped()
                    .offset(x: 1, y: -1)
                }
                .overlay(alignment: .init(horizontal: .trailing, vertical: .center)) {
                    Image(systemName: "chevron.forward")
                      .font(.system(size: 20, weight: .semibold))
                      .foregroundStyle(Color(hex: 0x8e8e93))
                      .frame(width: 87, height: 78)
                }
                , alignment: .center).overlay(
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading, spacing:0) {}
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(height: 100, alignment: .topLeading)
                .clipped()
                .offset(x: 9, y: 272)
                .overlay(alignment: .init(horizontal: .leading, vertical: .center)) {
                    HStack(spacing:8) {
                        Image(systemName: "beats.headphones")
                          .font(.system(size: 26, weight: .bold))
                          .foregroundStyle(Color(hex: 0xc7c7cc))
                          .frame(width: 44, height: 44)
                        Text("Sounds")
                        // MARK: Add SFProRounded-Medium file to Xcode, and reference it below:
                          .font(.custom("SFProRounded-Medium", size: 30))
                          .tracking(2.00)
                          .foregroundStyle(Color(hex: 0xc7c7cc))
                          .fixedSize(horizontal: false, vertical: true)
                          .clipped()
                    }
                    .offset(x: 1, y: -1)
                }
                .overlay(alignment: .init(horizontal: .leading, vertical: .center)) {
                    Image(systemName: "chevron.forward")
                      .font(.system(size: 20, weight: .semibold))
                      .foregroundStyle(Color(hex: 0x8e8e93))
                      .frame(width: 87, height: 78)
                      .offset(x: 341, y: -2)
                }
                , alignment: .center).overlay(
                VStack(alignment: .leading, spacing:0) {
                    AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2FDVvv072fJjMTxKrFroV8%2FsharedAssets%2F3d406502ab3800JKLrg-raw.jpeg?alt=media&token=c5fe8958-7795-4062-a722-ddea102262c2")) { image in
                        image.resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 415, height: 253)
                          .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(64)
                    .overlay(
                    RoundedRectangle(cornerRadius: 64)
                    .stroke(Color(hex: 0xc7c7cc), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
                    )
                    .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.11), radius: 6, x: 0, y: 8)
                }
                .frame(width: 415, alignment: .topLeading)
                .offset(x: 1, y: 50)
                , alignment: .center).overlay(
                Image(systemName: "arrowtriangle.forward.circle.fill")
                .font(.system(size: 50, weight: .regular))
                .foregroundStyle(Color(UIColor.systemGray5))
                .frame(width: 88, height: 68)
                .offset(x: -4, y: 48)
                , alignment: .center).overlay(
                ZStack() {
                    ZStack() {}
                    .frame(width: 384, height: 125, alignment: .bottomLeading)
                    .overlay(alignment: .top) {
                        ZStack() {
                            Text("Tap to hear")
                            // MARK: Add SFProRounded-Regular file to Xcode, and reference it below:
                              .font(.custom("SFProRounded-Regular", size: 25))
                              .padding(12)
                              .frame(maxWidth: .infinity, alignment: .top)
                              .frame(height: 47, alignment: .top)
                              .multilineTextAlignment(.center)
                              .clipped()
                              .offset(x: 1)
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                        .frame(height: 55, alignment: .top)
                        .background(Color(hex: 0xaeaeb2))
                    }
                    .overlay(alignment: .center) {
                        Image(systemName: "speaker.wave.3")
                          .font(.system(size: 30, weight: .medium))
                          .foregroundStyle(Color(hex: 0xc7c7cc))
                          .frame(width: 64, height: 60)
                          .offset(x: -10, y: 15)
                    }
                    .background(.white.opacity(0.22))
                    .cornerRadius(32)
                    .overlay(
                    RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(hex: 0xd1d1d6), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
                    )
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .scaleEffect(0.99)
                    .offset(x: 13, y: 2)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(height: 156, alignment: .topLeading)
                .offset(x: 12, y: -6)
                , alignment: .bottom)
            }
}

#Preview {
    PlanetRow()
}
