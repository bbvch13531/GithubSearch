import Foundation

@MainActor
class StarringViewModel: ObservableObject {
  @Published var isStarred = false

  func checkIfStarred(_ fullname: String) async throws {
    let isStarred = try await starring(fullname, method: .get)
    self.isStarred = isStarred
  }

  func toggleStar(_ fullname: String) async throws {
    if self.isStarred {
      try await starring(fullname, method: .delete)
    } else {
      try await starring(fullname, method: .put)
    }
    self.isStarred.toggle()
  }

  @discardableResult
  private func starring(_ fullname: String, method: HTTPMethod) async throws -> Bool {
    guard let url = URL(string: "https://api.github.com/user/starred/\(fullname)") else {
      throw APIError.invalidURL
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue(AppConfig.githubToken, forHTTPHeaderField: "Authorization")

    let (_, response) = try await URLSession.shared.data(for: urlRequest)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.invalidResponse
    }

    if httpResponse.statusCode == 204 {
      return true
    } else if httpResponse.statusCode == 404 {
      return false
    } else {
      throw APIError.invalidResponse
    }
  }
}
