//
//  CreateStaffModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation


struct ManageStaffDataModel : Codable {
    let industry_id : Int?
    let phone : String?
    let name : String?
    //    let email : String?
    let role : String?
    let permissions : [Int]?
    
    enum CodingKeys: String, CodingKey {
        case industry_id = "industry_id"
        case phone = "phone"
        case name = "name"
        //        case email = "email"
        case role = "role"
        case permissions = "permissions"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        industry_id = try values.decodeIfPresent(Int.self, forKey: .industry_id)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        //        email = try values.decodeIfPresent(String.self, forKey: .email)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        permissions = try values.decodeIfPresent([Int].self, forKey: .permissions)
        
    }
    
    init(industry_id: Int?, phone : String?, name : String?, role : String?, permissions : [Int]?) {
        self.industry_id = industry_id
        self.phone = phone
        self.name = name
        //        self.email = email
        self.role = role
        self.permissions = permissions
        
    }
}
