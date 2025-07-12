//
//  NetworkStructure.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/10.
//

import Foundation

struct Attractions: Codable{
    let total: Int
    let data: [AttractionData]
}

struct AttractionData: Hashable, Codable {
    let id: Int
    let name: String
    let nameZh: String? //name_zh
    let openStatus: Int //open_status
    let introduction: String
    let openTime: String //open_time
    let zipCode: String //zipcode
    let distric: String
    let address: String
    let tel: String
    let fax: String
    let email: String
    let months: String
    let nLat: Double //nlat
    let eLong: Double //elong
    let officialSite: String //official_site
    let facebook: String
    let ticket: String
    let remind: String
    let staytime: String
    let modified: String
    let url: String
    let category: [Category]
    let target: [Category]
    let service: [Category]
    let friendly: [Category]
    let images: [Image]?
    let files: [AttractionFile]
    let links: [Link]
    
    enum CodingKeys: String, CodingKey {
        case id,name,introduction,distric,address,tel,fax,email,months,facebook,ticket,remind,staytime,modified,url,category,target,service,friendly,images,files,links
        case nameZh = "name_zh"
        case openStatus = "open_status"
        case openTime = "open_time"
        case zipCode = "zipcode"
        case nLat = "nlat"
        case eLong = "elong"
        case officialSite = "official_site"
    }
}

struct News: Codable{
    let total: Int
    let data: [NewsData]
}

struct NewsData: Hashable, Codable{
    let id: Int
    let title: String
    let description: String
    let begin: String?
    let end: String?
    let posted: String
    let modified: String
    let url: String
    let files: [AttractionFile]
    let links: [Link]
}

struct Activities: Codable{
    let total: Int
    let data: [ActivityData]
}

struct ActivityData: Codable{
    let district: String
    let address: String
    let nLat: String //nlat
    let eLong: String //elong
    let organizer: String
    let coOrganizer: String //co_rganizer
    let contact: String
    let tel: String
    let fax: String
    let ticket: String
    let traffic: String
    let parking: String
    let id: Int
    let title: String
    let description: String
    let begin: String
    let end: String
    let posted: String
    let modified: String
    let url: String
    let files: [AttractionFile]
    let links: [Link]
    
    enum CodingKeys: String, CodingKey {
        case district,address,organizer,contact,tel,fax,ticket,traffic,parking,id,title,description,begin,end,posted,modified,url,files,links
        case nLat = "nlat"
        case eLong = "elong"
        case coOrganizer = "co_rganizer"
    }
}

struct CalendarData: Codable{
    let district: String
    let address: String
    let nLat: String //nlat
    let eLong: String //elong
    let tel: String
    let fax: String
    let ticket: String
    let traffic: String
    let parking: String
    let isMajor: Bool //is_major
    let id: Int
    let title: String
    let description: String
    let begin: String
    let end: String
    let posted: String
    let modified: String
    let url: String
    let files: [AttractionFile]
    let links: [Link]
    
    enum CodingKeys: String, CodingKey {
        case district,address,tel,fax,ticket,traffic,parking,id,title,description,begin,end,posted,modified,url,files,links
        case nLat = "nlat"
        case eLong = "elong"
        case isMajor = "is_major"
    }
}

struct Audio: Codable{
    let id: Int
    let title: String
    let summary: String
    let modified: String
    let url: String
    let fileExt: String //file_ext
    
    enum CodingKeys: String, CodingKey {
        case id,title,summary,modified,url
        case fileExt = "file_ext"
    }
}

struct Tour: Codable{
    let id: Int
    let seasonsRaw: String
    let monthsRaw: String
    let seasons: String
    let months: String
    let days: String
    let title: String
    let author: String
    let descripion: String
    let consume: String
    let remark: String
    let note: String
    let url: String
    let category: [Category]
    let transport: [Category]
    let users: [Category]
    let modified: String
    let files: [AttractionFile]
}

struct Category: Hashable, Codable {
    let id: Int
    let name: String
}

struct Image: Hashable, Codable {
    let src: String
    let subject: String
    let ext: String
}

struct AttractionFile: Hashable, Codable{
    let src: String
    let subject: String
    let ext: String
}

struct Link: Hashable, Codable{
    let src: String
    let subject: String
}
