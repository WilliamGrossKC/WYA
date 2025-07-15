import Vapor

public func routes(_ app: Application) throws {
    app.post("user", use: createUserHandler)
    app.get("user", ":id", use: getUserHandler)
}