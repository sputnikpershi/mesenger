//
//  NetworkServiceTwo.swift
//  Navigation
//
//  Created by Kiryl Rakk on 7/11/22.
//

import Foundation
/*
{
    "name": "Tatooine",
    "rotation_period": "23",
    "orbital_period": "304",
    "diameter": "10465",
    "climate": "arid",
    "gravity": "1 standard",
    "terrain": "desert",
    "surface_water": "1",
    "population": "200000",
    "residents": [
        "https://swapi.dev/api/people/1/",
        "https://swapi.dev/api/people/2/",
    ],
 
 // RESIDENT
 {
     "name": "Owen Lars",
     "height": "178",
     "mass": "120",
     "hair_color": "brown, grey",
*/


struct Resident: Decodable {
    var name: String
}

struct PlanetAnswer: Decodable {
    var name : String
    var rotation_period : String
    var orbital_period : String
    var residents: [String]
}

