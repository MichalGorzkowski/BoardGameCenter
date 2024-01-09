//
//  LegoMinifigure.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import Foundation


struct LegoMinifigure: Codable {
    let id: String
    let title: String
    let numberOfPieces: Int
    let imageUrl: String
    let url: String
}
