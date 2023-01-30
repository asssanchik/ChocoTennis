//
//  MatchMO.swift
//  ChocoTennis
//
//  Created by Assan on 25.01.2023.
//

import CoreData


@objc(MatchMO)
class MatchMO: NSManagedObject {
    @NSManaged var uuid: UUID
    @NSManaged var point1: Int16
    @NSManaged var point2: Int16
    @NSManaged var completedAt: Date
    @NSManaged var createdAt: Date
    @NSManaged var playerUUID1: UUID
    @NSManaged var playerUUID2: UUID
}
