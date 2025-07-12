//
//  HomeViewModel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import Foundation

protocol HomeViewModelDelegate{
    var newsListPublisher: Published<[NewsData]>.Publisher {get}
    var attractionsListPublisher: Published<[AttractionData]>.Publisher {get}
    
    func getNextNews()
    func getNextAttractions()
}

class HomeViewModel: HomeViewModelDelegate{
    @Published var newsList: [NewsData]
    @Published var attractionsList: [AttractionData]
    
    var newsListPublisher: Published<[NewsData]>.Publisher { $newsList}
    var attractionsListPublisher: Published<[AttractionData]>.Publisher { $attractionsList}
    
    var newsPage: Int
    var attractionPage: Int
    
    init(){
        newsPage = 1
        attractionPage = 1
        
        newsList = []
        attractionsList = []
        
        Task{
            await getAllInfos()
        }
    }
    
    func getAllInfos() async{
        let dateTuple = getDate()
        
        do{
            async let newsRes = NetworkService.shared.getNews(begin: dateTuple.begin, end: dateTuple.end, page: newsPage)
            async let attractionsRes = NetworkService.shared.getAllAttractions(page: attractionPage)
            
            newsList = try await newsRes
            attractionsList = try await attractionsRes
        }catch{
            print(error)
        }
    }
    
    func getNextNews(){
        let dateTuple = getDate()
        
        newsPage += 1
        
        Task{
            newsList = try await NetworkService.shared.getNews(begin: dateTuple.begin, end: dateTuple.end, page: newsPage)
        }
    }
    
    func getNextAttractions(){
        attractionPage += 1
        
        Task{
            attractionsList = try await NetworkService.shared.getAllAttractions(page: attractionPage)
        }
    }
    
    private func getDate()->(begin:Date, end:Date){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zhtw")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let begin = dateFormatter.date(from: "2001/01/01") ?? Date()
        let end = Date()
        
        return (begin,end)
    }
    
}
