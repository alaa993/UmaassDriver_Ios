//
//  CreateServiceModel.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

struct ManageServiceDataModel : Codable {
    let industry_id : Int?
    let title : String?
    let duration : Int?
    let price : Int?
    let notes_for_the_customer : String?
    let TypeTime : String?
    let TypePrice : String?
    
    
    enum CodingKeys: String, CodingKey {
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
        industry_id = try values.decodeIfPresent(Int.self, forKey: .industry_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        notes_for_the_customer = try values.decodeIfPresent(String.self, forKey: .notes_for_the_customer)
        TypeTime = try values.decodeIfPresent(String.self, forKey: .TypeTime)
        TypePrice = try values.decodeIfPresent(String.self, forKey: .TypePrice)
    }
    
    init(industry_id : Int?, title : String?, duration : Int?, price : Int?, notes_for_the_customer : String?,TypeTime : String?,TypePrice : String?) {
        self.industry_id = industry_id
        self.title = title
        self.duration = duration
        self.price = price
        self.notes_for_the_customer = notes_for_the_customer
        self.TypeTime = TypeTime
        self.TypePrice = TypePrice
    }
}
