//
//  EntityFavorites.swift
//  theMovieDB
//
//  Created by Salma Garcia on 08/11/22.
//

import Foundation

struct Favorites: Codable {
    let showSeleccionado: String?
    let uid_user: String?
  

    enum CodingKeys: String, CodingKey {
        case showSeleccionado = "showSeleccionado"
        case uid_user = "uid_user"
    }
}
