//
//  ModelFactory.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import Foundation

class ModelFactory: NSObject {
    /**
     Create Cat Object
     */
    public func makeCatObject(json: Data) -> Cat? {
        do {
            let result = try JSONDecoder().decode(Cat.self, from: json)
            return result
        } catch {
            print("Error parsing a Cat Object", error.localizedDescription)
            return nil
        }
    }
}
