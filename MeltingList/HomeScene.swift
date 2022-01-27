import SwiftUI

struct HomeScene: View {

    @State private var companies = CompanyStore()
    
    @StateObject private var store = BackingStore()

    private var myView: some View {
        Group {
            if companies.isEmpty {
                Text("Loading")
            } else {
                NavigationLink(
                    "Ready", destination:
                        CompaniesScene(companies: companies, cellDelegate: store, listDelegate: store, dataSource: store)
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            myView
                .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                let data = try! await DataLoader.go(randomise: false)
                self.companies = data
            }
        }
    }
}
