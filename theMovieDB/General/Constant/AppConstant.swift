//
//  AppConstant.swift
//  theMovieDB
//
//  Created by Salma Garcia on 06/11/22.
//

import Foundation

struct AppConstant {
   
    static let HOST:String = "https://api.themoviedb.org/3/"
    static let HOST_MEDIA:String = "https://image.tmdb.org/t/p/original/"
    static let API_KEY:String = "?api_key=101c77c5a1d21a36d6a86d4fe9c0ac78"
    static let LANG:String = "&language=es-ES"
    
    static let video = "/videos"
    
    //Strings
    static let errorMessage = "Upss, Algo salio mal :("
    static let minutos = "MINS"
    static let what_do_you_want_to_do = "¿What do you want to do?"
    static let view_profile = "View Profile"
    static let log_out = "Log out"
    static let log_in = "Log in"
    static let cancelar = "Cancel"
    static let cargando = "Cargando..."
    static let title_navbar = "TV Shows"
    static let init_code_message = "init(coder:) has not been implemented"
    static let password = "Password"
    static let username = "Username"
    static let campos_vacios_message = "Los campos no pueden estar vacios"
    static let profile_text = "Profile"
    static let favorite_text = "Favorites"
    static let image_profile = "profileA"
    
    static let colleccionViewCellMovies = "CollectionViewCellMovies"
    static let colleccionViewCellVideos = "CollectionViewCellVideo"
    static let colleccionViewCompanies = "CollectionViewCellCompanies"
    
    
    
    static let icono_menu = "line.3.horizontal"
    static let icono_heart = "heart"
    static let icono_star_fill = "star.fill"
    static let icono_play = "play.fill"
    static let icono_login = "login"
    
    static let font_helvetica_bold = "Helvetica Neue Bold"
    static let font_helvetica = "Helvetica Neue"
}
struct defaultKeys{
    static let id_movie = "id_movie"
    static let favorite = "favorite"
    static let segmento = "segmento"
    static let is_tv_or_movie = "is_tv_or_movie"
    static let email = "email"
    static let uid = "uid"
    static let arrayFavorites = "arrayFavorites"
    static let indexTouch = "indexTouch"
    
}

enum categoryName: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case OnTV = "on_the_air"
    case AiringToday = "airing_today"
}
enum showsType : String {
    case TV = "tv/"
    case Movie = "movie/"
}

enum segmentosType : Int {
    case Popular = 0
    case TopRates = 1
    case OnTV = 2
    case AiringToday = 3
}

enum clasification : String {
    case Adult = "18+"
    case Todos = "TODOS"
}

enum imageFavorite : String {
    case IsFavorite = "heart.fill"
    case IsNotFavorite = "heart"
}

enum accionFavoritos : String {
    case guardarFav = "GuardarFav"
    case eliminarFav = "EliminarFav"
}
