import Foundation

struct DataLoader {

    static func go(randomise: Bool) async throws -> CompanyStore {
        var collection = CompanyStore()
        let companies = try await read()
        for company in companies {
            if randomise {
                collection[company] = company.staff.maybeRemoveRandomElement()
            } else {
                collection[company] = company.staff
            }
        }
        return collection
    }

    private static func read() async throws -> [Company] {
        let url = Bundle.main.url(forResource: "staff", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Company].self, from: data)
    }
}
