import UIKit

final class CompanyTableMinion: AccordionTableMinion<Company, Person> {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        didSelect(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        guard let cell = cell as? CompanyCell else {
            return
        }
        let isOn = switchIsOn(for: cell, at: indexPath)
        cell.updateState(isOn: isOn)
    }

    private func switchIsOn(for cell: CompanyCell, at indexPath: IndexPath) -> Bool {
        guard let dataSource = dataSource, let person = tableManager.dataSource.itemIdentifier(for: indexPath) else {
            return false
        }
        return dataSource.companyTableMinion(self, shouldUpdateCell: cell, for: person)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ArrowHeaderView.height
    }
    
    var didSelect: (IndexPath) -> Void = { _ in }
    
    weak var dataSource: CompanyTableMinionDataSource?
}

protocol CompanyTableMinionDataSource: AnyObject {
    func companyTableMinion(_ companyTableMinion: CompanyTableMinion, shouldUpdateCell cell: CompanyCell, for person: Person) -> Bool
}
