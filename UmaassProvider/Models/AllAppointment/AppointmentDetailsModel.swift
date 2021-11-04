//
//  AppointmentDetailsModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation


struct ApptDetailsAvatar : Codable {
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

struct ApptDetailsCategory : Codable {
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

struct ApptDetailsImage : Codable {
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

struct ApptDetailsImages : Codable {
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



struct ApptDetailsApplicant : Codable {
    let id : Int?
    let name : String?
    let phone : String?
    let avatar : ApptDetailsAvatar?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case phone = "phone"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        avatar = try values.decodeIfPresent(ApptDetailsAvatar.self, forKey: .avatar)
    }
    
}

struct ApptDetailsService : Codable {
    let id : Int?
    let industry_id : Int?
    let title : String?
    let duration : Int?
    let price : Int?
    let notes_for_the_customer : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case industry_id = "industry_id"
        case title = "title"
        case duration = "duration"
        case price = "price"
        case notes_for_the_customer = "notes_for_the_customer"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        industry_id = try values.decodeIfPresent(Int.self, forKey: .industry_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        notes_for_the_customer = try values.decodeIfPresent(String.self, forKey: .notes_for_the_customer)
    }
    
}

struct ApptDetailsStaff : Codable {
    let id : Int?
    let industry_id : Int?
    let user_id : Int?
    let role : String?
    let name : String?
    let avatar : ApptDetailsAvatar?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case industry_id = "industry_id"
        case user_id = "user_id"
        case role = "role"
        case name = "name"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        industry_id = try values.decodeIfPresent(Int.self, forKey: .industry_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(ApptDetailsAvatar.self, forKey: .avatar)
    }
    
}


struct ApptDetailsIndustry : Codable {
    let id : Int?
    let title : String?
    let phone : String?
    let address : String?
    let lat : String?
    let lng : String?
    let description : String?
    let image : ApptDetailsImage?
    let category : ApptDetailsCategory?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case phone = "phone"
        case address = "address"
        case lat = "lat"
        case lng = "lng"
        case description = "description"
        case image = "image"
        case category = "category"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(ApptDetailsImage.self, forKey: .image)
        category = try values.decodeIfPresent(ApptDetailsCategory.self, forKey: .category)
    }
    
}


struct ApptDetailsData : Codable {
    let id : Int?
    let client_name : String?
    let client_phone : String?
    let client_age : Int?
    let client_gender : Int?
    let start_time : String?
    let end_time : String?
    let description : String?
    let from_to : String?
    let book_id : String?
    let status : String?
    let applicant : ApptDetailsApplicant?
    let service : ApptDetailsService?
    let staff : ApptDetailsStaff?
    let industry : ApptDetailsIndustry?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case client_name = "client_name"
        case client_phone = "client_phone"
        case client_age = "client_age"
        case client_gender = "client_gender"
        case start_time = "start_time"
        case end_time = "end_time"
        case description = "description"
        case from_to = "from_to"
        case book_id = "book_id"
        case status = "status"
        case applicant = "applicant"
        case service = "service"
        case staff = "staff"
        case industry = "industry"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        client_name = try values.decodeIfPresent(String.self, forKey: .client_name)
        client_phone = try values.decodeIfPresent(String.self, forKey: .client_phone)
        client_age = try values.decodeIfPresent(Int.self, forKey: .client_age)
        client_gender = try values.decodeIfPresent(Int.self, forKey: .client_gender)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        from_to = try values.decodeIfPresent(String.self, forKey: .from_to)
        book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        applicant = try values.decodeIfPresent(ApptDetailsApplicant.self, forKey: .applicant)
        service = try values.decodeIfPresent(ApptDetailsService.self, forKey: .service)
        staff = try values.decodeIfPresent(ApptDetailsStaff.self, forKey: .staff)
        industry = try values.decodeIfPresent(ApptDetailsIndustry.self, forKey: .industry)
    }
    
}


struct ApptDetailsModel : Codable {
    let data : ApptDetailsData?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ApptDetailsData.self, forKey: .data)
    }
    
}
