//
//  ViewController.swift
//  Clima9-10
//
//  Created by Mac16 on 22/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    var climaManager = ClimaManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var imgFondo: UIImageView!
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //solicita el permiso del usuario
        locationManager.requestWhenInUseAuthorization()
        //solicita la ubicacion
        locationManager.requestLocation()
       
        
        climaManager.delegado = self
        buscarTextField.delegate = self
        
        
        
    }
    @IBAction func obtenerUbicacion(_ sender: UIButton) {
        //solicita la ubicacion
        locationManager.requestLocation()
    }
    
}

//MARK:- PROTOCOLO CLLocationManager
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Se obtuvo la ubicación")
        if let ubicaciones = locations.last{
            //detener la actualizacion de la ubicacion
            locationManager.stopUpdatingLocation()
            let latitud = ubicaciones.coordinate.latitude
            let longitud = ubicaciones.coordinate.longitude
            print("Latitud \(latitud) y Longitud \(longitud)")
            climaManager.fetchClima(lat: latitud, lon: longitud)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK:- METODOS PARA ACTUALIZAR LA INTERFAZ DE USUARIO
extension ViewController : ClimaManagerDelegate{
    func huboError(cualError: Error) {
        DispatchQueue.main.async {
            let alerta = UIAlertController(title: "Hubo un error", message: "Se produjo el error:\(cualError.localizedDescription)", preferredStyle: .alert)
            let aceptarAlert = UIAlertAction(title: "Aceptar", style: .default) { (UIAlertAction) in
                print("OK")
            }
            alerta.addAction(aceptarAlert)
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    
    func actualizarClima(clima: ClimaModelo) {
        print(clima.condicionID)
        
        
        //EJECUTAR CUANDO LA TAREA ASINCRONA TERMINE SU HILO DE EJECUCIÓN
        DispatchQueue.main.async {
            //ELEMENTOS GRÁFICOS SE MODIFICAN SOLO DESDE EL HILO PRINCIPAL
            self.temperaturaLabel.text = String(clima.temperaturaCelcius)
            self.ciudadLabel.text = "\(clima.nombre) "
            self.descripcionLabel.text = "\(clima.descripcionClima)"
            self.imgFondo.image = UIImage(named: clima.condicionClima)
            
            
            self.climaImageView.downloaded(from: "https://openweathermap.org/img/wn/\(clima.iconoID)@2x.png")
        }
    }
}

//MARK:-DELEGADOS DEL TEXT FIELD
extension ViewController : UITextFieldDelegate {
    //Programar el botón del teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(buscarTextField.text!)
        ciudadLabel.text = buscarTextField.text
        self.climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTextField.text != "" {
            return true
        } else {
            buscarTextField.placeholder = "Escribe una ciudad"
            return false
        }
    }
    
    @IBAction func buscarButton(_ sender: UIButton) {
        ciudadLabel.text = buscarTextField.text
        self.climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    
}

//MARK:MÉTODO PARA DESCARGAR UNA IMAGEN DESDE UNA URL Y ASIGNARLA AL IMAGE VIEW
//Fuente: https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

