//
//  SomeKindOfBool.swift
//  MeetTheCat
//
//  Created by Sejmet on 22/11/2021.
//

import UIKit

@propertyWrapper
struct SomeKindOfBool: Decodable {
    var wrappedValue: Bool?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringifiedValue = try? container.decode(String.self) {
            switch stringifiedValue.lowercased() {
            case "false", "no",  "0", "n", "f": wrappedValue = false
            case "true", "yes", "1", "y", "t": wrappedValue = true
            default: throw DecodeError.unknownString(stringifiedValue) /* You can handle other Strings here if you want */
            }
        } else if let integerifiedValue = try? container.decode(Int.self) {
            switch integerifiedValue {
            case 0: wrappedValue = false
            case 1: wrappedValue = true
            default: throw DecodeError.unknownInteger(integerifiedValue) /* You can handle other Integers here if you want */
            }
        } else {
            wrappedValue = try container.decode(Bool.self)
        }
    }
}

// MARK: - Errors
enum DecodeError: Error {
    case unknownString(String)
    case unknownInteger(Int)
}
