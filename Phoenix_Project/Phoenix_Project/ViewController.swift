//
//  ViewController.swift
//  TabBar
//
//  Created by 김하람 on 2023/09/29.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setTabBar()
    }
    
    func setTabBar() {
        let vc1 = UINavigationController(rootViewController: repoViewController())
        let vc2 = UINavigationController(rootViewController: HomeViewController())
        let vc3 = UINavigationController(rootViewController: uploadViewController())
        
        self.viewControllers = [vc1, vc2, vc3]
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .gray
        
        guard let tabBarItems = self.tabBar.items else {return}
        tabBarItems[0].image = UIImage(systemName: "face.smiling")
        tabBarItems[1].image = UIImage(systemName: "moon.fill")
        tabBarItems[2].image = UIImage(systemName: "pawprint.fill")
        tabBarItems[0].title = "청춘저장소"
        tabBarItems[1].title = "홈"
        tabBarItems[2].title = "업로드"
    }


}

