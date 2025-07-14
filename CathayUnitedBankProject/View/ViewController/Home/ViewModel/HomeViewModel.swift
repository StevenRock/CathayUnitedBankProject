//
//  HomeViewModel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin on 2025/7/11.
//

import Foundation

protocol HomeViewModelDelegate: CoordinatorDelegate{
    var newsListPublisher: Published<[NewsData]>.Publisher {get}
    var attractionsListPublisher: Published<[AttractionData]>.Publisher {get}
    
    func getNextNews()
    func getNextAttractions()
    func getSelectedNewsData(_ data: NewsData)
    func getSelectedAttractionData(_ data: AttractionData)
    func selectLanguage(_ language: Language)
}

class HomeViewModel: HomeViewModelDelegate{
    @Published var viewController: BaseViewController?
    @Published var newsList: [NewsData]
    @Published var attractionsList: [AttractionData]
    
    var newsListPublisher: Published<[NewsData]>.Publisher { $newsList}
    var attractionsListPublisher: Published<[AttractionData]>.Publisher { $attractionsList}    
    var vcPublisher: Published<BaseViewController?>.Publisher{ $viewController }
    
    var totalNewsList: [NewsData] = []
    var totalAttractionsList: [AttractionData] = []
    
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
        newsPage = 1
        attractionPage = 1
        
        do{
            async let newsRes = NetworkService.shared.getNews(begin: dateTuple.begin, end: dateTuple.end, page: newsPage)
            async let attractionsRes = NetworkService.shared.getAllAttractions(page: attractionPage)
            
            totalNewsList += try await newsRes
            totalAttractionsList += try await attractionsRes
            
            newsList = totalNewsList
            attractionsList = totalAttractionsList
        }catch{
            print(error)
        }
    }
    
    func getNextNews(){
        let dateTuple = getDate()

        Task{
            newsPage += 1
            totalNewsList += try await NetworkService.shared.getNews(begin: dateTuple.begin, end: dateTuple.end, page: newsPage)
            
            newsList = totalNewsList
        }
    }
    
    func getNextAttractions(){
        
        Task{
            attractionPage += 1
            totalAttractionsList = try await NetworkService.shared.getAllAttractions(page: attractionPage)
            
            attractionsList = totalAttractionsList
        }
    }
    
    func getSelectedNewsData(_ data: NewsData){
        let urlStr = data.url
        guard let url = URL(string: urlStr) else { return }
        viewController = Coordinator.shared.prepareWebViewController(url: url)
    }
    
    func getSelectedAttractionData(_ data: AttractionData){
        viewController = Coordinator.shared.prepareAttractionViewCOntroller(data: data)
    }
    
    func selectLanguage(_ language: Language) {
        LanguageManager.shared.setLang(language) {
            Task{
                self.totalNewsList.removeAll()
                self.totalAttractionsList.removeAll()
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
