//
//  Extensions.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import UIKit

extension NSAttributedString {
    
    convenience init?(html: String, font: UIFont? = nil) {
        guard let data = html.data(using: .utf8) else { return nil }
        
        do {
            var options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            if let font = font {
                let cssString = """
                <style>
                body {
                    font-family: '\(font.familyName)';
                    font-size: \(font.pointSize)px;
                }
                </style>
                """
                let styledHTML = cssString + html
                options[.characterEncoding] = String.Encoding.utf8.rawValue
                guard let styledData = styledHTML.data(using: .utf8) else { return nil }
                try self.init(data: styledData, options: options, documentAttributes: nil)
                return
            }

            try self.init(data: data, options: options, documentAttributes: nil)
        } catch {
            print("Error creating attributed string from HTML: \(error)")
            return nil
        }
    }
}
