//
//  ItemDetailViewController.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

import UIKit

class ItemDetailViewController: UIViewController {
    private var itemInfoView: ItemInfoView = {
        let view = ItemInfoView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(itemInfoView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            itemInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
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
