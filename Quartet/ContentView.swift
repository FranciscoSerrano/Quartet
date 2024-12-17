//
//  ContentView.swift
//  Quartet
//
//  Created by Francisco Serrano on 12/16/24.
//

import SwiftUI

struct ContentView: View {
    let levels: [[String]] = Bundle.main.decode("levels.txt")
    
    @State private var tiles = [String]()
    
    let gridLayout = Array(repeating: GridItem.init(.flexible(minimum: 50, maximum: 100)), count: 4)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridLayout) {
                ForEach(tiles, id: \.self) { tile in
                    Button {
                        // select this tile
                    } label: {
                        TileView(text: tile)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .background(.quinary)
        .fontDesign(.rounded)
        .font(.title2.bold())
        .preferredColorScheme(.light)
        .task {
            loadLevel()
        }
    }
    
    func loadLevel() {
        tiles = levels[0].shuffled()
    }
}

#Preview {
    ContentView()
}
