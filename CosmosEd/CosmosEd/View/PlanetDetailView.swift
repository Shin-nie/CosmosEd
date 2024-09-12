//
//  Test2.swift
//  CosmosEd


import SwiftUI

struct PlanetDetailView: View {
    //  MARK: - Properties
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    //  MARK: - Body
    var body: some View {
        ZStack {
            BGM_Color
            VStack(alignment: .leading) {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //  MARK: INFORMATION SECTION
                    // NavigationLink wrapping both SectionHeader and GeneralInfoCard
                    NavigationLink(destination: PlanetInfoView()) {
                        VStack {
                            SectionHeader(iconName: "info.circle", title: "General Information")
                            GeneralInfoCard(name: "Mercury", mass: "0.000174", period: "88")

                        }
                    }
                    
                    divider
                    
                    //  MARK: VIDEO SECTION
                    // Videos Section
                    
                    //  MARK: nho pass viewModel lai dang hoang
                    NavigationLink(destination: VideoView(viewModel: PlanetViewModel())) {
                        VStack {
                            SectionHeader(iconName: "play.rectangle.fill", title: "Videos")
                            MediaView(imageName: "mercuryNasa", iconOverlay: "arrowtriangle.forward.circle.fill")
                        }
                    }
                    
                    divider
                    
                    //  MARK: IMAGE SECTION
                    // Images Section
                    NavigationLink (destination: ImageView()) {
                        VStack {
                            SectionHeader(iconName: "photo.on.rectangle.angled", title: "Image")
                            MediaView(imageName: "MercuryImage")
                        }
                    }
                }// End of ScrollView
            }// End of VStack
        }// End of ZStack
    }
    
    // MARK: - Reusable Divider
    var divider: some View {
        VStack {}
            .frame(width: 360, height: 0.6)
            .background(Color(hex: 0xaeaeb2))
            .padding(.vertical, 15)
//            .padding()
    }
    
    // MARK: - Background Color Theme
    var BGM_Color: some View {
        ZStack {}
            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(hex: 0x303030), location: 0),
                    .init(color: Color(hex: 0x232323), location: 0.518),
                    .init(color: Color(hex: 0x202020), location: 1)
                ]),
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea())
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

// MARK: - Section Header
struct SectionHeader: View {
    let iconName: String
    let title: String

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: iconName)
                .font(.system(size: 23, weight: .bold))
                .foregroundStyle(Color(hex: 0xc7c7cc))
                .padding(.trailing, 8)
            
            Text(title)
                .font(.system(size: 27, weight: .medium, design: .rounded))
                .tracking(2.00)
                .foregroundStyle(Color(hex: 0xc7c7cc))
            
            Spacer()
            Image(systemName: "chevron.forward")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color(hex: 0x8e8e93))
        }
        .padding(.horizontal, 20)
        .padding()
    }
}

// MARK: - General Info Card
struct GeneralInfoCard: View {
    let name: String
    let mass: String
    let period: String

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.white.opacity(0.22))
                    .frame(width: 230, height: 156)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color(hex: 0xd1d1d6), lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .tracking(2.0)
                        .padding(12)
                        .frame(width: 230, alignment: .leading)
                        .foregroundStyle(.black.opacity(0.65))
                        .background(Color(hex: 0xaeaeb2))
                        .cornerRadius(32, corners: [.topLeft, .topRight])
                        .offset(y: -15)

                    VStack(alignment: .leading, spacing: 18) {
                        InfoRow(iconName: "scalemass.fill", label: "mass", value: mass)
                        InfoRow(iconName: "circle.dotted.and.circle", label: "Period", value: period)
                    }
                    .padding(.horizontal, 8)
                }
                .padding(12)
            }
            Image("Mercury")
                .resizable()
                .frame(width: 130, height: 130)
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16)
                .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2)
                .offset(x: -10)
        }
        .padding()
    }
}

// MARK: - InfoRow for Mass and Period
struct InfoRow: View {
    let iconName: String
    let label: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.system(size: 22))
                .foregroundColor(Color(hex: 0xe5e5ea))
            
            Text(label)
                .font(.system(size: 17))
                .foregroundColor(Color(hex: 0xe5e5ea))
            
            Spacer()
            Text(value)
                .font(.system(size: 17))
                .foregroundColor(Color(hex: 0xe5e5ea))
        }
    }
}

// MARK: - Media View for Videos and Images
struct MediaView: View {
    let imageName: String
    var iconOverlay: String? = nil

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .opacity(0.7)
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 200)
                .cornerRadius(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color(hex: 0xc7c7cc), lineWidth: 1)
                )
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.25), radius: 7, x: 0, y: 5)
                .padding()

            if let iconOverlay = iconOverlay {
                Image(systemName: iconOverlay)
                    .font(.system(size: 50, weight: .regular))
                    .foregroundStyle(Color(UIColor.systemGray4))
            }
        }
        .padding(.top, -20)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PlanetDetailView()
    }
}
