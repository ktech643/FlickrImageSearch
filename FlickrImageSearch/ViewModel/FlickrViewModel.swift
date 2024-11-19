//
//  Untitled.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import SwiftUI
import Combine

class FlickrViewModel: ObservableObject {
    @Published private(set) var photos: [FlickrItem] = []
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private var currentSearchText: String = ""
    let service = NetworkService()
    
    func bindSearch(searchTextPublisher: PassthroughSubject<String, Never>) {
        searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.searchPhotos(searchText: searchText)
            }
            .store(in: &cancellables)
    }

    func searchPhotos(searchText: String) {
        guard !searchText.isEmpty, searchText != currentSearchText else { return }

        currentSearchText = searchText
        isLoading = true

        // Simulated API Call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            service.fetchPhotos(searchText: searchText) { resp in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if self.currentSearchText == searchText {
                        self.updatePhotosIfChanged(newPhotos: resp?.items ?? [FlickrItem]())
                        self.isLoading = false
                    }
                }
            }
            
        }
    }

    private func updatePhotosIfChanged(newPhotos: [FlickrItem]) {
        photos = newPhotos
    }
}
