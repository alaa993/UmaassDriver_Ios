//
//  ReferalModel.swift
//  SnabulProvider
//
//  Created by kavos khajavi on 10/22/20.
//  Copyright © 2020 Hesam. All rights reserved.
//

import Foundation
struct ReferalModel : Codable {
    let data : [ReferalData]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ReferalData].self, forKey: .data)
    }

}

struct ReferalData : Codable {
    let id : Int?
    let user : UserReferal?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user = try values.decodeIfPresent(UserReferal.self, forKey: .user)
    }

}

struct UserReferal : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let phone : String?
    let avatar : Avatar?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case phone = "phone"
        case avatar = "avatar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        avatar = try values.decodeIfPresent(Avatar.self, forKey: .avatar)
    }

}
