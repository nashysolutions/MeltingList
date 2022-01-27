import Foundation

protocol CompanyCellDelegate: AnyObject {
    func companyCellSwitchToggled(isOn: Bool, for person: Person)
}
