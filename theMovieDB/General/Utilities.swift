//
//  Utilities.swift
//  theMovieDB
//
//  Created by Salma Garcia on 07/11/22.
//

import Foundation
import UIKit

class Utilities {
    private let manager = CoreDataManager()
    func changeEstateButtonFavorite () -> (String?, String?, Int?){
        let defaults = UserDefaults.standard
        let idMovie = defaults.integer(forKey: defaultKeys.id_movie)
        let ifFavorite = manager.getFavorites(queryIdMovie: String(idMovie))
        
        if ifFavorite.count >= 1 {
            //Guardar en favoritos
            return (imageFavorite.IsFavorite.rawValue, accionFavoritos.guardarFav.rawValue, idMovie)
           
        } else {
            //Eliminar de favoritos
            return (imageFavorite.IsNotFavorite.rawValue, accionFavoritos.eliminarFav.rawValue, idMovie)
        }
    }
    
    func getCategoryAndShowType(category: Int) -> (String, String){
        switch category {
        case 0:
            return (categoryName.Popular.rawValue, showsType.Movie.rawValue)
            break
        case 1:
            return (categoryName.TopRated.rawValue, showsType.Movie.rawValue)
            break
        case 2:
            return (categoryName.OnTV.rawValue, showsType.TV.rawValue)
            break
        case 3:
            return (categoryName.AiringToday.rawValue, showsType.TV.rawValue)
            break
        default:
            return (categoryName.Popular.rawValue, showsType.Movie.rawValue)
        }
    }

}


