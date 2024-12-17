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
    @State private var orderedTiles = [String]()
    @State private var selectedTiles = [String]()
    
    @State private var foundWords = [[String]]()
    @State private var foundQuartiles = [String]()
    @State private var isGroupingQuartiles = true
    
    @State private var score = 0
    
    let gridLayout = Array(repeating: GridItem.init(.flexible(minimum: 50, maximum: 100)), count: 4)
    
    let dictionary: Set<String> = {
        guard let url = Bundle.main.url(forResource: "dictionary", withExtension: "txt") else { fatalError("Couldn't locate dictionary.") }
        guard let contents = try? String(contentsOf: url, encoding: .utf8) else { fatalError("Couldn't load dictionary.") }
        
        return Set(contents.components(separatedBy: .newlines))
    }()
    
    var canSubmit: Bool {
        let selectedWord = selectedTiles.joined()
        
        guard selectedTiles.isEmpty == false else { return false }
        guard dictionary.contains(selectedWord) else { return false }
        
        return !foundWords.contains(selectedTiles)
    }
    
    var body: some View {
        VStack {
            WordsFoundView(words: foundWords)
            
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
                ForEach(orderedTiles, id: \.self) { tile in
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
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .disabled(canSubmit == false)
                
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
        orderedTiles = tiles
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
        withAnimation {
            tiles.shuffle()
            orderedTiles = tiles
            groupQuartiles()
        }
    }
    
    func submit() {
        foundWords.append(selectedTiles)
        score += selectedTiles.score
        
        if selectedTiles.count == 4 {
            foundQuartiles.append(contentsOf: selectedTiles)
        }
        
        selectedTiles.removeAll()
        groupQuartiles()
    }
    
    func toggleGrouping() {
        withAnimation {
            isGroupingQuartiles.toggle()
            
            if isGroupingQuartiles {
                groupQuartiles()
            } else {
                orderedTiles = tiles
            }
        }
    }
    
    func groupQuartiles() {
        guard isGroupingQuartiles else { return }
        
        for quartile in foundQuartiles {
            orderedTiles.removeAll(where: quartile.contains)
            orderedTiles.append(quartile)
        }
    }
}

#Preview {
    ContentView()
}
