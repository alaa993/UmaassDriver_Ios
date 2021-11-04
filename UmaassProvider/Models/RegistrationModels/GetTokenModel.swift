//
//  GetTokenModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct modelToken : Codable {
    let error   : Int?
    let msg     : String?
    let token   : String?
    
    enum CodingKeys: String, CodingKey {
        
        case error   = "error"
        case msg     = "msg"
        case token   = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
    
}

struct LoginModel : Codable {
    let errors : [String]?
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        case errors = "errors"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errors = try values.decodeIfPresent([String].self, forKey: .errors)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
}

