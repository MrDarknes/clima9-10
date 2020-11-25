//
//  ClimaData.swift
//  Clima9-10
//
//  Created by Mac16 on 24/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import Foundation
        
struct ClimaData : Decodable, Encodable{
    let name : String
    let cod : Int
    let main : Main
    let weather : [Weather]
    let coord : Cord
    
}

struct Main : Codable {
    let temp : Double
    let humidity : Int
    
}

struct Weather : Codable {
    let description : String
    let id : Int
    let icon : String
}

struct Cord : Codable {
    let lat : Double
    let lon : Double
}
