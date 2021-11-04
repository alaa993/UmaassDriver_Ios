//
//  ProfileModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation
struct AvatarModel : Codable {
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

struct LastDoneAppt : Codable {
    let id : Int?
    let user_commenting_status : String?
    let staff : profileStaff?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_commenting_status = "user_commenting_status"
        case staff = "staff"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_commenting_status = try values.decodeIfPresent(String.self, forKey: .user_commenting_status)
        staff = try values.decodeIfPresent(profileStaff.self, forKey: .staff)
    }
    
}

struct profileStaff : Codable {
    let id : Int?
    let name : String?
    let category_name : String?
    let avatar : AvatarModel?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case category_name = "category_name"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        avatar = try values.decodeIfPresent(AvatarModel.self, forKey: .avatar)
    }
    
}



import Foundation
struct profileData : Codable {
    let id : Int?
    let birthdate : String?
    let gender : Int?
    let age : Int?
    let avatar : AvatarModel?
    let email : String?
    let last_done_appt : LastDoneAppt?
    let name : String?
    let phone : String?
    let description : String?
    let introduce_code :String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case birthdate = "birthdate"
        case gender = "gender"
        case age = "age"
        case avatar = "avatar"
        case email = "email"
        case last_done_appt = "last_done_appt"
        case name = "name"
        case phone = "phone"
        case description = "description"
        case introduce_code = "introduce_code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        birthdate = try values.decodeIfPresent(String.self, forKey: .birthdate)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        avatar = try values.decodeIfPresent(AvatarModel.self, forKey: .avatar)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        last_done_appt = try values.decodeIfPresent(LastDoneAppt.self, forKey: .last_done_appt)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        introduce_code = try values.decodeIfPresent(String.self, forKey: .introduce_code)
    }
}


import Foundation
struct profileModell : Codable {
    let data : profileData?
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(profileData.self, forKey: .data)
    }
    
}
