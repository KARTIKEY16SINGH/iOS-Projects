//
//  AddTaskViewController.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import UIKit

protocol AddTaskViewable: UIViewController {
    var addButtonCallback: ((String?, String?) -> Void)? {get set}
}

final class AddTaskViewController: UIViewController {
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        return textField
    }()
    
    private var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
    }
    
    private var tapGesture: UITapGestureRecognizer?
    
    private func setUpViews() {
        containerView.addArrangedSubview(titleTextField)
        containerView.addArrangedSubview(descriptionTextField)
        containerView.addArrangedSubview(addButton)
        view.addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedButton))
        addButton.addGestureRecognizer(tapGesture)
        
        layoutViews()
    }
    
    var addButtonCallback: ((String?, String?) -> Void)?
    
    @objc
    private func tappedButton() {
        addButtonCallback?(titleTextField.text, descriptionTextField.text)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
//            titleTextField.heightAnchor.constraint(equalToConstant: 40),
//            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
//            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension AddTaskViewController: AddTaskViewable {}
