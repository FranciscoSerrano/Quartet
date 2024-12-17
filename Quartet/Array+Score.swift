//
//  Array+Score.swift
//  Quartet
//
//  Created by Francisco Serrano on 12/16/24.
//

import Foundation

extension Array {
    var score: Int {
        Int(pow(2, Double(count - 1)))
    }
}
