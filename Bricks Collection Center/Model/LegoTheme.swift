//
//  LegoTheme.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import Foundation

struct LegoTheme: Codable {
    let id: Int
    let parentId: Int?
    let title: String
}
