//
//  DataService.swift
//  Demo
//
//  Created by Đừng xóa on 8/24/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

typealias DICT = Dictionary<AnyHashable, Any>

class DataService {
    static let shared: DataService = DataService()
    var test: DICT?
    
    private var _my4mien: [PlacesVietNam]?
    var my4mien: [PlacesVietNam] {
        get {
            if _my4mien == nil {
                getDataMien()
            }
            return _my4mien ?? []
        }
        set {
            _my4mien = newValue
        }
    }
    
    func getDataMien() {
        _my4mien = []
        getDataPlist()
        guard let places = test!["data"] as? [DICT] else {return}
        for place in places {
            if let mien = PlacesVietNam(dictionary: place) {
                _my4mien?.append(mien)
            }
        }
    }
    
    func getDataPlist() {
        guard let filePath = Bundle.main.path(forResource: "PlacesVietnam", ofType: "plist") else {return}
        guard FileManager.default.fileExists(atPath: filePath) else {return}
        guard let data = FileManager.default.contents(atPath: filePath) else { return }
        do {
            guard let root = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? DICT else { return }
            test = root
        } catch {
            print("PropertyListSerialization Error")
        }
    }
}
