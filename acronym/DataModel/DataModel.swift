//
//  DataModel.swift
//  acronym
//
//  Created by Choonghun Lee on 1/27/23.
//

import Foundation

struct SFData: Codable {
    let sf: String
    let lfs: [LFSData]
}

struct LFSData: Codable {
    let lf: String
    let freq: Int
    let since: Date
}
