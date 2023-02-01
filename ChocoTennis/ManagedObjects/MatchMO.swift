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
    @NSManaged var completedAt: Date
    @NSManaged var createdAt: Date
}
