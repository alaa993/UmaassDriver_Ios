
//
//  AllPreviewDataModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/13/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct AllApptsPreviewApplicant : Codable {
    let id : Int?
    let name : String?
    let phone : String?
    let description : String?
    let avatar : AllApptsPreviewAvatar?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case phone = "phone"
        case description = "description"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        avatar = try values.decodeIfPresent(AllApptsPreviewAvatar.self, forKey: .avatar)
    }
    
}

struct AllApptsPreviewAvatar : Codable {
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

struct AllApptsPreviewCategory : Codable {
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

struct AllApptsPreviewImage : Codable {
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


struct AllApptsPreviewImages : Codable {
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

struct imagesInTable {
    var row : Int?
    var images : [AllApptsPreviewImages]?
    
    init(row: Int, images: [AllApptsPreviewImages]) {
        self.row = row
        self.images = images
    }
}




struct AllApptsPreviewIndustry : Codable {
    let id : Int?
    let title : String?
    let phone : String?
    let address : String?
    let lat : String?
    let lng : String?
    let description : String?
    let image : AllApptsPreviewImage?
    let category : AllApptsPreviewCategory?
    
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
        image = try values.decodeIfPresent(AllApptsPreviewImage.self, forKey: .image)
        category = try values.decodeIfPresent(AllApptsPreviewCategory.self, forKey: .category)
    }
    
}

struct AllApptsPreviewService : Codable {
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

struct AllApptsPreviewStaff : Codable {
    let id : Int?
    let industry_id : Int?
    let user_id : Int?
    let role : String?
    let name : String?
    let avatar : AllApptsPreviewAvatar?
    
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
        avatar = try values.decodeIfPresent(AllApptsPreviewAvatar.self, forKey: .avatar)
    }
    
}


struct AllApptsPreviewMode : Codable {
    let data : [AllApptsPreviewData]?
    let links : AllApptsPreviewLinks?
    let meta : AllApptsPreviewMeta?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case links = "links"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AllApptsPreviewData].self, forKey: .data)
        links = try values.decodeIfPresent(AllApptsPreviewLinks.self, forKey: .links)
        meta = try values.decodeIfPresent(AllApptsPreviewMeta.self, forKey: .meta)
    }
    
}




struct AllApptsPreviewData : Codable {
    let id : Int?
    let client_name : String?
    let client_phone : String?
    let client_age : Int?
    let client_gender : Int?
    let start_time : String?
    let end_time : String?
    let description : String?
    let prescription : String?
    let from_to : String?
    let book_id : String?
    let status : String?
    let applicant : AllApptsPreviewApplicant?
    let service : AllApptsPreviewService?
    let staff : AllApptsPreviewStaff?
    let industry : AllApptsPreviewIndustry?
    let images : [AllApptsPreviewImages]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case client_name = "client_name"
        case client_phone = "client_phone"
        case client_age = "client_age"
        case client_gender = "client_gender"
        case start_time = "start_time"
        case end_time = "end_time"
        case description = "description"
        case prescription = "prescription"
        case from_to = "from_to"
        case book_id = "book_id"
        case status = "status"
        case applicant = "applicant"
        case service = "service"
        case staff = "staff"
        case industry = "industry"
        case images = "images"
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
        prescription = try values.decodeIfPresent(String.self, forKey: .prescription)
        from_to = try values.decodeIfPresent(String.self, forKey: .from_to)
        book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        applicant = try values.decodeIfPresent(AllApptsPreviewApplicant.self, forKey: .applicant)
        service = try values.decodeIfPresent(AllApptsPreviewService.self, forKey: .service)
        staff = try values.decodeIfPresent(AllApptsPreviewStaff.self, forKey: .staff)
        industry = try values.decodeIfPresent(AllApptsPreviewIndustry.self, forKey: .industry)
        images = try values.decodeIfPresent([AllApptsPreviewImages].self, forKey: .images)
    }
    
}


struct AllApptsPreviewLinks : Codable {
    let first : String?
    let last : String?
    let prev : String?
    let next : String?
    
    enum CodingKeys: String, CodingKey {
        
        case first = "first"
        case last = "last"
        case prev = "prev"
        case next = "next"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        first = try values.decodeIfPresent(String.self, forKey: .first)
        last = try values.decodeIfPresent(String.self, forKey: .last)
        prev = try values.decodeIfPresent(String.self, forKey: .prev)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }
    
}

struct AllApptsPreviewMeta : Codable {
    let current_page : Int?
    let from : Int?
    let last_page : Int?
    let path : String?
    let per_page : Int?
    let to : Int?
    let total : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case current_page = "current_page"
        case from = "from"
        case last_page = "last_page"
        case path = "path"
        case per_page = "per_page"
        case to = "to"
        case total = "total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        last_page = try values.decodeIfPresent(Int.self, forKey: .last_page)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
    
}
