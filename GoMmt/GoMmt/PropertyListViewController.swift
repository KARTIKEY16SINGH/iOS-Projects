//
//  PropertyListViewController.swift
//  GoMmt
//
//  Created by Iron Man on 11/04/21.
//

import UIKit

class PropertyListViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "PropertyTableViewCell", bundle: Bundle(for: HostViewController.self)), forCellReuseIdentifier: "propertyCell")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PropertyListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
    }
}

extension PropertyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (UIScreen.main.bounds.width * 250.0)/518.0
    }
}
