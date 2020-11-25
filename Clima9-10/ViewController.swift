//
//  ViewController.swift
//  Clima9-10
//
//  Created by Mac16 on 22/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    
    func actualizarClima(clima: ClimaModelo) {
        print(clima.descripcionClima)
        print(clima.temperaturaCelcius)
        
        //EJECUTAR CUANDO LA TAREA ASINCRONA TERMINE SU HILO DE EJECUCIÓN
        DispatchQueue.main.async {
            //ELEMENTOS GRÁFICOS SE MODIFICAN SOLO DESDE EL HILO PRINCIPAL
            self.temperaturaLabel.text = String(clima.temperaturaCelcius)
            self.ciudadLabel.text = "\(clima.nombre) \(clima.descripcionClima)"
            print(clima.descripcionClima)
            
            self.climaImageView.downloaded(from: "https://openweathermap.org/img/wn/\(clima.iconoID)@2x.png")
        }
    }
    

    var climaManager = ClimaManager()
    
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        climaManager.delegado = self
        
        buscarTextField.delegate = self
    }

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
//AGREGANDO MÉTODO PARA DESCARGAR UNA IMAGEN DESDE UNA URL Y ASIGNARLA AL IMAGE VIEW
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

