//
//  modalViewController.swift
//  Phoenix_Project
//
//  Created by 김민준 on 5/25/24.
//

import UIKit


class modalViewController : UIViewController {
        
    let todayLabel : UILabel = {
        let label = UILabel()
        label.text = "오늘의 명언"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let todayContext : UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let date : UILabel = {
        let label = UILabel()
        label.text = "2024/05/24"
        label.tintColor = .black
    
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let weatherLabel : UILabel = {
        let label = UILabel()
        label.text = "청춘 날씨:"
        label.tintColor = .black
    
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let gachaImage : UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "modalImage") // 임시로 만듬
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        return mainImage
    }()
//
//
    
    
    
    let sunImage : UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "sun") // 임시로 만듬
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        return mainImage
    }()
//
    
    
    
    
    
    let chatButton : UIButton = {
        var config = UIButton.Configuration.filled()    // 채워진 버전으로 그리기
        config.background.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        // 버튼 속 text 관련된 설정
        
        
        var text = AttributedString.init("댓글 달기")
        text.foregroundColor = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17 , weight: .semibold)
        config.attributedTitle = text
        // 버튼의 마진 조정
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 45, bottom: 12, trailing: 45)
        
        
        let downloadButton = UIButton(configuration: config)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        downloadButton.layer.cornerRadius = 20
        return downloadButton
    }()
    
    
    
    let saveButton : UIButton = {
        var config = UIButton.Configuration.filled()    // 채워진 버전으로 그리기
        config.background.backgroundColor = #colorLiteral(red: 0.3019607663, green: 0.3019607663, blue: 0.3019607663, alpha: 1)
        // 버튼 속 text 관련된 설정
        
        
        var text = AttributedString.init("저장 하기")
        text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17 , weight: .semibold)
        config.attributedTitle = text
        // 버튼의 마진 조정
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 45, bottom: 12, trailing: 45)
        
        let downloadButton = UIButton(configuration: config)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        downloadButton.layer.cornerRadius = 20
        return downloadButton
    }()
    
//
    let textView: ModalLinedTextView = {
            let tv = ModalLinedTextView()
            tv.font = UIFont.systemFont(ofSize: 16)
            tv.textAlignment = .left
            tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5) // 텍스트 뷰의 패딩 설정
            
            return tv
        }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    
    func setup(){
        view.addSubview(gachaImage)
        view.addSubview(date)
        view.addSubview(chatButton)
        view.addSubview(saveButton)
        view.addSubview(weatherLabel)
        view.addSubview(sunImage)
        view.addSubview(textView)
        
        
        NSLayoutConstraint.activate([
            gachaImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 273),
            gachaImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            gachaImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            gachaImage.widthAnchor.constraint(equalToConstant: 317),
            gachaImage.heightAnchor.constraint(equalToConstant: 182),
        
            
            date.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            date.bottomAnchor.constraint(equalTo:gachaImage.topAnchor, constant: -10),
            
            
            weatherLabel.bottomAnchor.constraint(equalTo:gachaImage.safeAreaLayoutGuide.topAnchor, constant: -10),
            
            weatherLabel.leadingAnchor.constraint(equalTo: date.trailingAnchor , constant: 140),
            
            
            sunImage.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor, constant: 4),
            sunImage.bottomAnchor.constraint(equalTo:gachaImage.safeAreaLayoutGuide.topAnchor, constant: -10),
            sunImage.widthAnchor.constraint(equalToConstant: 16),
            sunImage.heightAnchor.constraint(equalToConstant: 16),
            
            
            chatButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            chatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -47),
            
            
            saveButton.leadingAnchor.constraint(equalTo: chatButton.trailingAnchor, constant: 7 ),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -47),
//
            
            
           
            
        ])
    }
}

class ModalLinedTextView: UITextView, UITextViewDelegate {
    let lineSpacing: CGFloat = 40 // 줄 간격을 적절하게 조정
    let maxNumberOfLines: Int = 4
    
    var placeholder: String? {
        didSet {
            self.text = placeholder
            self.textColor = .lightGray
        }
    }
}
