//
//  ClimaModelo.swift
//  Clima9-10
//
//  Created by Mac16 on 24/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import Foundation

struct ClimaModelo {
    let condicionID : Int
    let nombre : String
    let descripcionClima : String
    let temperaturaCelcius : Double
    let iconoID : String
    
    //CREAR PROPIEDAD COMPUTADA
    var condicionClima : String{
        switch condicionID {
        case 200...232:
            return "cloud.bolt"
        case 700...781:
            return "algo"
        default:
            return "cloud"
        }
    }
    
    var temperaturaDecimal : String {
        return String(format: "%.1f", temperaturaCelcius)
    }
    
}
