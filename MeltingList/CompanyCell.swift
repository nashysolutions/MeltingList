import UIKit

final class CompanyCell: UITableViewCell {

    var switchValueChanged: (Bool) -> Void = { _ in }
    
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
        switchValueChanged(toggle.isOn)
    }
    
    func updateState(isOn: Bool) {
        toggle.isOn = isOn
    }
}
