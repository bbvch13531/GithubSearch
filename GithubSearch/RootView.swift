import SwiftUI

struct RootView: View {
  var body: some View {
    TabView {
      RepositorySearchView(viewModel: .init())
        .tabItem {
          Text("Search")
        }

      StargazerView(viewModel: .init(), username: "bbvch13531")
        .tabItem {
          Text("Star")
        }
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
