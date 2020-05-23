import Foundation

extension String {
    var dataEncoded: Data {
        return self.data(using: String.Encoding.utf8)!
    }
}
