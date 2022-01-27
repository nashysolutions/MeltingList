import UIKit

final class CompaniesTableView: HeaderHackTableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerSectionHeaders()
        register(CompanyCell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var headerHeight: CGFloat {
        ArrowHeaderView.height
    }
    
    private func registerSectionHeaders() {
        let name = ArrowHeaderView.name
        let identifier = ArrowHeaderView.identifier
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
