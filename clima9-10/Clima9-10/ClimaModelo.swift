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
            return "cielo con tormenta"
        case 300...321:
            return "lluvioso"
        case 500...531:
            return "lluvia"
        case 600...622:
            return "nieve"
        case 701...781:
            return "mist"
        case 800...803:
            return "Cielo Nublado"
        default:
            return "cielo despejado"
        }
    }
    
    var temperaturaDecimal : String {
        return String(format: "%.1f", temperaturaCelcius)
    }
    
}
