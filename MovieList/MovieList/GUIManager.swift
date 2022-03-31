//
//  GUIManager.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

import UIKit

struct GUIManager {
    static func showAlert(title: String? = nil, message: String, presenter: UIViewController) {
        let alert = UIAlertController.init(title: title ?? "Alert!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
}
