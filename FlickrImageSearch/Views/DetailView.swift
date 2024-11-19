//
//  ContentView.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import SwiftUI

struct DetailView: View {
    let photo: FlickrItem
    
    var body: some View {
        ScrollView {
            VStack {
                let attributedString = NSAttributedString(html: photo.itemDescription) ?? NSAttributedString()
                AsyncImage(url: URL(string: photo.media.imageUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(4)
                } placeholder: {
                    ProgressView()
                }
                
                Text(photo.title).font(.headline)
                HTMLText(attributedString: attributedString)
                Text("Author: \(photo.author)")
                Text("Published: \(formattedDate(from: photo.published))")
                Text("Tags: \(photo.tags)")
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                            Text("Image Detail")
                                .font(.headline)
                        }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: shareContent) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
    private func shareContent() {
        guard let imageUrl = URL(string: photo.media.imageUrl),
              let imageData = try? Data(contentsOf: imageUrl),
              let image = UIImage(data: imageData) else { return }
        let attributedString = NSAttributedString(html: photo.itemDescription) ?? NSAttributedString()
        let items: [Any] = [image, attributedString.string]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // Presenting the share sheet
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.keyWindow?.rootViewController?.present(activityVC, animated: true)
        }
    }
    
    func formattedDate(from dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}


struct HTMLText: UIViewRepresentable {
    let attributedString: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 // Allows multi-line text
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
