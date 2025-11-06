//
//  UserDetailsModel.swift
//  GithubSearch
//
//  Created by Iron Man on 06/11/25.
//

struct UserDetailsModel: Decodable, Equatable {
    let avatarUrl: String?
    let url: String?
    let details: UserDetails?
}

struct UserDetails: Decodable, Equatable {
    let name: String
    let login: String
    let bio: String
    let followers: Int
    let publicRepos: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case login
        case bio
        case followers
        case following
        case publicRepos = "public_repos"
    }
}
