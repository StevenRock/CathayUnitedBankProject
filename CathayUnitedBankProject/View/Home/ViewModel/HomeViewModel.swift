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
    var urlPublisher: Published<URL?>.Publisher {get}
    
    func getNextNews()
    func getNextAttractions()
    func getSelectedNewsData(_ data: NewsData)
    func getSelectedAttractionData(_ data: AttractionData)
    func selectLanguage(_ language: Language)
}

class HomeViewModel: HomeViewModelDelegate{

    
    @Published var newsList: [NewsData]
    @Published var attractionsList: [AttractionData]
    @Published var url: URL?
    
    var newsListPublisher: Published<[NewsData]>.Publisher { $newsList}
    var attractionsListPublisher: Published<[AttractionData]>.Publisher { $attractionsList}
    var urlPublisher: Published<URL?>.Publisher {$url}
    
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

        Task{
            newsList = try await NetworkService.shared.getNews(begin: dateTuple.begin, end: dateTuple.end, page: newsPage)
            newsPage += 1
        }
    }
    
    func getNextAttractions(){
        
        Task{
            attractionsList = try await NetworkService.shared.getAllAttractions(page: attractionPage)
            attractionPage += 1
        }
    }
    
    func getSelectedNewsData(_ data: NewsData){
        let urlStr = data.url
        url = URL(string: urlStr)
    }
    
    func getSelectedAttractionData(_ data: AttractionData){
        
    }
    
    func selectLanguage(_ language: Language) {
        LanguageManager.shared.setLang(language) {
            Task{
                await self.getAllInfos()
            }
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
