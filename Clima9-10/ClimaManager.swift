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
    let climaUrl = "https://api.openweathermap.org/data/2.5/weather?appid=854dbcb1678d84705d908e60106a586a&units=metric&lang=es&"
    
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
                    self.parseJSON(climaData: datosSeguros)
                }
            }
            //4.- Empezar la tarea
            tarea.resume()
        }
        
        
        
    }
    
    func parseJSON(climaData: Data){
        let decoder = JSONDecoder()
        do{
            let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            print(dataDecodificada.name)
            print(dataDecodificada.cod)
            print(dataDecodificada.main.humidity)
            print(dataDecodificada.main.temp)
            print(dataDecodificada.weather[0].description)
            print(dataDecodificada.coord.lat)
            print(dataDecodificada.coord.lon)
        } catch {
            print(error)
        }
        
    }
    
}
