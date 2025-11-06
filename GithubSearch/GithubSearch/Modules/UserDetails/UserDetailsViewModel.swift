//
//  UserDetailsViewModel.swift
//  GithubSearch
//
//  Created by Iron Man on 06/11/25.
//

protocol UserDetailsViewModelable {
    func viewLoaded()
}

class UserDetailsViewModel {
    var view: UserDetailsViewable?
    var model: UserDetailsModel?
    
    init(view: UserDetailsViewable?, model: UserDetailsModel?) {
        self.view = view
        self.model = model
    }
}

extension UserDetailsViewModel: UserDetailsViewModelable {
    func viewLoaded() {
        guard let model else {return}
        if let avatarUrl = model.avatarUrl {
            view?.setAvatar(with: avatarUrl)
        }
    }
}
