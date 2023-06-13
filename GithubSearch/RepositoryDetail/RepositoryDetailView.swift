import SwiftUI

struct RepositoryDetailView: View {
  @ObservedObject var repoDetailViewModel: RepositoryDetailViewModel
  @ObservedObject var starringViewModel: StarringViewModel

  let fullname: String

  init(repoDetailViewModel: RepositoryDetailViewModel, starringViewModel: StarringViewModel, fullname: String) {
    self.repoDetailViewModel = repoDetailViewModel
    self.starringViewModel = starringViewModel
    self.fullname = fullname
  }

  var body: some View {
    VStack {
      if let result = repoDetailViewModel.repositoryDetail {
        Text(result.fullname)
        Text(result.ownerName)
        Text(result.ownerUserThumbnail)
        Text("\(result.starCount)")
        Text("\(result.forkCount)")

        Button {
          Task {
           try await starringViewModel.toggleStar(fullname)
          }
        } label: {
          HStack {
            if starringViewModel.isStarred {
              Image(systemName: "star.fill")
              Text("Unstar")
            } else {
              Image(systemName: "star")
              Text("Star")
            }
          }
        }
      }
    }
    .task {
      Task {
        try await repoDetailViewModel.loadDetail(fullname)
        try await starringViewModel.checkIfStarred(fullname)
      }
    }
  }
}

struct RepositoryDetailView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryDetailView(
      repoDetailViewModel: .init(),
      starringViewModel: .init(),
      fullname: ""
    )
  }
}
