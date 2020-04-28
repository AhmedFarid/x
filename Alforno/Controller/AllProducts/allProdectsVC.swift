//
//  allProdectsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class allProdectsVC: UIViewController, NVActivityIndicatorViewable {

    
    var singelItem: catData?
    var products = [offfersData]()
    
    @IBOutlet weak var allProdectCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allProdectCollectionView.delegate = self
        allProdectCollectionView.dataSource = self
        setUpNav(logo: true, menu: false, cart: false, back: true)
        prodeuctsHandelRefresh()
        
        self.allProdectCollectionView.register(UINib.init(nibName: "prodectsCell", bundle: nil), forCellWithReuseIdentifier: "cell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        prodeuctsHandelRefresh()
    }
    
    func prodeuctsHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        mnueApi.allProducts(category_id: "\(singelItem?.id ?? 0)" ){ (error,success,products) in
            if success {
                if let products = products{
                    self.products = products.data ?? []
                    print(products)
                    self.allProdectCollectionView.reloadData()
                    self.stopAnimating()
                }else {
                    
                }
            }else {
               self.stopAnimating()
            }
        }
    }
}


extension allProdectsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = allProdectCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? prodectsCell {
        cell.configureCell(product: products[indexPath.row])
            if products[indexPath.row].wishlistState == 0 {
                cell.favBTN.setImage(UIImage(named: "Group 258"), for: .normal)
            }else {
                cell.favBTN.setImage(UIImage(named: "Group 257"), for: .normal)
            }
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
        vc.singlItem = products[indexPath.row]
        vc.isFav = products[indexPath.row].wishlistState ?? 0
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
