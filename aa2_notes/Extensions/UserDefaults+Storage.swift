//
//  UserDefaults+Storage.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation

extension UserDefaults {
    
    @discardableResult func Save(data: Encodable, key: String) -> Bool
    {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            self.set(encoded, forKey: key)
            return true
        }
        
        return false
    }
    
    func get<T:Decodable>(_ t: T.Type, key: String) -> T?
    {
        if let data = self.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let dataObj = try? decoder.decode(T.self, from: data) {
                return dataObj
            }
        }
        return nil
    }
    
}
