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

        // 레이블 제약 조건 설정
        NSLayoutConstraint.activate([
            imageViewLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            imageViewLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])

        // 가로줄 생성 및 설정
        let lineView = UIView()
        lineView.backgroundColor = .black
        imageView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false

        // 가로줄 제약 조건 설정
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: imageViewLabel.bottomAnchor, constant: 10),
            lineView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            lineView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "청춘 기록"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
        // 날짜 선택 뷰 추가
        let dateStackView = UIStackView(arrangedSubviews: [datePickerView])
        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.spacing = 10
        view.addSubview(dateStackView)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        // 날씨 아이콘 뷰 추가
        let iconStackView = UIStackView(arrangedSubviews: weatherIconViews)
        iconStackView.axis = .horizontal
        iconStackView.spacing = 10
        iconStackView.distribution = .equalSpacing
        iconStackView.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        iconStackView.layer.cornerRadius = 5
        iconStackView.clipsToBounds = true
        view.addSubview(iconStackView)
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            iconStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iconStackView.heightAnchor.constraint(equalToConstant: 30),
            iconStackView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 필드와 줄 선 제약 조건 설정
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: CGFloat(textView.maxNumberOfLines) * textView.lineSpacing),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // 업로드 버튼 생성 및 설정
        uploadButton = UIButton()
        uploadButton.setTitle("청춘 업로드", for: .normal)
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.5294117647, blue: 0.1921568627, alpha: 1)
        uploadButton.layer.cornerRadius = 15
        uploadButton.clipsToBounds = true
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        
        view.addSubview(uploadButton)
        
        // 이미지 피커 컨트롤러 설정
        imagePickerController.delegate = self
        
        // Constraint 설정
        setupConstraints()
        
        // 화면 탭 제스처 설정
        let tapScreenGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapScreenGesture)
    }
    
    // Constraint 설정 메서드
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            uploadButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 30),
            uploadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            uploadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            uploadButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // 키보드 내리기 메서드
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // 이미지 뷰 탭 이벤트 처리
    @objc func imageViewTapped() {
        let alertController = UIAlertController(title: "알림", message: "원하는 작업을 선택하세요.", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "사진", style: .default) { _ in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        
        let photoLibraryAction = UIAlertAction(title: "업로드", style: .default) { _ in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // 업로드 버튼 탭 이벤트 처리
    @objc func uploadButtonTapped() {
        guard let image = imageView.image else {
            print("업로드할 이미지가 없습니다.")
            return
        }
        
        uploadImageToServer(image: image)
    }
    
    // 이미지를 서버로 전송하는 메서드
    func uploadImageToServer(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("이미지 데이터 변환에 실패했습니다.")
            return
        }
        
        let url = URL(string: "http://192.168.0.19:8080/api/images/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("이미지 업로드 실패: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("잘못된 서버 응답입니다.")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("이미지 업로드 성공")
            } else {
                print("이미지 업로드 실패: HTTP 상태 코드 \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
}

extension uploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 이미지 선택 완료 시 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        
        guard let userPickedImage = info[.originalImage] as? UIImage else {
            fatalError("선택된 이미지를 불러오지 못했습니다: userPickedImage의 값이 nil입니다.")
        }
        
        imageView.image = userPickedImage
    }
}

class LinedTextView: UITextView, UITextViewDelegate {
    let lineSpacing: CGFloat = 40 // 줄 간격을 적절하게 조정
    let maxNumberOfLines: Int = 6
    
    var placeholder: String? {
        didSet {
            self.text = placeholder
            self.textColor = .lightGray
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing / 1.9 // 줄 간격을 반으로 줄임
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        self.typingAttributes = attributes // 줄 간격을 적용한 속성을 텍스트 뷰의 기본 타이핑 속성으로 설정
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.setLineWidth(1.0)

        for i in 1...maxNumberOfLines {
            let y = CGFloat(i) * lineSpacing
            context?.move(to: CGPoint(x: 0, y: y))
            context?.addLine(to: CGPoint(x: rect.width, y: y))
        }

        context?.strokePath()
    }

    // UITextViewDelegate 메서드
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let numberOfLines = prospectiveText.components(separatedBy: "\n").count
        return numberOfLines <= maxNumberOfLines || text != "\n"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
}
