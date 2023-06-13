struct RepositoryModel: Decodable, Equatable, Sendable {
  var items: [Result]

  struct Result: Decodable, Equatable, Sendable {
    var name: String

    enum CodingKeys: String, CodingKey {
      case name = "full_name"
    }
  }
}
