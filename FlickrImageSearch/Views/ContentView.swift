//
//  ContentView.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    @State private var searchText = ""
    private let searchTextPublisher = PassthroughSubject<String, Never>()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search Flickr", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchText) { newValue in
                        searchTextPublisher.send(newValue)
                    }

                // Content
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if viewModel.photos.isEmpty && !searchText.isEmpty {
                    Text("No results found")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                   // PhotoGrid(photos: viewModel.photos)
                }
                PhotoGrid(photos: viewModel.photos)
            }
            .navigationTitle("Flickr Search")
            .onAppear {
                viewModel.bindSearch(searchTextPublisher: searchTextPublisher)
            }
        }
    }
}

struct PhotoGrid: View {
    let photos: [FlickrItem]
    let columns = [GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(photos) { photo in
                    NavigationLink(destination: DetailView(photo: photo)) {
                        AsyncImage(url: URL(string: photo.media.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(height: 200)
                                .overlay(ProgressView())
                        }
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ContentView()
}
