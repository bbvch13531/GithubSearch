import Foundation

@MainActor
class StargazerViewModel: ObservableObject {
  @Published var repositories = [String]()

  func loadStarredList(_ username: String) async throws {
    guard let url = URL(string: "https://api.github.com/users/\(username)/starred") else {
      throw APIError.invalidURL
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let repositories = try JSONDecoder().decode([StarredListModel].self, from: data)

    self.repositories = repositories.map { $0.fullname }
  }
}
