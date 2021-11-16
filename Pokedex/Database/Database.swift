//
//  Database.swift
//  Pokedex
//
//  Created by Cotellessa, Gianmarco on 15/11/21.
//

import Foundation

import GRDB
import Combine
import UIKit

final class Database {
    
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    private let dbWriter: DatabaseWriter
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("createPokemon") { db in
            try db.create(table: "pokemon") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("height", .integer).notNull()
                t.column("weight", .integer).notNull()
                t.column("sprites", .text).notNull()
                t.column("types", .text).notNull()
                t.column("stats", .text).notNull()
                t.column("moves", .text).notNull()
            }
        }
        
        return migrator
    }
}

// MARK: - Database Access: Writes

extension Database {
    
    private static var cancellables = Set<AnyCancellable>()
    
    func savePokemons(_ pokemons: inout [Pokemon]) throws {
        for var pokemon in pokemons {
            let images = ["frontDefault" : pokemon.sprites.frontDefault,
                          "backDefault" : pokemon.sprites.backDefault,
                          "frontShiny" : pokemon.sprites.frontShiny,
                          "backShiny" : pokemon.sprites.backShiny]
            
            images.forEach { image in
                UIImage.fetchImageData(urlString: image.value ?? "") { dataString in
                    switch image.key {
                    case "frontDefault":
                        pokemon.sprites.frontDefault = dataString
                    case "backDefault":
                        pokemon.sprites.backDefault = dataString
                    case "frontShiny":
                        pokemon.sprites.frontShiny = dataString
                    case "backShiny":
                        pokemon.sprites.backShiny = dataString
                    default:
                        break
                    }
                    
                    try? self.dbWriter.write { db in
                        try? pokemon.save(db)
                    }
                }
            }
        }
    }
    
    func cleanAllPokemonsList() throws {
        try dbWriter.write { db in
            _ = try Pokemon.deleteAll(db)
        }
    }

    func fetchPokemons() throws -> [Pokemon] {
        try dbWriter.read { db in
            return try Pokemon.fetchAll(db)
        }
    }
    
    func fetchCount() throws -> Int {
        try dbWriter.write { db in
            return try Pokemon.fetchCount(db)
        }
    }
    
}

extension Database {

    static let shared = makeShared()
    
    private static func makeShared() -> Database {
        do {
            let fileManager = FileManager()
            let folderURL = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("database", isDirectory: true)
            print(folderURL)
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            
            let dbURL = folderURL.appendingPathComponent("db.sqlite")
            let dbPool = try DatabasePool(path: dbURL.path)
            
            let appDatabase = try Database(dbPool)
            
            return appDatabase
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}
