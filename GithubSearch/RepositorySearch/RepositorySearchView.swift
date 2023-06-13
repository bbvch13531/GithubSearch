import SwiftUI

struct RepositorySearchView: View {
  @ObservedObject var viewModel: RepositorySearchViewModel
  @State var keyword = ""
  
  init(viewModel: RepositorySearchViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      List(viewModel.searchResults, id: \.self) { repoName in
        NavigationLink {
          RepositoryDetailView(
            repoDetailViewModel: .init(),
            starringViewModel: .init(),
            fullname: repoName
          )
        } label: {
          Text(repoName)
        }
      }
      .searchable(text: $keyword)
      .onChange(of: keyword) { keyword in
        Task {
          try await viewModel.search(keyword)
        }
      }
      .navigationTitle("Github Search")
    }
  }
}

struct RepositorySearchView_Previews: PreviewProvider {
  static var previews: some View {
    RepositorySearchView(viewModel: .init())
  }
}
