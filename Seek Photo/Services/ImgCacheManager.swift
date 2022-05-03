//
//  ImgCacheManager.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class ImgCacheManager {
    
    static var instance = ImgCacheManager()
    
    private var imgCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // ~ 200mb
        return cache
    }()
    
    private init() { }
    
    func add(key: String, value: UIImage) {
        imgCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imgCache.object(forKey: key as NSString)
    }
}
