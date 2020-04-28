//
//  menuVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView


class menuVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var menuTabelView: UITableView!
    
    var menus = [catData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav(logo: false, menu: true, cart: true, back: false)
        menuTabelView.delegate = self
        menuTabelView.dataSource = self
        self.menuTabelView.register(UINib(nibName: "menuCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        catsHandelRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavColore(false)
    }
    
    func catsHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        mnueApi.mnue{ (error,success,menus) in
            if let menus = menus{
                self.menus = menus.data ?? []
                print(menus)
                self.menuTabelView.reloadData()
                self.stopAnimating()
            }
         self.stopAnimating()
        }
        
    }
}


extension menuVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = menuTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? menuCell {
            cell.configureCell(menus:  menus[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return menuCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = allProdectsVC(nibName: "allProdectsVC", bundle: nil)
        vc.singelItem = menus[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
}
