//
//  SlideshowView.swift
//  CathayUnitedBankProject
//
//  Created by Steven Lin Macmini on 2025/7/13.
//

import UIKit
import Kingfisher

class SlideshowView: UIView{
    var source: [URL]{
        didSet{
            setScrollContent(imgs: source)
        }
    }
    
    lazy var pageControl: UIPageControl = {
        let v = UIPageControl()
        v.numberOfPages = 0
        v.currentPage = 0
        v.tintColor = .blue
        v.pageIndicatorTintColor = .gray
        v.currentPageIndicatorTintColor = .white
        v.backgroundStyle = .automatic
        v.addTarget(self, action: #selector(changePage), for: .valueChanged)
        v.translatesAutoresizingMaskIntoConstraints = false

        return v
    }()
    
    lazy var scrollView: UIScrollView = {
       let v = UIScrollView()
        v.isPagingEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    var bannerStackView: UIStackView?
    
    var pageControlTimer: Timer?
    var bannerIndex = 0
    var bannerDidTapped: ((_ index: Int)->Void)?
    
    override init(frame: CGRect) {
        source = []
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        source = []
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = .black
        scrollView.delegate = self
        scrollView.backgroundColor = .white
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
            scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func changePage(){
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    private func setScrollContent(imgs: [URL]){
        bannerStackView?.removeFromSuperview()
        guard !imgs.isEmpty else { return }
        
        var tag = 0
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for img in imgs {
            tag += 1
            let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.frame.width, height: self.frame.height)))
            btn.kf.setImage(with: img, for: .normal)
            btn.tag = tag
            btn.imageView?.contentMode = .scaleAspectFill
            btn.addTarget(self, action: #selector(tapOnBanner), for: .touchUpInside)
            
            stack.addArrangedSubview(btn)
        }
        
        pageControl.numberOfPages = imgs.count
        
        scrollView.addSubview(stack)
        scrollView.contentSize.width = self.frame.width * CGFloat(imgs.count)
        scrollView.contentSize.height = 0
        scrollView.bounces = false
        
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            stack.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            stack.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            stack.topAnchor.constraint(equalTo: frameGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: frameGuide.bottomAnchor),
            stack.widthAnchor.constraint(equalToConstant: self.frame.width * CGFloat(imgs.count))
        ])
        
        bannerStackView = stack
        
        if pageControlTimer == nil{
            pageControlTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func scrollToNext(){
        bannerIndex += 1
        
        if bannerIndex == source.count{
            bannerIndex = 0
        }
        
        pageControl.currentPage = bannerIndex
        
        let x = CGFloat(bannerIndex) * scrollView.frame.width
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
        }
    }
    
    private func setOffset(scrollView: UIScrollView){
        let pageNum = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageNum)
        bannerIndex = Int(pageNum)
//        let x = CGFloat(pageNum) * scrollView.frame.width
//        UIView.animate(withDuration: 0.4, delay: 0) {
//            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
//        }
    }
    
    @objc private func tapOnBanner(_ sender: UIButton){
        bannerDidTapped?(sender.tag)
    }
}

extension SlideshowView: UIScrollViewDelegate{
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setOffset(scrollView: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        setOffset(scrollView: scrollView)
    }
}

