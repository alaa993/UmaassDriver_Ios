//
//  Result.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

import Foundation
enum Result<T>{
    case success(T?,Int?)
    case failure(Error?,Int?,String?)
}
