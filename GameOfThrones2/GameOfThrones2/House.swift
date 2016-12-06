//
//  House.swift
//  GameOfThrones2
//
//  Created by Ana Ma on 12/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum HouseModelParseError: Error {
    case validJson
    case house
}

class House {
    var url: String
    var name: String
    var region: String
    var coatOfArms: String
    var words: String
    var titles: [String]
    var seats: [String]
    var currentLord: String
    var heir: String
    var overlord: String
    var founded: String
    var founder: String
    var diedOut: String
    var ancestralWeapons: [String]
    var cadetBranches: [String]
    var swornMembers: [String]
    
    init(url: String,
         name: String,
         region: String,
         coatOfArms: String,
         words: String,
         titles: [String],
         seats: [String],
         currentLord: String,
         heir: String,
         overlord: String,
         founded: String,
         founder: String,
         diedOut: String,
         ancestralWeapons: [String],
         cadetBranches: [String],
         swornMembers: [String]) {
        self.url = url
        self.name = name
        self.region = region
        self.coatOfArms = coatOfArms
        self.words = words
        self.titles = titles
        self.seats = seats
        self.currentLord = currentLord
        self.heir = heir
        self.overlord = overlord
        self.founded = founded
        self.founder = founder
        self.diedOut = diedOut
        self.ancestralWeapons = ancestralWeapons
        self.cadetBranches = cadetBranches
        self.swornMembers = swornMembers
    }
    
    convenience init? (dict: [String: AnyObject]) {
        if let url = dict["url"] as? String,
            let name = dict ["name"] as? String,
            let region = dict["region"] as? String,
            let coatOfArms = dict["coatOfArms"] as? String,
            let words = dict["words"] as? String,
            let titles = dict["titles"] as? [String],
            let seats = dict["seats"] as? [String],
            let currentLord = dict["currentLord"] as? String,
            let heir = dict["heir"] as? String,
            let overload = dict["overlord"] as? String,
            let founded = dict["founded"] as? String,
            let founder = dict["founder"] as? String,
            let diedOut = dict["diedOut"] as? String,
            let ancestralWeapons = dict["ancestralWeapons"] as? [String],
            let cadetBranches = dict["cadetBranches"] as? [String],
            let swornMembers = dict["swornMembers"] as? [String] {
            self.init(url: url, name: name, region: region, coatOfArms: coatOfArms, words: words, titles: titles, seats: seats, currentLord: currentLord, heir: heir, overlord: overload, founded: founded, founder: founder,diedOut: diedOut, ancestralWeapons: ancestralWeapons, cadetBranches: cadetBranches, swornMembers: swornMembers)
        } else {
            return nil
        }
    }
    
    static func getHouse(data: Data) -> House? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let validJson = json as? [String: AnyObject] else {
                throw HouseModelParseError.house
            }
            return House(dict: validJson)
        }
        catch {
            print(error)
        }
        return nil
    }
}
/*
 "url": "http://www.anapioficeandfire.com/api/houses/362",
 "name": "House Stark of Winterfell",
 "region": "The North",
 "coatOfArms": "A running grey direwolf, on an ice-white field",
 "words": "Winter is Coming",
 "titles": [
 "King in the North",
 "Lord of Winterfell",
 "Warden of the North",
 "King of the Trident"
 ],
 "seats": [
 "Scattered (formerly Winterfell)"
 ],
 "currentLord": "",
 "heir": "",
 "overlord": "http://www.anapioficeandfire.com/api/houses/16",
 "founded": "Age of Heroes",
 "founder": "http://www.anapioficeandfire.com/api/characters/209",
 "diedOut": "",
 "ancestralWeapons": [
 "Ice"
 ],
 "cadetBranches": [
 "http://www.anapioficeandfire.com/api/houses/170",
 "http://www.anapioficeandfire.com/api/houses/215"
 ],
 "swornMembers": [
 "http://www.anapioficeandfire.com/api/characters/2",
 "http://www.anapioficeandfire.com/api/characters/20",
 */
