import Foundation

@MainActor
class RepositorySearchViewModel: ObservableObject {
  @Published var searchResults = [String]()

  func search(_ keyword: String) async throws {
    guard let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)") else {
      throw APIError.invalidURL
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let repositories = try JSONDecoder().decode(RepositoryModel.self, from: data)

    self.searchResults = repositories.items.map { $0.name }
  }
}
