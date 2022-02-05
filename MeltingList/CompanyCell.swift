import UIKit

final class CompanyCell: UITableViewCell {

    private let toggle = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        toggle.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        accessoryView = toggle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func switchToggled(_ toggle: UISwitch) {
        delegate?.companyCell(self, switchToggled: toggle)
    }
    
    func updateState(isOn: Bool) {
        toggle.isOn = isOn
    }
    
    weak var delegate: CompanyCellDelegate?
}

protocol CompanyCellDelegate: AnyObject {
    func companyCell(_ cell: CompanyCell, switchToggled toggle: UISwitch)
}
