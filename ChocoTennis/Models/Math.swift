//
//  Math.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//

import Foundation


class Math {
    var player1: User
    var player2: User
    var point1: Int
    var point2: Int
    var createdAt: Date
    var completedAt: Date
    
    init(player1: User, player2: User, point1: Int, point2: Int, createdAt: Date, completedAt: Date) {
        self.player1 = player1
        self.player2 = player2
        self.point1 = point1
        self.point2 = point2
        self.createdAt = createdAt
        self.completedAt = completedAt
    }
}
// player1: User
//player2: User
//point1: Int
//point2: Int
//created_at: Date
//completed_at: Date
