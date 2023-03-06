//
//  UserRepository.swift
//  ChocoTennis
//
//  Created by Assan on 13.02.2023.
//

import Foundation
import SWDataManager


class UserRepository {
    static func getOrCreateUser(byName name: String) -> UserMO {
        var user = SWDataManager.main.fetch(UserMO.self, whereFormat: "name = %@", name).first
        if let user = user {
            return user
        }
        user = SWDataManager.main.insert(for: UserMO.self)
        user?.uuid = UUID()
        user?.name = name
        SWDataManager.main.save()
        return user!
    }
    
}
