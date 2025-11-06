//
//  UserDetailsViewController.swift
//  GithubSearch
//
//  Created by Iron Man on 06/11/25.
//

import UIKit


protocol UserDetailsViewable {
    func updateView(with model: UserDetailsModel)
    func setAvatar(with stringUrl: String)
}

final class UserDetailsViewController: UIViewController {
    @IBOutlet weak var nameValueLabel: UILabel?
    @IBOutlet weak var bioValueLabel: UILabel?
    @IBOutlet weak var followersValueLabel: UILabel?
    @IBOutlet weak var loginValueLabel: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    
    private weak var viewModel: UserDetailsViewModelable?
    
    func build(with: UserDetailsModel) {
        let viewModel = UserDetailsViewModel()
        viewModel
    }
}

extension UserDetailsViewController: UserDetailsViewable {
    func setAvatar(with stringUrl: String) {
        avatarImageView?.setImage(from: stringUrl)
    }
    
    func updateView(with model: UserDetailsModel) {
        guard let details = model.details else { return }
        nameValueLabel?.text = details.name
        bioValueLabel?.text = details.bio
        followersValueLabel?.text = "\(details.followers)"
        loginValueLabel?.text = details.login
    }
}
