//
//  ViewController.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 05/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var srcTextField: UITextField!
    @IBOutlet weak var dstTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startBtn: UIButton!
    private var locationList: [String] = []
    private var controller: MainScreenController!
    private var lastSelectedTextField = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = MainScreenController(self)
        srcTextField.delegate = self
        dstTextField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
    }


    @IBAction func startBtnTapped(_ sender: Any) {
        controller.searchForRide()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        controller.searchLocation(textField.text)
        lastSelectedTextField = textField.tag
        view.endEditing(true)
        return true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text = locationList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationList.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.setLocation(at: indexPath.row, for: lastSelectedTextField)
        tableView.deselectRow(at: indexPath, animated: true)
        let txtFld = lastSelectedTextField == 0 ? srcTextField : dstTextField
        txtFld?.text = locationList[indexPath.row]
    }
}

extension ViewController: LocationSearchProtocol {
    func updateLocationList(_ list: [String]) {
        locationList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
