//
//  RulesDataModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct rulseAboutModel : Codable {
    let rulesdata : String?
    
    enum CodingKeys: String, CodingKey {
        case rulesdata = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rulesdata = try values.decodeIfPresent(String.self, forKey: .rulesdata)
    }
    
}
