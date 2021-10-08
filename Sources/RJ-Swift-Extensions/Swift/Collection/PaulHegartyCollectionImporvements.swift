//
//  File.swift
//  
//
//  Created by Paul Hegarty.
//


extension Collection where Element: Identifiable {
	
	func index(matching element: Element) -> Self.Index? {
		firstIndex(where: { $0.id == element.id })
	}
}

// we could do the same thing when it comes to removing an element
// but we have to add that to a different protocol
// because Collection works for immutable collections of things
// the "mutable" one is RangeReplaceableCollection
// not only could we add remove
// but we could add a subscript which takes a copy of one of the elements
// and uses its Identifiable-ness to subscript into the Collection
// this is an awesome way to create Bindings into an Array in a ViewModel
// (since any Published var in an ObservableObject can be bound to via $)
// (even vars on that Published var or subscripts on that var)
// (or subscripts on vars on that var, etc.)

extension RangeReplaceableCollection where Element: Identifiable {
	mutating func remove(_ element: Element) {
		if let index = index(matching: element) {
			remove(at: index)
		}
	}

	subscript(_ element: Element) -> Element {
		get {
			if let index = index(matching: element) {
				return self[index]
			} else {
				return element
			}
		}
		set {
			if let index = index(matching: element) {
				replaceSubrange(index...index, with: [newValue])
			}
		}
	}
}

// if you use a Set to represent the selection of emoji in HW5
// then you might find this syntactic sugar function to be of use

extension Set where Element: Identifiable {
	mutating func toggleMembership(of element: Element) {
		if let index = index(matching: element) {
			remove(at: index)
		} else {
			insert(element)
		}
	}
}

