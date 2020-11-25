//
//  ViewController.swift
//  Clima9-10
//
//  Created by Mac16 on 22/11/20.
//  Copyright © 2020 Mac16. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let climaManager = ClimaManager()
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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

