//
//  StorageManager.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import RealmSwift

class StorageManager {
    
    static let instance = StorageManager()
    
    let realm = try! Realm()
    
    private init() { }
    
    func fetch(completion: @escaping (Results<DetailModel>) -> Void) {
        let pictures = realm.objects(DetailModel.self)
        completion(pictures)
    }
    
    func save(_ picture: DetailModel) {
        write {
            realm.add(picture)
        }
    }
    
    func remove(_ picture: DetailModel) {
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
