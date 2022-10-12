import UIKit
import AccordionTable

final class ListViewController: UIViewController {

    private lazy var tableView = CompaniesTableView(frame: .zero, style: .plain)
    
    private lazy var tableDataSource = UITableViewDiffableDataSource<Company, Person>(
        tableView: tableView,
        cellProvider: { [weak self] tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompanyCell
            cell.textLabel?.text = item.name
            cell.delegate = self
            return cell
        }
    )

    private lazy var diffableTableManager = AccordionTable<Company, Person>(
        dataSource: tableDataSource,
        enabledFeatures: collapsibleSectionsEnabled ? [.collapsible] : [],
        headerProvider: { tableView, index, section in
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ArrowHeaderView.identifier) as! ArrowHeaderView
            view.updateTitle(with: section.name)
            return view
        }
    )
    
    private(set) lazy var tableMinion = CompanyTableMinion(diffableTableManager)
    
    // backing store
    private var switchStore = [Person: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let button = UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(self.fetchButtonPressed(_:)))
        navigationItem.rightBarButtonItem = button
        
        tableView.delegate = tableMinion
        
        if collapsibleSectionsEnabled {
            tableView.disableFloatingHeaders()
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableMinion.dataSource = self
        
//        tableMinion.didSelect = { [unowned self] indexPath in
//            let controller = DestinationViewController()
//            self.show(controller, sender: nil)
//        }

        let data = try! DataLoader.go(randomise: false)
        diffableTableManager.update(with: data, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deselectSelectedRow()
    }

    @objc
    private func fetchButtonPressed(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        let data = try! DataLoader.go(randomise: true)
        let people: [Person] = data.flatMap { $0.value }
        switchStore.removeMissingStaff(people)
        diffableTableManager.update(with: data, animated: true, completion: {
            sender.isEnabled = true
            self.tableView.scrollToNearestSelectedRow(at: .middle, animated: true)
        })
    }
}

extension ListViewController {
    
    private var selectedItem: Person? {
        diffableTableManager.selectedRow
    }
    
    private func indexPath(for item: Person) -> IndexPath? {
        tableDataSource.indexPath(for: item)
    }
    
    private var indexPathForSelectedRow: IndexPath? {
        if let item = selectedItem {
           return indexPath(for: item)
        }
        return nil
    }
    
    func deselectSelectedRow() {
        if let indexPath = indexPathForSelectedRow {
            diffableTableManager.saveDeselectedStateForRow(at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ListViewController: CompanyCellDelegate {
    
    func companyCell(_ cell: CompanyCell, switchToggled toggle: UISwitch) {
        guard
            let indexPath = tableView.indexPath(for: cell),
            let person = tableDataSource.itemIdentifier(for: indexPath) else {
            return
        }
        switchStore[person] = toggle.isOn
    }
}

extension ListViewController: CompanyTableMinionDataSource {
    
    func companyTableMinion(_ companyTableMinion: CompanyTableMinion, shouldUpdateCell cell: CompanyCell, for person: Person) -> Bool {
        switchStore[person] ?? false
    }
}

private extension Dictionary where Key == Person, Value == Bool {
    
    mutating func removeMissingStaff(_ staff: [Person]) {
        let predicate: (Person) -> Value = { person in staff.contains(person) == false }
        keys.filter(predicate).forEach { person in
            self[person] = nil
        }
    }
}
