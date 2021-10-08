//
//  RJDecoding.swift
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation

final public class RJDecoding {
	
	/// Converts an `Array` of JSON `Strings` to an `Array` of the given objectType.
	///
	/// - Parameters:
	///   - objects: An `Array` of JSON `Strings` to convert to an `Array` of objectType.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of the given objectType.
	///
	static func convertJSONStringList< objectType : Codable >( _ objects : [ String ] ) throws -> [ objectType ] {
		
		var returnData : [ objectType ] = []
		
		do {
			
			try objects.forEach { item in
				
				// Converts the item from `String` to `Data`
				let objectData = item.data( using: .utf8 ) ?? Data()
				
				// Converts the objectData value into the given objectType
				let convertedData = try JSONDecoder().decode( objectType.self, from: objectData )
				
				returnData.append( convertedData )
			}
			
		} catch ( let error ) {
			throw error
		}
		
		return returnData
	}
	
	
	/// Converts an `Array` of JSON `Data` objects to an `Array` of the given objectType.
	///
	/// - Parameters:
	///   - objects: An `Array` of JSON `Data` objects to convert to an `Array` of objectType.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of the given objectType.
	///
	static func convertJSONDataList< objectType : Codable >( _ objects : [ Data ] ) throws -> [ objectType ] {
		
		var returnData : [ objectType ] = []
		
		do {
			
			try objects.forEach { item in
				
				let convertedData = try JSONDecoder().decode( objectType.self, from: item )
				
				returnData.append( convertedData )
			}
			
		} catch ( let error ) {
			throw error
		}
		
		return returnData
	}
}
