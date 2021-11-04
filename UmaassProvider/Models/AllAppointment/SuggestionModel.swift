//
//  SuggestionModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct SuggestionData : Codable {
    let start : String?
    let end : String?
    
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case end = "end"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        start = try values.decodeIfPresent(String.self, forKey: .start)
        end = try values.decodeIfPresent(String.self, forKey: .end)
    }
    
}



struct SuggestionModel : Codable {
    let data : [SuggestionData]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SuggestionData].self, forKey: .data)
    }
    
}







struct newDateData : Codable {
    let start : String?
    let end : String?
    
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case end = "end"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        start = try values.decodeIfPresent(String.self, forKey: .start)
        end = try values.decodeIfPresent(String.self, forKey: .end)
    }
    
    init(start: String?, end : String?) {
        self.start = start
        self.end = end
    }
}



struct newDateModel : Codable {
    var status  = String()
    var newDate : [newDateData]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case newDate = "newDate"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)!
        newDate = try values.decodeIfPresent([newDateData].self, forKey: .newDate)
    }
    init(status: String?, newDate : [newDateData]?) {
        self.status = status!
        self.newDate = newDate
    }
}
