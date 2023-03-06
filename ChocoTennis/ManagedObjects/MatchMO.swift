//
//  MatchMO.swift
//  ChocoTennis
//
//  Created by Assan on 25.01.2023.
//

import CoreData
import SWDataManager

@objc(MatchMO)
class MatchMO: NSManagedObject {
    @NSManaged var uuid: UUID
    @NSManaged var completedAt: Date
    @NSManaged var createdAt: Date
    @NSManaged var scores: Set<ScoreMO>
}

extension MatchMO: SWEntityNamable {
    static var entityName: String {
        return "Match"
    }
}
