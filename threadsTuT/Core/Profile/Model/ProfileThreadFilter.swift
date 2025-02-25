//
//  ProfileThreadFilter.swift
//  threadsTuT
//
//  Created by ABHINAV ANAND  on 14/02/25.
//


import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies

    var id: Int { return self.rawValue }

    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        }
    }
}