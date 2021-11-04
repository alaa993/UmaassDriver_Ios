//
//  loginModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct loginParam : Codable {
    let access_token   : String?
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
    }
    
    init(access_token : String?) {
        self.access_token = access_token
    }
}
