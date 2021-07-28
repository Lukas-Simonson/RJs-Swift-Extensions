//
//  Array-RemoveDuplicates.swift
//  Memorize
//
//  Created by Lukas Simonson on 7/22/21.
//

import Foundation

extension Array where Element : Equatable {
	
	/**
		Removes duplicate items from an Array
	
		- Version : 1.0
	
		- Important : Items in the Array must follow the Equatable Protocol
	*/
	
	mutating func removeDuplicates() {
		
		// Holds new Cleaned Array
		var cleanedArray = Array< Element >()
		
		// Iterates through all Items
		self.forEach { item in
			
			// Checks if the Item Exists
			if !cleanedArray.contains( item ) {
				
				// Adds non Duplicate Item to the Cleaned Array
				cleanedArray.append( item )
			}
		}
		
		// Sets self to the Cleaned Array
		self = cleanedArray
	}
}
