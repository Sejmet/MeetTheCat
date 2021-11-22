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
    
    /**
     Create Cat Array
     */
    public func makeCatArray(json: Data) -> [Cat]? {
        do {
            let result = try JSONDecoder().decode([Cat].self, from: json)
            return result
        } catch {
            print("Error parsing a Cat Array", error.localizedDescription)
            return nil
        }
    }
    
    
    
    /**
     Create Error Response Object
     */
    public func makeErrorResponse(json: Data) -> ErrorResponse? {
        do {
            let result = try JSONDecoder().decode(ErrorResponse.self, from: json)
            return result
        } catch {
            print("Error parsing a ErrorResponse", error.localizedDescription)
            return nil
        }
    }
}
