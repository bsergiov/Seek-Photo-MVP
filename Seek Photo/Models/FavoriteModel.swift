//
//  FavoriteModel.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import RealmSwift
import Foundation

class FavoriteModel: Object {
    @Persisted var createdAt = ""
    @Persisted var img = Data()
    @Persisted var location = ""
    @Persisted var downloads = 0
}
