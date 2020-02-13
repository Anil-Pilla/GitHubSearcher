//
//  GitHubUserDetail.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 13/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation

struct  GitHubUserDetail: Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
    
    let name: String
    let company: String?
    let blog: String?
    let location: String?
    let email: String
    let hireable: String?
    let bio: String?
    let public_repos: Int
    let public_gists: Int
    let followers: Int
    let following: Int
    let created_at: String?
    let updated_at: String?

    private enum CodingKeys: String, CodingKey{
        case login
        case id
        case node_id
        case avatar_url
        case gravatar_id
        case url
        case html_url
        case followers_url
        case following_url
        case gists_url
        case starred_url
        case subscriptions_url
        case organizations_url
        case repos_url
        case events_url
        case received_events_url
        case type
        case site_admin
        
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case public_repos
        case public_gists
        case followers
        case following
        case created_at
        case updated_at
        
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decode(String.self, forKey: .login)
        id = try container.decode(Int.self, forKey: .id)
        node_id = try container.decode(String.self, forKey: .node_id)
        avatar_url = try container.decode(String.self, forKey: .avatar_url)
        gravatar_id = try container.decode(String.self, forKey: .gravatar_id)
        url = try container.decode(String.self, forKey: .url)
        html_url = try container.decode(String.self, forKey: .html_url)
        followers_url = try container.decode(String.self, forKey: .followers_url)
        following_url = try container.decode(String.self, forKey: .following_url)
        gists_url = try container.decode(String.self, forKey: .gists_url)
        starred_url = try container.decode(String.self, forKey: .starred_url)
        subscriptions_url = try container.decode(String.self, forKey: .subscriptions_url)
        organizations_url = try container.decode(String.self, forKey: .organizations_url)
        repos_url = try container.decode(String.self, forKey: .repos_url)
        events_url = try container.decode(String.self, forKey: .events_url)
        received_events_url = try container.decode(String.self, forKey: .received_events_url)
        type = try container.decode(String.self, forKey: .type)
        site_admin = try container.decode(Bool.self, forKey: .site_admin)
        
        name = (try container.decodeIfPresent(String.self, forKey: .name)) ?? ""
        company = (try container.decodeIfPresent(String.self, forKey: .company)) ?? ""
        blog = (try container.decodeIfPresent(String.self, forKey: .blog)) ?? ""
        location = (try container.decodeIfPresent(String.self, forKey: .location)) ?? ""
        email = (try container.decodeIfPresent(String.self, forKey: .email)) ?? ""
        hireable = (try container.decodeIfPresent(String.self, forKey: .hireable)) ?? ""
        bio = (try container.decodeIfPresent(String.self, forKey: .bio)) ?? ""
        public_repos = (try container.decodeIfPresent(Int.self, forKey: .public_repos)) ?? 0
        public_gists = (try container.decodeIfPresent(Int.self, forKey: .public_gists)) ?? 0
        followers = (try container.decodeIfPresent(Int.self, forKey: .followers)) ?? 0
        following = (try container.decodeIfPresent(Int.self, forKey: .following)) ?? 0
        created_at = (try container.decodeIfPresent(String.self, forKey: .created_at)) ?? ""
        updated_at = (try container.decodeIfPresent(String.self, forKey: .updated_at)) ?? ""
    }
}
