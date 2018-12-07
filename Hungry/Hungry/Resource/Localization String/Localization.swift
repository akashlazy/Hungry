 import UIKit
 
 extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func removeSpecialCharsFromString(_ text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_'".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func equals(_ text: String) -> Bool {
        return self == text
    }
    
    func split(_ text: String) -> [String] {
        return self.components(separatedBy: text)
    }
}
