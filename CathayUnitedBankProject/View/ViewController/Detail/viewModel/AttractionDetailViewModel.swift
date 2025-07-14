//
//  AttractionDetailViewModel.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/14.
//

import Foundation

protocol AttractionDetailViewModelDelegate: CoordinatorDelegate {
    var namePublisher: Published<String>.Publisher { get }
    var timePublisher: Published<String>.Publisher { get }
    var telPublisher: Published<String>.Publisher { get }
    var addressPublisher: Published<String>.Publisher { get }
    var descriptionPublisher: Published<String>.Publisher { get }
    var webPublisher: Published<String>.Publisher { get }
    var slidersPublisher: Published<[(URL?, Int)]>.Publisher {get}
    
    func goWeb()
}

class AttractionDetailViewModel: AttractionDetailViewModelDelegate {
    @Published var viewController: BaseViewController?
    @Published var name: String
    @Published var time: String
    @Published var tel: String
    @Published var address: String
    @Published var description: String
    @Published var web: String
    @Published var sliders: [(URL?, Int)]
    
    var namePublisher: Published<String>.Publisher { $name}
    var timePublisher: Published<String>.Publisher { $time}
    var telPublisher: Published<String>.Publisher { $tel}
    var addressPublisher: Published<String>.Publisher { $address}
    var descriptionPublisher: Published<String>.Publisher { $description}
    var webPublisher: Published<String>.Publisher { $web}
    var slidersPublisher: Published<[(URL?, Int)]>.Publisher { $sliders}
    
    var vcPublisher: Published<BaseViewController?>.Publisher { $viewController }
    
    var urlString: String
    var theName: String
    
    init(data: AttractionData){
        self.urlString = data.url
        self.theName = data.name
        
        self.time = data.openTime
        self.name = data.name
        self.tel = data.tel
        self.address = data.address
        self.description = data.introduction
        self.web = data.url
        
        self.sliders = []
        self.parseSliders(data.images)
    }
    
    private func parseSliders(_ slidersData: [Image]?){
        guard let slidersData else { return }
        
        var tuple: [(URL?, Int)] = []
        slidersData.enumerated().forEach { (index, image) in
            let url = URL(string: image.src)
            tuple.append((url, index))
        }
        
        sliders = tuple
    }
    
    func goWeb() {
        guard let url = URL(string: urlString) else { return }
        viewController = Coordinator.shared.prepareWebViewController(url: url, title: theName)
    }
    
}
