//
//  showIndustryModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation


struct ShowIndustryAvatar : Codable {
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

struct ShowIndustryCategory : Codable {
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


struct ShowIndustryGallery : Codable {
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

struct ShowIndustryImage : Codable {
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



struct ShowIndustryServices : Codable {
    let id : Int?
    let industry_id : Int?
    let title : String?
    let duration : Int?
    let price : Int?
    let notes_for_the_customer : String?
    let TypeTime : String?
    let TypePrice : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case industry_id = "industry_id"
        case title = "title"
        case duration = "duration"
        case price = "price"
        case notes_for_the_customer = "notes_for_the_customer"
        case TypeTime = "TypeTime"
        case TypePrice = "TypePrice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        industry_id = try values.decodeIfPresent(Int.self, forKey: .industry_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        notes_for_the_customer = try values.decodeIfPresent(String.self, forKey: .notes_for_the_customer
        )
        TypeTime = try values.decodeIfPresent(String.self, forKey: .TypeTime)
        TypePrice = try values.decodeIfPresent(String.self, forKey: .TypePrice)
    }
    
    init(id : Int?, industry_id : Int?, title : String?, duration : Int?, price : Int?, notes_for_the_customer : String?,TypeTime : String?,TypePrice : String?){
        self.id = id
        self.industry_id = industry_id
        self.title = title
        self.duration = duration
        self.price = price
        self.notes_for_the_customer = notes_for_the_customer
        self.TypeTime = TypeTime
        self.TypePrice = TypePrice
    }
    
}

struct ShowIndustryStaff : Codable {
    let id : Int?
    let industry_id : Int?
    let user_id : Int?
    let role : String?
    let name : String?
    let phone : String?
    let email : String?
    let avatar : ShowIndustryAvatar?
    let rate : Float?
    let permissions : [Int]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case industry_id = "industry_id"
        case user_id = "user_id"
        case role = "role"
        case name = "name"
        case phone = "phone"
        case email = "email"
        case avatar = "avatar"
        case rate = "rate"
        case permissions = "permissions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        industry_id = try values.decodeIfPresent(Int.self, forKey: .industry_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        avatar = try values.decodeIfPresent(ShowIndustryAvatar.self, forKey: .avatar)
        rate = try values.decodeIfPresent(Float.self, forKey: .rate)
        permissions = try values.decodeIfPresent([Int].self, forKey: .permissions)
    }
    
    init(id : Int?, industry_id : Int?, user_id : Int?, role : String?, name : String?, phone : String?, email : String?, avatar: ShowIndustryAvatar?, rate: Float?, permissions : [Int]?){
        self.id = id
        self.industry_id = industry_id
        self.user_id = user_id
        self.role = role
        self.name = name
        self.phone = phone
        self.email = email
        self.avatar = avatar
        self.rate = rate
        self.permissions = permissions
    }
}


struct ShowIndustryWorkingHours : Codable {
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



struct ShowIndustryData : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let phone : String?
    let address : String?
    let lat : String?
    let lng : String?
    let distance : String?
    let terms_and_condition : String?
    let tac_label : String?
    let is_favorited : Int?
    let image : ShowIndustryImage?
    let gallery : [ShowIndustryGallery]?
    let category : ShowIndustryCategory?
    let working_hours : [ShowIndustryWorkingHours]?
    let staff : [ShowIndustryStaff]?
    let services : [ShowIndustryServices]?
    let city:CityIndustryModel?
    
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
         case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        terms_and_condition = try values.decodeIfPresent(String.self, forKey: .terms_and_condition)
        tac_label = try values.decodeIfPresent(String.self, forKey: .tac_label)
        is_favorited = try values.decodeIfPresent(Int.self, forKey: .is_favorited)
        image = try values.decodeIfPresent(ShowIndustryImage.self, forKey: .image)
        gallery = try values.decodeIfPresent([ShowIndustryGallery].self, forKey: .gallery)
        category = try values.decodeIfPresent(ShowIndustryCategory.self, forKey: .category)
        working_hours = try values.decodeIfPresent([ShowIndustryWorkingHours].self, forKey: .working_hours)
        staff = try values.decodeIfPresent([ShowIndustryStaff].self, forKey: .staff)
        services = try values.decodeIfPresent([ShowIndustryServices].self, forKey: .services)
        city = try values.decodeIfPresent(CityIndustryModel.self, forKey: .city)
        
    }
}


struct showIndustryModel : Codable {
    let data : ShowIndustryData?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ShowIndustryData.self, forKey: .data)
    }
}


struct CityIndustryModel : Codable {
    
    let id : Int?
    let name : String?
    let country_id : Int?
    let country_name : String?

     enum CodingKeys: String, CodingKey {
         case id = "id"
         case name = "name"
         case country_id = "country_id"
         case country_name = "country_name"
     }
     init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         id = try values.decodeIfPresent(Int.self, forKey: .id)
         name = try values.decodeIfPresent(String.self, forKey: .name)
        country_id = try values.decodeIfPresent(Int.self, forKey: .country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
     }
}

