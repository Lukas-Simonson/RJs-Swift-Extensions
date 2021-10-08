//
//  CodablePlusJSONEncode.swift
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation


extension Encodable {
	
	/// Returns a `String` containing the JSON encoded version of this object.
	///
	/// - Note: Is not error Handled, may return "ERROR" as a `String` if the object cannot be encoded.
	///
	/// - Returns: A `String` object containing the JSON Encoded version of this object.
	var jsonString : String {
		
		if let returnData = try? jsonEncodeAsString() { return returnData }
		
		return "ERROR"
	}
	
	/// Returns a `Data` object containing the JSON encoded version of this object.
	///
	/// - Note: Is not error Handled, may return an Empty `Data` object if the object cannot be encoded.
	///
	/// - Returns: A `Data` object containing the JSON Encoded version of this object.
	var jsonData : Data {
		
		if let returnData = try? jsonEncodeAsData() { return returnData }
		
		return Data()
	}
	
	/// Creates a `Data` object containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s caught during the JSON Encoding.
	///
	/// - Returns: The created `Data` object.
	func jsonEncodeAsData() throws -> Data {
		
		do {
			
			return try JSONEncoder().encode( self )
		}
		catch ( let error ) {
			
			throw error
		}
		
	}
	
	/// Creates a `String` containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s caught during the JSON or `String` Encoding.
	///
	/// - Returns: The created `String`
	func jsonEncodeAsString() throws -> String {
		
		do {
			let jsonData = try JSONEncoder().encode( self )
			
			if let returnString = String( data: jsonData, encoding: .utf8 ) { return returnString }
			else { throw EncodingErrors.jsonStringEncodingError }
		}
		catch( let error ) {
			throw error
		}
	}
}

enum EncodingErrors : Error {

	case jsonStringEncodingError
}
