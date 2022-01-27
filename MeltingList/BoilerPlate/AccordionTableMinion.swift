import UIKit
import AccordionTable

class AccordionTableMinion<Section: Hashable, Item: Hashable>: NSObject, UITableViewDelegate {
    
    let tableManager: AccordionTable<Section, Item>
    
    init(_ tableManager: AccordionTable<Section, Item>) {
        self.tableManager = tableManager
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableManager.viewForHeader(in: tableView, at: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableManager.selectRowIfNeeded(in: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let isSelected = tableManager.toggleSelectedStateForRow(at: indexPath) else {
            return
        }
        if !isSelected {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableManager.saveDeselectedStateForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
