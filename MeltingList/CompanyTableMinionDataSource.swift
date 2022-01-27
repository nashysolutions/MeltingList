import Foundation

protocol CompanyTableMinionDataSource: AnyObject {
    func companyTableMinion(_ companyTableMinion: CompanyTableMinion, shouldUpdateCell cell: CompanyCell, for person: Person) -> Bool
}
