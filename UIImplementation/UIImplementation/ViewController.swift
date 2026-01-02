//
//  ViewController.swift
//  UIImplementation
//
//  Created by Iron Man on 02/01/26.
//

import UIKit

class ViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        layoutTableView()
    }
    
    private func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewControllerDataSource.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") ?? .init(style: .default, reuseIdentifier: "tableViewCell")
        cell.textLabel?.text = ViewControllerDataSource.dataSource[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerDataSource.dataSource[indexPath.row].controller.init()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

struct RowData {
    var title: String
    var controller: UIViewController.Type
}

enum ViewControllerDataSource {
    static let dataSource: [RowData] = [
        .init(title: "Dynamic Height Cells", controller: DynamicHeightCellsViewController.self),
        .init(title: "Fixed Height Dynamic Content Cell", controller: FixedHeightCellsViewController.self)
    ]
}
