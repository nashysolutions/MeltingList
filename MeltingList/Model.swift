import UIKit
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

typealias CompanyStore = OrderedDictionary<Company, [Person]>

final class BackingStore: ObservableObject {
    
    typealias SwitchStore = OrderedDictionary<Person, Bool>
    
    private var switchStore = SwitchStore()
}

extension BackingStore: CompaniesTableViewControllerDelegate {
    
    func companiesTableViewController(_ controller: CompaniesTableViewController, willUpdateUsingStore companyStore: CompanyStore) {
        cleanSwitchStore(using: companyStore)
    }
    
    /// The switch store may have staff members that no longer exists, as determined by the new dataset.
    /// - Parameter companyStore: The new incoming dataset.
    private func cleanSwitchStore(using companyStore: CompanyStore) {
        for company in companyStore.keys {
            for person in switchStore.keys {
                if company.staff.contains(person) == false {
                    switchStore[person] = false
                }
            }
        }
    }
}

extension BackingStore: CompanyCellDelegate {
    
    func companyCellSwitchToggled(isOn: Bool, for person: Person) {
        switchStore[person] = isOn
    }
}

extension BackingStore: CompanyTableMinionDataSource {
    
    func companyTableMinion(_ companyTableMinion: CompanyTableMinion, shouldUpdateCell cell: CompanyCell, for person: Person) -> Bool {
        switchStore[person] ?? false
    }
}
