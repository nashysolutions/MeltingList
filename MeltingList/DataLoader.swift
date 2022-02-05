import Foundation

struct DataLoader {

    static func go(randomise: Bool) throws -> [Company: [Person]] {
        try read().reduce(into: [Company: [Person]](), { storage, company in
            var entity = company
            defer {
                storage[entity] = entity.staff
            }
            if randomise {
                entity = entity.maybeRemoveRandomStaffMember()
            }
        })
    }

    private static func read() throws -> [Company] {
        let url = Bundle.main.url(forResource: "staff", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Company].self, from: data)
    }
}
