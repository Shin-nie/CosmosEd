//
//  SearchBar.swift
//  CosmosEd

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
//                .padding()
//                .background(Color(.systemGray5))
//                .cornerRadius(8)
//                .padding(.horizontal)
        }
        .padding(.top)
    }
}

//  MARK: Preview
#Preview {
    @State var searchText = ""
    return SearchBar(text: $searchText, placeholder: "Search")
}
