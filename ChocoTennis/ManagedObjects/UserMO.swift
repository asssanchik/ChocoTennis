//
//  UserMO.swift
//  ChocoTennis
//
//  Created by Assan on 25.01.2023.
//

import CoreData
// обьект для сущности в БД
@objc(UserMO)
class UserMO: NSManagedObject {
    @NSManaged var name: String?
}
