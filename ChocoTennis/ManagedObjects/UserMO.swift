//
//  UserMO.swift
//  ChocoTennis
//
//  Created by Assan on 25.01.2023.
//

import CoreData
import SWDataManager
// обьект для сущности в БД
@objc(UserMO)
class UserMO: NSManagedObject {
    @NSManaged var uuid: UUID
    @NSManaged var name: String?
}

extension UserMO: SWEntityNamable {
    static var entityName: String {
    return "User"
    }
}
