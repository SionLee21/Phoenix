//
//  repoViewController.swift
//  Phoenix_Project
//
//  Created by 김민준 on 5/25/24.
//

import UIKit
class repoViewController: UIViewController{
    
    
   
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text  = "청춘 저장소"
        label.textColor = #colorLiteral(red: 0.1529411765, green: 0.5294117647, blue: 0.1921568627, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 19.0 , weight: .bold)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let scrollView: UIScrollView = {
        let scrollViews = UIScrollView()
        scrollViews.translatesAutoresizingMaskIntoConstraints = false
        return scrollViews
    }()
    
    let contentView: UIView = {
        let contents = UIView()
        contents.translatesAutoresizingMaskIntoConstraints = false
        return contents
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        var imageView1: UIImageView!
        var imageView2: UIImageView!
        var imageView3: UIImageView!
        var imageView4: UIImageView!
        var imageView5: UIImageView!
        var imageView6: UIImageView!
        
        
        
        
        
        
        setUI()
    }
    
    
    
    func setUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
//        contentView.addSubview()
        
        
        
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ,constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor ,constant: 16),
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            

        
        ])
        
        
        
    }
    
}
