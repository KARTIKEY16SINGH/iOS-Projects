//
//  HostViewController.swift
//  GoMmt
//
//  Created by Iron Man on 10/04/21.
//

import UIKit

class HostViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "RequestTableViewCell", bundle: Bundle(for: HostViewController.self)), forCellReuseIdentifier: "requestCell")
//        navigationController?.navigationBar.back
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Request"
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

extension HostViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath)
    }
}

extension HostViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigationItem.title = ""
        navigationController?.pushViewController(UIStoryboard(name: "BookingRequestStoryboard", bundle: Bundle(for: HostViewController.self)).instantiateInitialViewController() ?? BookingRequestViewController(), animated: true)
    }
}
