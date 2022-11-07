//
//  AppConstant.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation

struct AppConstant {
   
    
    //develop
    static let HOST:String = "https://api.themoviedb.org/3/"
    static let HOST_MEDIA:String = "https://image.tmdb.org/t/p/original/"
    static let API_KEY:String = "101c77c5a1d21a36d6a86d4fe9c0ac78"
    static let LANG:String = "language=es-ES"
    
    
    static let keyGoogleMap = "AIzaSyAq_kOASYECf0qX1QW1Bhnio41z5dM3YUw"
    static let dirFolioLicencia:String = "static/images/assets/folio_ayuda.jpg"
    static let methodLogin = "usuarios/usuarios/login"
    //    static let methodObtenerLicencia = "licencia/licencia/getlicencia"
    static let methodValidarLicencia = "licencia/licencias/validar"
    static let methodRegistroUsuario = "usuarios/usuarios/registro"
    static let methodCerrarSesion = "usuarios/usuarios/logout"
    static let methodObtenerMultas = "infracciones/infracciones"
}
struct defaultKeys{
    static let id_movie = "id_movie"
    static let favorite = "favorite"
    
}

enum categoryName: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case OnTV = "on_the_air"
    case AiringToday = "airing_today"
}
enum showsType : String {
    case TV = "tv"
    case Movie = "movie"
}

enum clasification : String {
    case Adult = "18+"
    case Todos = "TODOS"
}

enum imageFavorite : String {
    case IsFavorite = "heart.fill"
    case IsNotFavorite = "heart"
}
