//
//  CreateIndustryModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation


import Foundation
struct CreateIndustriesData : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let phone : String?
    let address : String?
    let lat : Int?
    let lng : Int?
    let distance : String?
    let terms_and_condition : String?
    let tac_label : String?
    let is_favorited : Int?
    let image : String?
    let gallery : [String]?
    let category : IndustriesCategory?
    let working_hours : [IndustriesWorkingHours]?
    let staff : [String]?
    let services : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case description = "description"
        case phone = "phone"
        case address = "address"
        case lat = "lat"
        case lng = "lng"
        case distance = "distance"
        case terms_and_condition = "terms_and_condition"
        case tac_label = "tac_label"
        case is_favorited = "is_favorited"
        case image = "image"
        case gallery = "gallery"
        case category = "category"
        case working_hours = "working_hours"
        case staff = "staff"
        case services = "services"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(Int.self, forKey: .lat)
        lng = try values.decodeIfPresent(Int.self, forKey: .lng)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        terms_and_condition = try values.decodeIfPresent(String.self, forKey: .terms_and_condition)
        tac_label = try values.decodeIfPresent(String.self, forKey: .tac_label)
        is_favorited = try values.decodeIfPresent(Int.self, forKey: .is_favorited)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        gallery = try values.decodeIfPresent([String].self, forKey: .gallery)
        category = try values.decodeIfPresent(IndustriesCategory.self, forKey: .category)
        working_hours = try values.decodeIfPresent([IndustriesWorkingHours].self, forKey: .working_hours)
        staff = try values.decodeIfPresent([String].self, forKey: .staff)
        services = try values.decodeIfPresent([String].self, forKey: .services)
    }
    
}


import Foundation
struct IndustriesCategory : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

import Foundation
struct IndustriesWorkingHours : Codable {
    let day : Int?
    let start : String?
    let end : String?
    
    enum CodingKeys: String, CodingKey {
        
        case day = "day"
        case start = "start"
        case end = "end"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Int.self, forKey: .day)
        start = try values.decodeIfPresent(String.self, forKey: .start)
        end = try values.decodeIfPresent(String.self, forKey: .end)
    }
    
}

import Foundation
struct CreateIndustriesModel : Codable {
    let data : [CreateIndustriesData]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CreateIndustriesData].self, forKey: .data)
    }
}

