//
//  navSetupHelper.swift
//  Alforno
//
//  Created by Ahmed farid on 3/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu


extension UIViewController {
    
    func setUpNav(logo: Bool = false ,menu: Bool = false, cart: Bool = false, back: Bool = false) {
        switch logo {
        case true:
            let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            nvImageTitle.contentMode = .scaleAspectFit
            let imageName = UIImage(named: "XMLID_1_")
            nvImageTitle.image = imageName
            navigationItem.titleView = nvImageTitle
        default:
            print("no")
        }
        switch menu {
        case true:
            let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu-1"), style: .done, target: self, action: #selector(sideMenu))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
        default:
            print("no")
        }
        switch cart {
        case true:
            let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(self.showCart))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
            cartApi.listOfCart{ (error,networkSuccess,codeSucess,liCart) in
                if liCart?.status == true {
                    self.addBadge(count: liCart?.data?.list?.count ?? 0)
                }else {
                        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(self.showCart))
                        self.navigationItem.rightBarButtonItem = rightBarButtonItem
                }
            }
        default:
            print("no")
        }
        switch back {
        case true:
            let backImage = UIImage(named: "BACK-1")
            self.navigationController?.navigationBar.backIndicatorImage = backImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
            self.navigationController?.navigationBar.backItem?.title = ""
        default:
            print("no")
        }
        
    }
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.03921568627, green: 0.1254901961, blue: 0.1921568627, alpha: 1)
    }
    
    @objc func sideMenu() {
        let menu = UIStoryboard(name: "sideMenu", bundle: nil).instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = view.frame.size.width - 50
        present(menu, animated: true, completion: nil)
    }
    
    @objc func showCart() {
        let vc = cartVC(nibName: "cartVC", bundle: nil)
        vc.fromMnue = false
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func addBadge(count: Int) {
        let bagButton = BadgeButton()
        bagButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        bagButton.tintColor = UIColor.white
        bagButton.setImage(UIImage(named: "bag nav"), for: .normal)
        bagButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 5)
        print("cart Count \(count)")
        bagButton.badge = "\(count)"
        bagButton.addTarget(self, action: #selector(self.showCart), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bagButton)
    }
}
