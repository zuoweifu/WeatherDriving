import Foundation

class PSSGraphData: Codable {
    var points: [PSSGraphDataPoint]?
}

extension PSSGraphData {
    enum CodingKeys: String, CodingKey {
        case points = "Points"
    }
}
