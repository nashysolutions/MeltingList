import UIKit

final class CompaniesTableViewController: AccordionTableViewController<CompaniesTableView, Company, Person> {
    
    private(set) lazy var tableMinion = CompanyTableMinion(diffableTableManager)
    
    var companies: CompanyStore!
    
    weak var delegate: CompaniesTableViewControllerDelegate?
    
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
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.disableFloatingHeaders()
        
        tableView.delegate = tableMinion
        
//        tableMinion.didSelect = { [unowned self] indexPath in
//            let controller = DestinationViewController()
//            self.show(controller, sender: nil)
//        }
        
        // Rediculous workaround for swiftui navigation view.
        DispatchQueue.main.async {
            let button = UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(self.fetchButtonPressed(_:)))
            self.parent?.navigationItem.rightBarButtonItem = button
        }
        
        update(with: companies, animated: false, completion: {})
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deselectSelectedRow()
    }
    
    @objc
    private func fetchButtonPressed(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        Task {
            let data = try! await DataLoader.go(randomise: true)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.delegate?.companiesTableViewController(self, willUpdateUsingStore: data)
                self.update(with: data, animated: true) {
                    sender.isEnabled = true
                    self.tableView.scrollToNearestSelectedRow(at: .middle, animated: true)
                }
            }
        }
    }
}