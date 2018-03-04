//
//  GraphDataPointObject.swift
//  TWNUITests
//
//  Created by Eugene Lu on 2018-01-19.
//  Copyright © 2018 Pelmorex Corp. All rights reserved.
//

import Foundation

///class that encapsulates PSSData, the 'value' variable needs to be an 'Int'
class PSSGraphDataPoint: Codable {
    
    var text: [String]?
    var value: Int?
}

extension PSSGraphDataPoint {
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case value = "Value"
    }
}
