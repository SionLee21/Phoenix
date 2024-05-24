//
//  ViewController.swift
//  TabBar
//
//  Created by 김하람 on 2023/09/29.
//

import UIKit

class ViewController: UITabBarController {

    // 이미지 피커 컨트롤러 속성
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setTabBar()
    }
    
    
    
    func setTabBar() {
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: repoViewController())
        let vc3 = UINavigationController(rootViewController: uploadViewController())
        
        self.viewControllers = [vc1, vc2, vc3]
        self.tabBar.tintColor = #colorLiteral(red: 0.1775263846, green: 0.5874372125, blue: 0.2503151298, alpha: 1)
        
        self.tabBar.backgroundColor = .white
        
        guard let tabBarItems = self.tabBar.items else {return}
        tabBarItems[0].image = UIImage(named: "a")
        tabBarItems[1].image = UIImage(named: "b")
        tabBarItems[2].image = UIImage(named: "c")
        tabBarItems[0].title = "청춘뽑기"
        tabBarItems[1].title = "청춘저장소"
        tabBarItems[2].title = "청춘기록"
    }


}

