//
////  MongoDbConnection.swift
////  WYA
////
////  Created by William Gross on 10/1/24.
////
//
//import Foundation
//import MongoSwiftSync
//
//func connectToMongoDB() {
//    defer {
//        // Clean up the driver resources at the end of the application
//        cleanupMongoSwift()
//    }
//    
//    do {
//        // Connect to MongoDB at the default URI (localhost:27017)
//        let client = try MongoClient(
//            "mongodb+srv://wgross769:yFArsKJ3DF4w9aF5@clusterwya.w0pod.mongodb.net/?retryWrites=true&w=majority&appName=ClusterWYA"
//        )
//        
//        // Access a database and collection
//        let database = client.db("ClusterWYA")
//        let collection = try database.createCollection("myCollection")
//        
//        // Create a document
//    } catch {
//        print("Error occurred: \(error)")
//    }
//}
