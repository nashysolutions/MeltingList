import UIKit

final class CompaniesTableViewDelegate: AccordionTableViewDelegate<Company, Person> {
    
    var didSelect: (IndexPath) -> Void = { _ in }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        didSelect(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ArrowHeaderView.height
    }
}
