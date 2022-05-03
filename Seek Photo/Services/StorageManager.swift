//
//  StorageManager.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() { }
    
    func fetch(completion: @escaping (Results<FavoriteModel>) -> Void) {
        let pictures = realm.objects(FavoriteModel.self)
        completion(pictures)
    }
    
    func save(_ picture: FavoriteModel) {
        write {
            realm.add(picture)
        }
    }
    
    func remove(_ picture: FavoriteModel) {
        write {
            realm.delete(picture)
        }
    }
    
    // MARK: - Helper Method
    private func write(completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch  {
            print("Error write realm in db: \(error)")
        }
    }
}
