import Vapor
import MongoKitten

func createUserHandler(req: Request) throws -> EventLoopFuture<Response> {
    let user = try req.content.decode(User.self)
    let mongoClient = req.application.storage.get(MongoClient.self)!
    let database = mongoClient.db("myDatabase")
    let usersCollection = database.collection("users")

    return usersCollection.insertEncoded(user).flatMap { _ in
        return req.eventLoop.makeSucceededFuture(req.response(status: .ok))
    }
}

func getUserHandler(req: Request) throws -> EventLoopFuture<User> {
    let id = try req.parameters.require("id", as: ObjectId.self)
    let mongoClient = req.application.storage.get(MongoClient.self)!
    let database = mongoClient.db("myDatabase")
    let usersCollection = database.collection("users")

    return usersCollection.findOne(where: "_id" == id).decode(User.self)
}
