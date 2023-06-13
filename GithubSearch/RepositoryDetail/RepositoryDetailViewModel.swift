import Foundation

@MainActor
class RepositoryDetailViewModel: ObservableObject {
  @Published var repositoryDetail: RepositoryDetailModel?

  func loadDetail(_ fullname: String) async throws {
    guard let url = URL(string: "https://api.github.com/repos/\(fullname)") else {
      throw APIError.invalidURL
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    self.repositoryDetail = try JSONDecoder().decode(RepositoryDetailModel.self, from: data)
  }
}
