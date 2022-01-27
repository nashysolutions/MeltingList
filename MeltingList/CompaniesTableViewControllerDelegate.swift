import Foundation

protocol CompaniesTableViewControllerDelegate: AnyObject {
    func companiesTableViewController(_ controller: CompaniesTableViewController, willUpdateUsingStore store: CompanyStore)
}
