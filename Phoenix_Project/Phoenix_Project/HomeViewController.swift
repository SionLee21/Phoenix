import UIKit

class HomeViewController: UIViewController {
    
    
    let boxView : UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false

        
        return view
    }()
    
    let missionTitleLabel : UILabel = {
        let label = UILabel()
        label.text  = "지금 당장 청춘을 찍어보세요"
        label.textColor = #colorLiteral(red: 0.1529411765, green: 0.5294117647, blue: 0.1921568627, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 19.0 , weight: .bold)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cameraImage : UIImageView = {
        let cameraImage = UIImageView()
        
        cameraImage.image = UIImage(named:"camera")
        cameraImage.translatesAutoresizingMaskIntoConstraints = false
        /*gachaImage.contentMode = .scaleAspectFill*/ // 이미지 비율 유지
        cameraImage.layer.masksToBounds = true
        return cameraImage
    }()
    
    
    
    let missionLabel : UILabel = {
        let label = UILabel()
        label.text  = "당신은 지금 어떤 청춘을 살고 있나요?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let gachaImage : UIImageView = {
        let gachaImage = UIImageView()
        
        gachaImage.image = UIImage(named:"gachaImage")
        gachaImage.translatesAutoresizingMaskIntoConstraints = false
        /*gachaImage.contentMode = .scaleAspectFill*/ // 이미지 비율 유지
//        gachaImage.layer.masksToBounds = true
        return gachaImage
    }()

    

    
    
    
    
    let gachaButton : UIButton = {
        var config = UIButton.Configuration.filled()    // 채워진 버전으로 그리기
        config.background.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        // 버튼 속 text 관련된 설정
        
        
        var text = AttributedString.init("청춘 뽑기")
        text.foregroundColor = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17 , weight: .semibold)
        config.attributedTitle = text
        // 버튼의 마진 조정
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 54, bottom: 14, trailing: 54)
        
        let downloadButton = UIButton(configuration: config)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        downloadButton.layer.cornerRadius = 10
        return downloadButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.937312007, green: 0.937312007, blue: 0.937312007, alpha: 1)
        gachaButton.addTarget(self, action: #selector(gachaButtonTapped), for: .touchUpInside)
        setUI()
        
    }
    
    
    
    @objc func gachaButtonTapped(){
        let vc = modalViewController()
        vc.modalPresentationStyle = .pageSheet
        present(vc ,animated: true, completion: nil)
    }
    
    
    
    //MARK: - 컴포넌트 위치 설정
    func setUI(){
        view.backgroundColor = .white
        view.addSubview(boxView)
        boxView.addSubview(missionTitleLabel)
        boxView.addSubview(missionLabel)
        boxView.addSubview(cameraImage)
        view.addSubview(gachaImage)
        view.addSubview(gachaButton)
        
        
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ,constant: 10 ),
            boxView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            boxView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            boxView.widthAnchor.constraint(equalToConstant: 317),
            boxView.heightAnchor.constraint(equalToConstant: 103),
            
            
            
            
            
            cameraImage.leadingAnchor.constraint(equalTo: boxView.leadingAnchor , constant: 24 ),
            cameraImage.centerYAnchor.constraint(equalTo: boxView.centerYAnchor, constant: 0),
            cameraImage.widthAnchor.constraint(equalToConstant: 40),
            cameraImage.heightAnchor.constraint(equalToConstant: 40),
            
            
            missionTitleLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 31),
            missionTitleLabel.leadingAnchor.constraint(equalTo: cameraImage.trailingAnchor, constant: 5),
            
            missionLabel.topAnchor.constraint(equalTo: missionTitleLabel.bottomAnchor, constant: 0),
            missionLabel.leadingAnchor.constraint(equalTo: cameraImage.trailingAnchor, constant: 5),
            
            
            
            gachaImage.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 36),
            gachaImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 88),
            gachaImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -88),
//            gachaImage.widthAnchor.constraint(equalToConstant: 165),
            gachaImage.heightAnchor.constraint(equalToConstant: 383),
            
            gachaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            gachaButton.topAnchor.constraint(equalTo: gachaImage.bottomAnchor, constant: 10),
            
            
            
        ])
        
        
    }
   

}

