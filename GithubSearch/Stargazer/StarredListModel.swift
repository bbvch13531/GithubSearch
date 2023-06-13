public struct StarredListModel: Sendable, Decodable, Equatable {
  public var fullname: String
  enum CodingKeys: String, CodingKey {
    case fullname = "full_name"
  }
}
