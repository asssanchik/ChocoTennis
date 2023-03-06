//
//  ScoreMO.swift
//  ChocoTennis
//
//  Created by Assan on 01.02.2023.
//

import CoreData
import SWDataManager


@objc(ScoreMO)
class ScoreMO: NSManagedObject {
    @NSManaged var point: Int16
    @NSManaged var player: UserMO
    @NSManaged var match: MatchMO
}


extension ScoreMO: SWEntityNamable {
    static var entityName: String {
        return "Score"
    }
}
