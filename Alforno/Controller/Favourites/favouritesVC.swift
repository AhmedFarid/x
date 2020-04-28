//
//  favouritesVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/2/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class favouritesVC: UIViewController, NVActivityIndicatorViewable {
    
    
    var products = [offfersData]()
    
    @IBOutlet weak var allProdectCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allProdectCollectionView.delegate = self
        allProdectCollectionView.dataSource = self
        setUpNav(logo: true, menu: true, cart: true, back: false)
        prodeuctsHandelRefresh()
        
        self.allProdectCollectionView.register(UINib.init(nibName: "prodectsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prodeuctsHandelRefresh()
    }
    
    
    func prodeuctsHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        favoriteAPI.allProducts{ (error,networkSuccess,codeSucess,products) in
            if networkSuccess {
                if codeSucess {
                    if products?.status == true {
                        if let products = products{
                            self.products = products.data ?? []
                            print("zzzz\(products)")
                            self.allProdectCollectionView.reloadData()
                            self.stopAnimating()
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "Error", message: "Error favorite")
                        }
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "Favorite", message: "Error favorite")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "Favorite", message: "Favorite is empty")
                }
            }else {
                self.stopAnimating()
                self.showAlert(title: "Network", message: "Check your network connection")
            }
        }
    }
}


extension favouritesVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = allProdectCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? prodectsCell {
            cell.configureCell(product: products[indexPath.row])
            cell.favBTN.setImage(UIImage(named: "Group 257"), for: .normal)
            return cell
        }else {
            return prodectsCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = allProdectCollectionView.frame.width
        
        var width = (screenWidth - 10)/2
        
        width = width < 130 ? 160 : width
        
        return CGSize.init(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = productDitealVC(nibName: "productDitealVC", bundle: nil)
        print("xxxxx")
        vc.singlItem = products[indexPath.row]
        vc.isFav = 1
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
