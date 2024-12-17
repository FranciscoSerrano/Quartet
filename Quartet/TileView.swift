//
//  TileView.swift
//  Quartet
//
//  Created by Francisco Serrano on 12/16/24.
//

import SwiftUI

struct TileView: View {
    var text: String
  
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 64)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.25))
                    .offset(y: 4)
            )
    }
}

#Preview {
    TileView(text: "abc")
}
