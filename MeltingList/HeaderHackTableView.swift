import UIKit

class HeaderHackTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        fixAnimationBug()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Hides floating headers behind navigation bar.
    // Assumes nav bar is opaque
    func disableFloatingHeaders() {
        contentInset.top = -headerHeight
        tableHeaderView = makeHeaderView(height: headerHeight)
    }
    
    private func makeHeaderView(height: CGFloat) -> UIView {
        let width = bounds.width
        let frame = CGRect(origin: .zero, size: .init(width: width, height: height))
        return UIView(frame: frame)
    }
    
    // override me
    var headerHeight: CGFloat {
        return 0
    }

    /* - Release notes for iOS 11 beta 2
     Table views now use estimated heights by default, which also
     means that cells and section header/footer views now self-size
     by default. The default value of the estimatedRowHeight,
     estimatedSectionHeaderHeight, and estimatedSectionFooterHeight
     properties is now UITableViewAutomaticDimension, which means
     the table view selects an estimated height to use. You should
     still provide a more accurate estimate for each property if
     possible, which is your best guess of the average value of the
     actual heights. If you have existing table view code that behaves
     differently when you build your app with the iOS 11 SDK, and you
     don’t want to adopt self-sizing, you can restore the previous
     behavior by disabling estimated heights by setting a value of
     zero for each estimated height property. (30197915)
     */
    private func fixAnimationBug() {
        estimatedRowHeight = 0
        estimatedSectionHeaderHeight = 0
        estimatedSectionFooterHeight = 0
    }
}
