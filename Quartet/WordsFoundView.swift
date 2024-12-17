//
//  WordsFoundView.swift
//  Quartet
//
//  Created by Francisco Serrano on 12/16/24.
//

import SwiftUI

struct WordsFoundView: View {
    var words: [[String]]
    
    var body: some View {
        let wordString = words.map { $0.joined() }
            .joined(separator: ", ")
        
        Text(wordString)
    }
}

#Preview {
    WordsFoundView(words: [["hel", "lo"], ["wor", "ld"]])
}
