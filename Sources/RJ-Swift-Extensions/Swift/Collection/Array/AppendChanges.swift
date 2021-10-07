//
//  AppendChanges.swift
//
//  Created by Lukas Simonson on 10/7/21
//
//	Version : 1.0
//

import Foundation

extension Array where Element : Equatable {
	
	/// Appends another `Array` into this object, only including new `Elements`.
	///
	/// - Parameters:
	///   - list : An `Array` of the same `Type` as this object to merge.
	///
	/// - Version:
	/// 	1.0
	///
	/// - Throws:
	/// 	A `RJArrayError` when passed an `Array` with a different Element type than this Object.
	///
	mutating func appendChanges< objectType : Equatable >( from list : [ objectType ] ) throws {
		
		// Checks the given list for proper typing.
		if !( list is [Element] ) { throw RJArrayAppendChangesError.MismatchedElementsInArrays }
		else {
			
			// Iterates through list.
			list.forEach { item in
				
				// Checks if the item already exists in the Array.
				if !( self.contains( item as! Element ) ) {
					
					// Appends the item not found in the original Array.
					self.append( item as! Element )
				}
			}
		}
	}
}

/// Errors for Array appendChanges
enum RJArrayAppendChangesError : Error {
	case MismatchedElementsInArrays
}
