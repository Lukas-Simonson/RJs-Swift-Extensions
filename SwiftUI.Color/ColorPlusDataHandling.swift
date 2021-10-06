//
//  ColorPlusDataHandling.swift
//  RJs-Extensions-Library
//
//  Created by Lukas Simonson on 7/28/21.
//

import SwiftUI

//	|| Extensions to SwiftUI.Color ||
//
//	Gives the user the ability to :
//		- Get RGBA Values of a Color Object
//		- Get a random Color
//		- Convert the Color Object to a String
//		- Convert a String to a Color Object

extension Color {
	
	// MARK: - RGBA Conversion
	
	// Stores RGBA Values from a Color
	private struct Components {
		
		let red : Double
		let green : Double
		let blue : Double
		let alpha : Double
	}
	
	// Grabs the RGBA Values and stores them in a Components Struct
	private var components : Components {
		
		var red : CGFloat = 0
		var green : CGFloat = 0
		var blue : CGFloat = 0
		var alpha : CGFloat = 0
		
		UIColor( self ).getRed( &red, green : &green, blue : &blue, alpha : &alpha )
		
		return Components( red : Double( red ),
						   green : Double( green ),
						   blue : Double( blue ),
						   alpha: Double( alpha )
		)
	}
	
	// MARK: - Random Color Attribute
	
	/**
	 Gets a random sRGB Color
	 
	 - Returns :
	 A SwiftUI.Color Object with a random sRGB Color value.
	 
	 - Version :
	 1.0
	 
	 */
	static var RJRandom : Color {
		
		let red = Double.random( in : 0...1 )
		let green = Double.random( in : 0...1 )
		let blue = Double.random( in : 0...1 )
		
		return Color( .sRGB, red : red, green : green, blue : blue, opacity: 1 )
	}
	
	// MARK: - Data Access
	
	///	Gives a Dictionary with all color data
	var RJColorData : Dictionary< ValueTypes, Double > {
		
		return [
			
			// Swift Data Values
			.swiftRed : components.red,
			.swiftGreen : components.green,
			.swiftBlue : components.blue,
			.swiftAlpha : components.alpha,
			
			// Standard RGBA Values
			.standardRed : Double( 255 * components.red ),
			.standardGreen : Double( 255 * components.green ),
			.standardBlue : Double( 255 * components.blue ),
			.standardAlpha : Double( 255 * components.alpha )
		]
	}
	
	/**
	 Call to get a specific Color Value
	 
	 - Parameter valueType : Takes a ValueType to return the desired value
	 
	 - Returns : Returns a Double equating to the desired color value
	 
	 - Version : 1.0
	 */
	func RJgetColorValue( _ valueType : ValueTypes ) -> Double {
		
		switch valueType {
				
				// Swift Data Values
			case .swiftRed : return components.red
			case .swiftGreen : return components.green
			case .swiftBlue : return components.blue
			case .swiftAlpha : return components.alpha
				
				// Standard RGBA Values
			case .standardRed : return Double( 255 * components.red )
			case .standardGreen : return Double( 255 * components.green )
			case .standardBlue : return Double( 255 * components.blue )
			case .standardAlpha : return Double( 255 * components.alpha )
				
			case .hex : return 0
		}
	}
	
	enum ValueTypes {
		
		case swiftRed
		case swiftGreen
		case swiftBlue
		case swiftAlpha
		
		case standardRed
		case standardGreen
		case standardBlue
		case standardAlpha
		
		case hex
	}
	
	// MARK: - Color String Conversion
	
	/// Converts the Color to a String and gives a String
	var RJAsString : String {
		
		return "\( components.red )||\( components.green )||\( components.blue )||\( components.alpha )"
	}
	
	/**
	 Converts a given String to a SwiftUI Color Object
	 
	 - parameter colorString : The string to be converted. Can either be a color name, or in the format redValue||greenValue||blueValue||alphaValue
	 
	 - Throws :
	 An Error of Type InitColorFromStringError
	 
	 - Version :
	 1.0
	 
	 - String Casing is irrelevant
	 
	 - The throw for this init can mostly be ignored using 'try?'. The throws can be treated as more of a debugging feature
	 
	 - Can take Strings in two forms
	 
	 - as a Color Name
	 - By default this is limited to the default Color values
	 - However, colors can be added in as Cases
	 
	 - As a converted String
	 - These do have to be in a specified Format
	 - The Format is as Follows :
	 - "redValue||greenValue||blueValue||alphaValue"
	 
	 */
	
	init( fromString colorString : String ) throws {
		
		// Lowercases the String and Switches for the Possible Outcome
		switch colorString.lowercased() {
				
			case "red" :
				self = .red
				
			case "green" :
				self = .green
				
			case "blue" :
				self = .blue
				
			case "yellow" :
				self = .yellow
				
			case "orange" :
				self = .orange
				
			case "pink" :
				self = .pink
				
			case "black" :
				self = .black
				
			case "gray" :
				self = .gray
				
				//			Add new Named Colors Below Here
				//
				//			case "nameOfColor" :
				//			self = Color( someColorInit )
				
				
				// Handles non named colors
			default : do {
				
				// Converts the String to a List of Strings
				let stringComponents = colorString.components(separatedBy: "||")
				
				// Checks if there is the right number of String Objects
				if stringComponents.count == 4 { // stringComponents is the right size
					
					// Converts the stringComponents to Doubles
					let red = Double( stringComponents[0] )
					let green = Double( stringComponents[1] )
					let blue = Double( stringComponents[2] )
					let alpha = Double( stringComponents[3] )
					
					// Checks if any Values couldnt be converted to doubles
					// Throws .invalidColorValue( colorValue: "color" ) if any values are nil
					if red == nil { throw( InitColorFromStringError.invalidColorValue(colorValue: "red") ) }
					if green == nil { throw( InitColorFromStringError.invalidColorValue(colorValue: "green") ) }
					if blue == nil { throw( InitColorFromStringError.invalidColorValue(colorValue: "blue") ) }
					if alpha == nil { throw( InitColorFromStringError.invalidColorValue(colorValue: "alpha") ) }
					
					// Sets Self to the Color Object
					self = Color( .sRGB,
								  red : red!,
								  green : green!,
								  blue : blue!,
								  opacity: alpha!
					)
				} else { // String Components is the wrong size
					
					// Throws .invalidStringProvided
					throw( InitColorFromStringError.invalidStringProvided )
				}
			}
		}
	}
	
	// Enum for init( fromString ) Errors
	enum InitColorFromStringError : Error {
		case invalidStringProvided
		case invalidColorValue( colorValue : String )
	}
	
	// MARK: - Standard RGBA Init
	
	
	/**
	 Gives a SwiftUI.Color object using the Standard 255 color values
	 
	 - Parameter red : the red value, takes an Int from 0 - 255
	 - Parameter green : the green value, takes an Int from 0 - 255
	 - Parameter blue : the blue value, takes an Int from 0 - 255
	 - Parameter alpha : the alpha / opacity value, takes an Int from 0 - 255
	 
	 - Version :
	 1.0
	 */
	init( red : Int = 255,
		  green : Int = 255,
		  blue : Int = 255,
		  alpha : Int = 255
	) {
		
		// Returs a Color Object while converting the RGBA values
		self = Color( .sRGB,
					  red : Double( 255 / red ),
					  green : Double( 255 / green ),
					  blue : Double( 255 / blue ),
					  opacity: Double( 255 / alpha )
		)
	}
	
	// MARK: - HEX Init
	
	
	/// Gives a SwiftUI.Color object using a Hex Color code
	///
	/// - Parameters:
	///    - hex: The hex color code string to parse into a Color
	///
	/// - Version: Beta 0.1
	init( hex: String ) {
		
		let scanner = Scanner(string: hex)
		scanner.currentIndex = .init(utf16Offset : 0, in: hex)
		var rgbValue: UInt64 = 0
		scanner.scanHexInt64(&rgbValue)
		
		let red = ( rgbValue & 0xff0000 ) >> 16
		let green = ( rgbValue & 0xff00 ) >> 8
		let blue = ( rgbValue & 0xff )
		
		self = Color( .sRGB,
					  red: Double( red ) / 0xff,
					  green: Double( green ) / 0xff,
					  blue: Double( blue ) / 0xff,
					  opacity: 1
		)
	}
}
