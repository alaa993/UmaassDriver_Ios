//
//  WorkingHoursModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct createIndustryyy : Codable {
    let working_hours : [WorkingHoursss]?
    let address : String?
    let description : String?
    let title : String?
    let category_id : Int?
    let city_id : Int?
    let phone : String?
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        case working_hours = "working_hours"
        case address = "address"
        case description = "description"
        case title = "title"
        case category_id = "category_id"
        case city_id = "city_id"
        case phone = "phone"
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        working_hours = try values.decodeIfPresent([WorkingHoursss].self, forKey: .working_hours)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        city_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
    
    init(working_hours : [WorkingHoursss]?, address : String?, description : String?, title : String?, category_id : Int?, city_id : Int?, phone : String?, lat : Double?, lng : Double?) {
        self.working_hours = working_hours
        self.address = address
        self.description = description
        self.title = title
        self.category_id = category_id
        self.city_id = city_id
        self.phone = phone
        self.lat = lat
        self.lng = lng
    }
}


struct WorkingHoursss : Codable {
    let day : Int?
    let time : [String]?
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Int.self, forKey: .day)
        time = try values.decodeIfPresent([String].self, forKey: .time)
    }
    
    init(day: Int?, time : [String]?) {
        self.day = day
        self.time = time
    }
}




struct updateLocationModel : Codable {
    let lat : Double?
    let lng : Double?
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
    init(lat : Double?, lng : Double?) {
        self.lat = lat
        self.lng = lng
    }
}
