import Vapor
import MongoKitten
import Network

// Define a key to store MongoClient in Vapor's storage
struct MongoClientKey: StorageKey {
    typealias Value = MongoDatabase  // Use MongoKitten.MongoClient as the type
}

public func configure(_ app: Application) throws {

    // MongoDB connection string (replace <db_password> with your actual password)
    let client = try MongoKitten.MongoClient(
        "mongodb+srv://wgross769:yFArsKJ3DF4w9aF5@clusterwya.w0pod.mongodb.net/?retryWrites=true&w=majority&appName=ClusterWYA"
    )

    // Access the specific database you want to work with
    let database = client["myDatabase"]

    // Store the MongoClient in Vapor's application storage
     app.storage.set(MongoClientKey.self, to: database)

    // Register routes
    try routes(app)
}