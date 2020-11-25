//
//  ClimaManager.swift
//  Clima9-10
//
//  Created by Mac16 on 23/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import Foundation

struct ClimaManager {
    //Indica la URL de la API a consultar
    let climaUrl = "https://api.openweathermap.org/data/2.5/weather?appid=854dbcb1678d84705d908e60106a586a&units=metric&"
    
    func fetchClima(nombreCiudad:String) {
        let urlString = "\(climaUrl)&q=\(nombreCiudad)"
        print(urlString)
        
        realizarSolicitud(urlString:urlString)
    }
    
    func realizarSolicitud(urlString:String) {
        //1.- Crear URL
        if let url = URL(string:urlString){
            //2.- Crear la URL session
            let session = URLSession(configuration: .default)
            //3.- Asignar una tarea a la session
            //let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            let tarea = session.dataTask(with: url) { (data, request, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let datosSeguros = data {
                    //Decodificar el obj JSON
                    let dataString = String(data: datosSeguros, encoding: .utf8)
                    print(dataString!)
                }
            }
            //4.- Empezar la tarea
            tarea.resume()
        }
        
    }
    
}
