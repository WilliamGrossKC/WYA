import Vapor
import MongoKitten

// struct Pin: Content {
//     var _id: UUID
//     var location: [Double] // Storing CGPoint as an array of [x, y]
//     var time: Date?

//     // Initialization
//     init(id: UUID = UUID(), location: CGPoint, time: Date? = nil) {
//         self._id = id
//         self.location = [Double(location.x), Double(location.y)] // Storing CGPoint as [Double]
//         self.time = time
//     }
// }

struct User: Content {
    var id: ObjectId?
    var username: String
    var email: String
}