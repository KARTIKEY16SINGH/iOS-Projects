//
//  ViewController.swift
//  LocusAssignment
//
//  Created by Iron Man on 11/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UnderlinedTextField!
    @IBOutlet weak var lookupButton: UIButton!
    private var _weatherApiRepository: WeatherApiRepository!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _weatherApiRepository = WeatherApiRepository()
    }


    @IBAction func lookupButtonClicked(_ sender: Any) {
        _weatherApiRepository.fetch(cityTextField.text ?? "") { response in
            dump(response)
        }
    }
}

