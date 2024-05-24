import UIKit

class uploadViewController: UIViewController {
    
    // 이미지 뷰 속성
    var imageView: UIImageView!
    
    // 날짜 선택 뷰 속성
    let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ko_KR")
        return datePicker
    }()
    
    // 날씨 아이콘 뷰 속성
    let weatherIconViews: [UIImageView] = {
        let icons = [UIImage(systemName: "sun.max"), UIImage(systemName: "cloud.sun"), UIImage(systemName: "cloud"), UIImage(systemName: "cloud.rain")]
        return icons.map { icon in
            let imageView = UIImageView(image: icon)
            imageView.tintColor = .gray
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }()
    
    // 텍스트 필드 속성
    let textView: LinedTextView = {
        let tv = LinedTextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textAlignment = .left
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5) // 텍스트 뷰의 패딩 설정
        tv.placeholder = "이 청춘에 대한 당신의 이야기를 들려주세요."
        return tv
    }()
    
    // 업로드 버튼 속성
    var uploadButton: UIButton!
    
    // 이미지 피커 컨트롤러 속성
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 이미지 뷰 생성 및 설정
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor // border color 설정
        imageView.layer.borderWidth = 1 // border width 설정
        
        // 기본 이미지 뷰 레이블 생성 및 설정
        let imageViewLabel = UILabel()
        imageViewLabel.text = "청춘을 포스팅 하세요"
        imageViewLabel.textAlignment = .center
        imageViewLabel.textColor = .black
        imageView.addSubview(imageViewLabel)
        imageViewLabel.translatesAutoresizingMaskIntoConstraints = false
