//
//  UpdateApptDateModel.swift
//  UmaassProvider
//
//  Created by Hesam on 10/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//


import Foundation
struct newDateTime : Codable {
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

struct updateApptData : Codable {
    let status : String?
    let new_date_time : newDateTime?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case new_date_time = "new_date_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        new_date_time = try values.decodeIfPresent(newDateTime.self, forKey: .new_date_time)
    }
    
    
    init(status: String?, new_date_time : newDateTime?) {
        self.status = status
        self.new_date_time = new_date_time
    }
    
    
}

struct updateApptDateModel : Codable {
    let data : updateApptData?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(updateApptData.self, forKey: .data)
    }
    
}

