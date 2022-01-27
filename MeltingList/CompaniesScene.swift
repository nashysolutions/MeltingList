import SwiftUI

struct CompaniesScene: UIViewControllerRepresentable {
    
    let companies: CompanyStore
    
    let cellDelegate: CompanyCellDelegate
    
    let listDelegate: CompaniesTableViewControllerDelegate
    
    let dataSource: CompanyTableMinionDataSource
    
    func makeUIViewController(context: Context) -> CompaniesTableViewController {
        
        let tableView = CompaniesTableView(frame: .zero, style: .plain)
        
        let controller = CompaniesTableViewController(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompanyCell
            cell.textLabel!.text = item.name
            cell.switchValueChanged = { isOn in
                cellDelegate.companyCellSwitchToggled(isOn: isOn, for: item)
            }
            return cell
        } headerProvider: { tableView, index, section in
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ArrowHeaderView.identifier) as! ArrowHeaderView
            view.updateTitle(with: section.name)
            return view
        }

        controller.title = "Companies"
        controller.companies = companies
        controller.tableMinion.dataSource = dataSource
        controller.delegate = listDelegate
        
        return controller
    }
    
    func updateUIViewController(_ controller: CompaniesTableViewController, context: Context) {
        
    }
}
