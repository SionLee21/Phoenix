import UIKit

class HomeViewController: UIViewController {
    
    
    let boxView : UIView = {
       let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let missionTitleLabel : UILabel = {
        let label = UILabel()
        label.text  = "오늘의 미션"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let missionLabel : UILabel = {
        let label = UILabel()
        label.text  = "지금을 즐겨라"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let gachaImage : UIImageView = {
        let gachaImage = UIImageView()
        
        gachaImage.image = UIImage(named:"gachaImage")
        gachaImage.translatesAutoresizingMaskIntoConstraints = false
        gachaImage.contentMode = .scaleAspectFit // 이미지 비율 유지
        gachaImage.layer.masksToBounds = true
        return gachaImage
    }()

    

    
    
    
    
    let gachaButton : UIButton = {
        var config = UIButton.Configuration.filled()    // 채워진 버전으로 그리기
        config.background.backgroundColor = .gray // 배경 흰색으로
        // 버튼 속 text 관련된 설정
        config.attributedTitle = AttributedString("청춘뽑기",attributes: AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]))
        
        // 버튼의 마진 조정
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let downloadButton = UIButton(configuration: config)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        return downloadButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    
    
    //MARK: - 컴포넌트 위치 설정
    func setUI(){
        view.backgroundColor = .white
        view.addSubview(boxView)
        boxView.addSubview(missionTitleLabel)
        boxView.addSubview(missionLabel)
        view.addSubview(gachaImage)
        view.addSubview(gachaButton)
        
        
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ,constant: 10 ),
            boxView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            
            
            missionTitleLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 5),
            missionTitleLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 5),
            
            missionLabel.topAnchor.constraint(equalTo: missionTitleLabel.topAnchor, constant: 20 ),
            missionLabel.leadingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: 5),
            
            
            gachaImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gachaImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            gachaImage.widthAnchor.constraint(equalToConstant: 150),
            gachaImage.heightAnchor.constraint(equalToConstant: 150),
            
            gachaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gachaButton.topAnchor.constraint(equalTo: gachaImage.bottomAnchor, constant: 10),
            
            
            
        ])
        
        
    }
   

}

