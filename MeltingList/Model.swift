import Foundation

struct Person: Decodable {
    let identifier: String
    let name: String
}

extension Person: Hashable, Comparable {
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

struct Company: Decodable {
    let identifier: String
    let name: String
    let staff: [Person]
}

extension Company: Hashable, Comparable {
    
    static func <(lhs: Company, rhs: Company) -> Bool {
        lhs.name < rhs.name
    }
    
    static func ==(lhs: Company, rhs: Company) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(name)
    }
}

extension Company {
    
    func maybeRemoveRandomStaffMember() -> Company {
        Company(
            identifier: identifier,
            name: name,
            staff: staff.maybeRemoveRandomElement()
        )
    }
}

private extension Array where Element: Equatable {

    func maybeRemoveRandomElement() -> [Element] {
        let should = Bool.random()
        guard should, let element = randomElement(), let index = firstIndex(of: element) else {
            return self
        }
        var myself = self
        myself.remove(at: index)
        return myself
    }
}
