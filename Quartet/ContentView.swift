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
    @State private var selectedTiles = [String]()
    
    let gridLayout = Array(repeating: GridItem.init(.flexible(minimum: 50, maximum: 100)), count: 4)
    
    var body: some View {
        VStack {
            HStack {
                if selectedTiles.isEmpty {
                    SelectedTileView(text: "aa")
                        .hidden()
                } else {
                    ForEach(selectedTiles, id: \.self) { tile in
                        Button {
                            deselect(tile)
                        } label: {
                            SelectedTileView(text: tile)
                        }
                    }
                    
                    Button("Clear", systemImage: "xmark.circle", action: clearSelected)
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                }
            }
            
            LazyVGrid(columns: gridLayout) {
                ForEach(tiles, id: \.self) { tile in
                    Button {
                        select(tile)
                    } label: {
                        TileView(text: tile)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            HStack {
                Button(action: shuffleTiles) {
                    Label("Shuffle", systemImage: "shuffle")
                        .padding(5)
                        .font(.headline)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                
                Spacer()
                
                Button(action: submit) {
                    Label("Submit", systemImage: "checkmark")
                        .padding(10)
                        .font(.title)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                
                Spacer()
                
                Button(action: toggleGrouping) {
                    Label("Submit", systemImage: "list.star")
                        .padding(5)
                        .font(.title)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
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
    
    func clearSelected() {
        selectedTiles.removeAll()
    }
    
    func select(_ tile: String) {
        guard selectedTiles.count < 4 else { return }
        guard selectedTiles.contains(tile) == false else { return }
        self.selectedTiles.append(tile)
    }
    
    func deselect(_ tile: String) {
        selectedTiles.removeAll { $0 == tile }
    }
    
    func shuffleTiles() {
        
    }
    
    func submit() {
        
    }
    
    func toggleGrouping() {
        
    }
}

#Preview {
    ContentView()
}
