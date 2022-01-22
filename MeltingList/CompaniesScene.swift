import SwiftUI

struct CompaniesScene: UIViewControllerRepresentable {
    
    let companies: Collection
    
    func makeUIViewController(context: Context) -> CompaniesTableViewController {
        
        let tableView = CompaniesTableView(frame: .zero, style: .plain)
        
        let controller = CompaniesTableViewController(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.name
            return cell
        } headerProvider: { tableView, index, section in
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ArrowHeaderView.identifier)
            guard let view = view as? ArrowHeaderView else {
                fatalError()
            }
            view.updateTitle(with: section.name)
            return view
        }
        
        controller.title = "Companies"
        controller.companies = companies
        
        return controller
    }
    
    func updateUIViewController(_ controller: CompaniesTableViewController, context: Context) {
        
    }
}
