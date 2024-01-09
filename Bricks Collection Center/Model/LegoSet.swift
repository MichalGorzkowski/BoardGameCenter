//
//  LegoSet.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import Foundation

struct LegoSet: Identifiable, Decodable {
    let id = UUID()
    let setNum: String
    let name: String
    let year: Int
    let themeId: Int
    let numParts: Int
    let setImgURL: URL?
    let setURL: URL
    let lastModifiedDt: String
    
    enum CodingKeys: String, CodingKey {
        case setNum = "set_num"
        case name
        case year
        case themeId = "theme_id"
        case numParts = "num_parts"
        case setImgURL = "set_img_url"
        case setURL = "set_url"
        case lastModifiedDt = "last_modified_dt"
    }
}

struct LegoSetList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [LegoSet]
}
