import Foundation
import AccordionTable

struct Company: Decodable, Hashable {
    let identifier: String
    let name: String
    let staff: [Person]
}

struct Person: Decodable, Hashable {
    let identifier: String
    let name: String
}

typealias Collection = OrderedDictionary<Company, [Person]>
