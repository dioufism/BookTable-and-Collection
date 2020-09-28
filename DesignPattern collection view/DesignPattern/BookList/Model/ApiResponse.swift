//
//  ApiResponse.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/18/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

import Foundation

//API response gives us raw keys to solve that problem we have a codingKeys enums taht will help us bridge that gap
struct ApiResponse: Decodable {
    var bookKind: String?
    var totalItems: Int?
    var items: [ItemInfo]?
    
    enum CodingKeys: String, CodingKey { // if keys are the same we do no need to assing the cases with thw core
        case bookKind = "kind"
        case totalItems
        case items
    }
}

struct ItemInfo: Decodable {
    var itemKind: String?
    var itemId: String?
    var eTag: String?
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    //var saleInfo: ?
    var accessInfo: AccessInfo?
    //var searchInfo: ?
    
    enum codingKeys: String, CodingKey {
        case itemKind = "kind"
        case ItemId = "id"
        case eTag = "etag"
        case selfLink
        case volumeInfo
        case accessInfo
        
    }
}

struct VolumeInfo: Decodable {
    var title: String?
    var subTitle: String?
    var authors: [String]?
    var publisher: String?
    var publisherDate: String?
    var description: String?
    //var industryIdentifiers: []?
    //var readingModes:?
    var pageCount: Int?
    var printType: String?
    //var categories: []?
    var averageRating: Double?
    var ratingsCount: Int?
    var maturityRating: String?
    var contentVersion: String?
    //var panelizationSummary:?
    var imageLinks: ImageLinks?
    var language: String?
    var previewLink: String?
    var infoLink: String?
    var canonicalVolumeLink: String?
    
    enum codingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case authors
        case publisher
        case publisherDate
        case description
        case pageCount
        case printType
        case averageRating
        case ratingsCount
        case maturityRating
        case contentVersion
        case imageLinks
        case language
        case previewLinks
        case infoLink
        case canonicalVolumeLink
    }
}

struct ImageLinks: Decodable {
    var smallThumbnail: String?
    var thumbNail: String?
    
    enum CodinKeys: String, CodingKey {
        case smallThumbnail
        case thumbNail
    }
}

struct AccessInfo: Decodable {
    var pdfInfo: PdfInfo?
    var webReaderLink: String
    
    enum codingKeys: String, CodingKey {
        case pdfInfo
        case webReaderLink
    }
}

struct PdfInfo: Decodable {
    var acsTokenLink: String?
    
    enum codingKeys: String, CodingKey {
        case acsTokenLink
        
    }
}
