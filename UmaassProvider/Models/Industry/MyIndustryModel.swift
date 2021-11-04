//
//  MyIndustryModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation


struct MyIndustryImage : Codable {
    let id : Int?
    let url_lg : String?
    let url_md : String?
    let url_sm : String?
    let url_xs : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case url_lg = "url_lg"
        case url_md = "url_md"
        case url_sm = "url_sm"
        case url_xs = "url_xs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        url_lg = try values.decodeIfPresent(String.self, forKey: .url_lg)
        url_md = try values.decodeIfPresent(String.self, forKey: .url_md)
        url_sm = try values.decodeIfPresent(String.self, forKey: .url_sm)
        url_xs = try values.decodeIfPresent(String.self, forKey: .url_xs)
    }
    
}



struct MyIndustryLinks : Codable {
    let last : String?
    let next : String?
    let prev : String?
    let first : String?
    
    enum CodingKeys: String, CodingKey {
        
        case last = "last"
        case next = "next"
        case prev = "prev"
        case first = "first"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        last = try values.decodeIfPresent(String.self, forKey: .last)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        prev = try values.decodeIfPresent(String.self, forKey: .prev)
        first = try values.decodeIfPresent(String.self, forKey: .first)
    }
    
}

struct MyIndustryMeta : Codable {
    let current_page : Int?
    let last_page : Int?
    let to : Int?
    let from : Int?
    let path : String?
    let per_page : Int?
    let total : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case current_page = "current_page"
        case last_page = "last_page"
        case to = "to"
        case from = "from"
        case path = "path"
        case per_page = "per_page"
        case total = "total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        last_page = try values.decodeIfPresent(Int.self, forKey: .last_page)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
    
}

struct MyIndustryData : Codable {
    let distance : String?
    let terms_and_condition : String?
    let lng : String?
    let id : Int?
    let description : String?
    let service_avg_time : Int?
    let service_label : String?
    let address : String?
    let image : MyIndustryImage?
    let phone : String?
    let lat : String?
    let visits : Int?
    let title : String?
    let is_active : Int?
    let tac_label : String?
    let is_favorited : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case distance = "distance"
        case terms_and_condition = "terms_and_condition"
        case lng = "lng"
        case id = "id"
        case description = "description"
        case service_avg_time = "service_avg_time"
        case service_label = "service_label"
        case address = "address"
        case image = "image"
        case phone = "phone"
        case lat = "lat"
        case visits = "visits"
        case title = "title"
        case is_active = "is_active"
        case tac_label = "tac_label"
        case is_favorited = "is_favorited"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        terms_and_condition = try values.decodeIfPresent(String.self, forKey: .terms_and_condition)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        service_avg_time = try values.decodeIfPresent(Int.self, forKey: .service_avg_time)
        service_label = try values.decodeIfPresent(String.self, forKey: .service_label)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        image = try values.decodeIfPresent(MyIndustryImage.self, forKey: .image)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        visits = try values.decodeIfPresent(Int.self, forKey: .visits)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        is_active = try values.decodeIfPresent(Int.self, forKey: .is_active)
        tac_label = try values.decodeIfPresent(String.self, forKey: .tac_label)
        is_favorited = try values.decodeIfPresent(Int.self, forKey: .is_favorited)
    }
    
}

struct MyIndustryModel : Codable {
    let links : MyIndustryLinks?
    let meta  : MyIndustryMeta?
    let data  : [MyIndustryData]?
    
    enum CodingKeys: String, CodingKey {
        
        case links = "links"
        case meta = "meta"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        links = try values.decodeIfPresent(MyIndustryLinks.self, forKey: .links)
        meta = try values.decodeIfPresent(MyIndustryMeta.self, forKey: .meta)
        data = try values.decodeIfPresent([MyIndustryData].self, forKey: .data)
    }
    
}
