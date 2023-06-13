import SwiftUI

struct StargazerView: View {
  @ObservedObject var viewModel: StargazerViewModel
  let username: String

  init(viewModel: StargazerViewModel, username: String) {
    self.viewModel = viewModel
    self.username = username
  }

  var body: some View {
    NavigationView {
      List(viewModel.repositories, id: \.self) { repo in
        NavigationLink {
          RepositoryDetailView(
            repoDetailViewModel: .init(),
            starringViewModel: .init(),
            fullname: repo
          )
        } label: {
          Text(repo)
        }
      }
      .task {
        Task {
          try await viewModel.loadStarredList(username)
        }
      }
    }
  }
}

struct StargazerView_Previews: PreviewProvider {
  static var previews: some View {
    StargazerView(viewModel: .init(), username: "")
  }
}
