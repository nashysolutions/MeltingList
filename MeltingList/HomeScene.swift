import SwiftUI

struct HomeScene: View {

    @State private var companies = Collection()

    private var myView: some View {
        Group {
            if companies.isEmpty {
                Text("Loading")
            } else {
                NavigationLink(
                    "Ready", destination:
                        CompaniesScene(companies: companies)
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
