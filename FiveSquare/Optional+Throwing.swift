//
//  Optional+Throwing.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/24/24.
//

extension Optional {
    
    /// Error thrown when an optional unexpectedly contains `nil`.
    enum OptionalError: Error {
        case unexpectedNil
    }
    
    /// Helper function to throw an error if an optional value is `nil`.
    /// - Returns: The unwrapped value.
    /// - Throws: `OptionalError.unexpectedNil` if the optional contains `nil`.
    func unwrapped() throws -> Wrapped {
        if case let .some(wrapped) = self {
            return wrapped
        } else {
            throw OptionalError.unexpectedNil
        }
    }
}
