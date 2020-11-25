//
//  ClimaData.swift
//  Clima9-10
//
//  Created by Mac16 on 24/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import Foundation
        
struct ClimaData : Decodable{
    let name : String
    let cod : Int
    let main : Main
    let weather : [Weather]
    let coord : Cord
    
}

struct Main : Decodable {
    let temp : Double
    let humidity : Int
    
}

struct Weather : Decodable {
    let description : String
}

struct Cord : Decodable {
    let lat : Double
    let lon : Double
}
