//
//  CoreDataManager.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation

import CoreData

class CoreDataManager{
    
    private let container : NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "theMovieDB")
        setUpDatabase()
    }
    
    private func setUpDatabase() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) - \(error)")
                return
            }
            print("Database ready!")
        }
    }
    
    func createFavorite(
        showSeleccionado: String,
        uid_user: String, completion:@escaping() -> Void){
            
            let context = container.viewContext
            
            let favorites = FavoritosEnt(context: context)
            favorites.showSeleccionado = showSeleccionado
            favorites.uid_user = uid_user
            
            do {
                try context.save()
                print("Peli favorita guardada \(showSeleccionado)")
                completion()
            } catch {
                print("Error al guardar favoritos - \(error)")
            }
        }
    
    func getFavorites() -> [FavoritosEnt]{
        let getRequest : NSFetchRequest<FavoritosEnt> = FavoritosEnt.fetchRequest()
        do {
            let result = try container.viewContext.fetch(getRequest)
            return result
        } catch {
            print("Error al obtener todos los Favoritos \(error)")
        }
        
        return []
    }
    
    func getFavorites(queryUidUser: String) -> [FavoritosEnt]{
        let getRequest : NSFetchRequest<FavoritosEnt> = FavoritosEnt.fetchRequest()
        getRequest.predicate = NSPredicate(format: "uid_user == %@", queryUidUser)
        do {
            let result = try container.viewContext.fetch(getRequest)
            return result
        } catch {
            print("Error al obtener Favoritos por uidUser \(error)")
        }
        
        return []
    }
    
    func getFavorites(queryIdMovie: String) -> [FavoritosEnt]{
        let getRequest : NSFetchRequest<FavoritosEnt> = FavoritosEnt.fetchRequest()
        getRequest.predicate = NSPredicate(format: "showSeleccionado == %@", queryIdMovie)
        do {
            let result = try container.viewContext.fetch(getRequest)
            return result
        } catch {
            print("Error al obtener Favoritos por id movie \(error)")
        }
        
        return []
    }
    
    func deleteFavorites(arrayMovies: Array<ResultMovies>) {
        
        let context = container.viewContext
        let person =  arrayMovies[0] as! NSManagedObject
         
        context.delete(person)
         
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
        
    }
}
