//
//  Character.swift
//  GameOfThrones2
//
//  Created by Ana Ma on 12/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum CharacterModelParseError: Error {
    case dict
    case validCharacters
}

class Character {
    var url: String
    var name: String
    var gender: String
    var culture: String
    var born: String
    var died: String
    var titles: [String]
    var aliases: [String]
    var father: String
    var mother: String
    var spouse: String
    var allegiances: [String]
    var books: [String]
    var tvSeries: [String]
    var playedBy: [String]
    
    init(url: String, name: String, gender: String, culture: String, born: String, died: String, titles: [String], aliases: [String], father: String, mother: String, spouse: String, allegiances: [String], books: [String], tvSeries: [String], playedBy: [String]) {
        self.url = url
        self.name = name
        self.gender = gender
        self.culture = culture
        self.born = born
        self.died = died
        self.titles = titles
        self.aliases = aliases
        self.father = father
        self.mother = mother
        self.spouse = spouse
        self.allegiances = allegiances
        self.books = books
        self.tvSeries = tvSeries
        self.playedBy = playedBy
    }
    
    convenience init? (dict: [String: AnyObject]) {
        if let url = dict["url"] as? String,
            let name = dict["name"] as? String,
            let gender = dict["gender"] as? String,
            let culture = dict["culture"] as? String,
            let born = dict["born"] as? String,
            let died = dict["died"] as? String,
            let titles = dict["titles"] as? [String],
            let aliases = dict["aliases"] as? [String],
            let father = dict["father"] as? String,
            let mother = dict["mother"] as? String,
            let spouse = dict["spouse"] as? String,
            let allegiances = dict["allegiances"] as? [String],
            let books = dict["books"] as? [String],
            let tvSeries = dict["tvSeries"] as? [String],
            let playedBy = dict["playedBy"] as? [String] {
            self.init(url: url, name: name, gender: gender, culture: culture, born: born, died: died, titles: titles, aliases: aliases, father: father, mother: mother, spouse: spouse, allegiances: allegiances, books: books, tvSeries: tvSeries, playedBy: playedBy)
        }
        else {
            return nil
        }
    }
    
    static func getCharacter(data:Data) -> Character? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dict = json as? [String: AnyObject] else {
                throw CharacterModelParseError.dict
            }
            guard let validCharacters = Character.init(dict: dict) else {
                throw CharacterModelParseError.validCharacters
            }
            return validCharacters
        }
        catch {
            print(error)
        }
        return nil
    }    
}
/*
 "url": "http://www.anapioficeandfire.com/api/characters/1274",
 "name": "Cleon",
 "gender": "Male",
 "culture": "Astapori",
 "born": "",
 "died": "In 300 AC, at Astapor",
 "titles": [
 "King of Astapor"
 ],
 "aliases": [
 "Cleon the Great",
 "The Butcher King",
 "King Cleaver"
 ],
 "father": "",
 "mother": "",
 "spouse": "",
 "allegiances": [],
 "books": [
 "http://www.anapioficeandfire.com/api/books/3",
 "http://www.anapioficeandfire.com/api/books/5",
 "http://www.anapioficeandfire.com/api/books/8"
 ],
 */
