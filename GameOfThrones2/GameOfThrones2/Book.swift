//
//  Book.swift
//  GameOfThrones2
//
//  Created by Ana Ma on 12/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum BookModelParseError: Error {
    case dict
    case array
    case url
    case name
    case isbn
    case authors
    case numberOfPages
    case publisher
    case mediaType
    case released
    case characters
    case povCharacters
}

class Book {
    var url: String
    var name: String
    var isbn: String
    var authors: [String]
    var numberOfPages: Int
    var publisher: String
    var mediaType: String
    var released: String
    var characters: [String]
    var povCharacters: [String]?
    
    init(url: String, name: String, isbn: String, authors: [String], numberOfPages: Int, publisher: String, mediaType: String, released: String, characters: [String], povCharacters: [String]?) {
        self.url = url
        self.name = name
        self.isbn = isbn
        self.authors = authors
        self.numberOfPages = numberOfPages
        self.publisher = publisher
        self.mediaType = mediaType
        self.released = released
        self.characters = characters
        self.povCharacters = povCharacters
    }
    
    convenience init? (dict: [String: AnyObject]){
        if let url = dict["url"] as? String,
            let name = dict["name"] as? String,
            let isbn = dict["isbn"] as? String,
            let authors = dict["authors"] as? [String],
            let numberOfPages = dict["numberOfPages"] as? Int,
            let publisher = dict["publisher"] as? String,
            let mediaType = dict["mediaType"] as? String,
            let released = dict["released"] as? String,
            let characters = dict["characters"] as? [String]{
            let povCharacters = dict["povCharacters"] as? [String]
            self.init(url: url, name: name, isbn: isbn, authors: authors, numberOfPages: numberOfPages, publisher: publisher, mediaType: mediaType, released: released, characters: characters, povCharacters: povCharacters)
        } else {
            return nil
        }

//        guard let url = dict["url"] as? String else {
//            print(BookModelParseError.url)
//            return
//        }
//        guard let name = dict["name"] as? String else {
//            print(BookModelParseError.name)
//            return
//        }
//        guard let isbn = dict["isbn"] as? String else {
//            print(BookModelParseError.isbn)
//            return
//        }
//        guard let authors = dict["authors"] as? [String] else {
//            print(BookModelParseError.authors)
//            return
//        }
//        guard let numberOfPages = dict["numberOfPages"] as? Int else {
//            print(BookModelParseError.numberOfPages)
//            return
//        }
//        guard let publisher = dict["publisher"] as? String else {
//            print(BookModelParseError.publisher)
//            return
//        }
//        guard let mediaType = dict["mediaType"] as? String else {
//            print(BookModelParseError.mediaType)
//            return
//        }
//        guard let released = dict["released"] as? String else {
//            print(BookModelParseError.released)
//            return
//        }
//        guard let characters = dict["characters"] as? [String] else {
//            print(BookModelParseError.characters)
//            return
//        }
//        guard let povCharacters = dict["povCharacters"] as? [String] else {
//            print(BookModelParseError.povCharacters)
//            return
//        }
//        self.init(url: url, name: name, isbn: isbn, authors: authors, numberOfPages: numberOfPages, publisher: publisher, mediaType: mediaType, released: released, characters: characters, povCharacters: povCharacters)

        /* convenience init?(withDict dict: [String:Any]) {
            if let name = dict["name"] as? String,
                let season = dict["season"] as? Int,
                let number = dict["number"] as? Int,
                let airdate = dict["airdate"] as? String,
                let summary = dict["summary"] as? String
            {
                self.init(name: name, season: season, number: number, airdate: airdate, summary: summary)
            }
            else {
                return nil
            }
        }*/
        
        //MAY be helpful getting rid of <\p>
        //summary.text = unwrappedEpisode.summary.replacingOccurrences(of: "<[^>]+>", with: "\n", options: .regularExpression, range: nil) // same. it's like christmas up in here
    }
    
    static func getBooks(data: Data) -> [Book]? {
        var books: [Book] = []
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let array = json as? [[String: AnyObject]] else {
            throw BookModelParseError.array
        }
        array.forEach { (dict) in
            guard let validBook = Book.init(dict: dict) else { return }
                books.append(validBook)
            }
        }
        catch {
            print(error)
        }
        return books
    }

}
