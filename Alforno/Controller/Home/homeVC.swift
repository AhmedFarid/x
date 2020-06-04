//
//  homeVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class homeVC: UIViewController, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var offerTabelVIew: UITableView!
    @IBOutlet weak var bageControl: UIPageControl!
    @IBOutlet weak var countOFOffers: UILabel!
    
    var slider = [dataSlider]()
    var offers = [offfersData]()
    var timer : Timer?
    var currentIndex = 0
    var singleSection: offfersData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav(logo: true, menu: true, cart: true, back: false)
        setUpNavColore(false)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        offerTabelVIew.delegate = self
        offerTabelVIew.dataSource = self
        
        
        self.bannerCollectionView.register(UINib.init(nibName: "homeBannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.offerTabelVIew.register(UINib(nibName: "offerCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        sliderHandelRefresh()
        offersHandelRefresh()
        startTimer()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sliderHandelRefresh()
        offersHandelRefresh()
    }
    
    func sliderHandelRefresh(){
        homeApi.sliderApi{ (error,success,slider) in
            if let slider = slider{
                self.slider = slider.data ?? []
                print(slider)
                self.bageControl.numberOfPages = self.slider.count
                self.bageControl.currentPage = 0
                self.bannerCollectionView.reloadData()
            }
        }
    }
    
    func offersHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        homeApi.offersApi{ (error,success,offers) in
            if success {
                if let offers = offers{
                    self.offers = offers.data ?? []
                    print(offers)
                    self.countOFOffers.text = ("\(self.offers.count) Dishes")
                    self.offerTabelVIew.reloadData()
                    self.stopAnimating()
                }else {
                    self.stopAnimating()
                }
            }else {
               self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
            
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if currentIndex < slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
}

extension homeVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = offerTabelVIew.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? offerCell {
            cell.configureCell(offer: offers[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if offers[indexPath.row].wishlistState == 0 {
                cell.favBTN.setImage(UIImage(named: "Group 258"), for: .normal)
            }else {
                cell.favBTN.setImage(UIImage(named: "Group 257"), for: .normal)
            }
            return cell
        }else {
            return offerCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = productDitealVC(nibName: "productDitealVC", bundle: nil)
        vc.singlItem = offers[indexPath.row]
        vc.isFav = offers[indexPath.row].wishlistState ?? 0
        self.navigationController!.pushViewController(vc, animated: true)

    }
}

extension homeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("print")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? homeBannerCell {
            cell.configureCell(images: slider[indexPath.row])
            
            return cell
        }else {
            return homeBannerCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
    }
    
}



