import UIKit

class uploadViewController: UIViewController {
    
    // 이미지 뷰 속성
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    // 날짜 선택 뷰 속성
    let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()

    // 날짜 선택 시 호출되는 메서드
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        datePickerView.setValue(UIColor(red: 0.1529, green: 0.5294, blue: 0.1921, alpha: 1), forKey: "textColor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 이미지 뷰의 모든 서브뷰 숨기기
        for subview in imageView.subviews {
            subview.isHidden = true
        }
    }
    
    // 날씨 아이콘 뷰 속성
    let weatherIconViews: [UIImageView] = {
        let icons = [UIImage(systemName: "sun.max"), UIImage(systemName: "cloud.sun"), UIImage(systemName: "cloud"), UIImage(systemName: "cloud.rain")]
        return icons.map { icon in
            let imageView = UIImageView(image: icon)
            imageView.tintColor = .gray
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            return imageView
        }
    }()

    // 날씨 아이콘 탭 이벤트 처리
    @objc func weatherIconTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedIcon = sender.view as? UIImageView else { return }
        
        for iconView in weatherIconViews {
            if iconView == selectedIcon {
                iconView.backgroundColor = UIColor(red: 0.1529, green: 0.5294, blue: 0.1921, alpha: 1)
                iconView.tintColor = .white
                iconView.layer.cornerRadius = iconView.frame.width / 2
                iconView.clipsToBounds = true
            } else {
                iconView.backgroundColor = .clear
                iconView.tintColor = .gray
                iconView.layer.cornerRadius = 0
                iconView.clipsToBounds = false
            }
        }
    }
    
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
        navigationController?.navigationBar.tintColor = .clear
        
        // 이미지 뷰 생성 및 설정
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
        
        // 날씨 아이콘 탭 제스처 설정
        for iconView in weatherIconViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(weatherIconTapped(_:)))
            iconView.addGestureRecognizer(tapGesture)
        }

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
        iconStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        iconStackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(iconStackView)
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            iconStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iconStackView.heightAnchor.constraint(equalToConstant: 30),
            iconStackView.widthAnchor.constraint(equalToConstant: 170)
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

        let postContent = textView.text ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let postDate = formatter.string(from: datePickerView.date)
        var feeling = 0

        // 선택된 아이콘에 따라 feeling 값 설정
        if weatherIconViews[0].backgroundColor == UIColor(red: 0.1529, green: 0.5294, blue: 0.1921, alpha: 1) {
            feeling = 0 // sun.max 선택
        } else if weatherIconViews[1].backgroundColor == UIColor(red: 0.1529, green: 0.5294, blue: 0.1921, alpha: 1) {
            feeling = 1 // cloud.sun 선택
        } else if weatherIconViews[2].backgroundColor == UIColor(red: 0.1529, green: 0.5294, blue: 0.1921, alpha: 1) {
            feeling = 2 // cloud 선택
        } else if weatherIconViews[3].backgroundColor == UIColor(red: 0.1529, green: 0.5294, blue: 0.1921, alpha: 1) {
            feeling = 3 // cloud.rain 선택
        }

        uploadImageToServer(image: image, postContent: postContent, postDate: postDate, feeling: feeling)
    }

    

    // 이미지와 데이터를 서버로 전송하는 메서드
    func uploadImageToServer(image: UIImage, postContent: String, postDate: String, feeling: Int) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("이미지 데이터 변환에 실패했습니다.")
            return
        }

        let url = URL(string: "http://192.168.0.19:8080/api/postings/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // 이미지 데이터 추가
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        // postingDTO 데이터 추가
        let postingDTO: [String: Any] = [
            "postContent": postContent,
            "postDate": postDate,
            "feeling": feeling
        ]

        let postingDTOData = try? JSONSerialization.data(withJSONObject: postingDTO, options: [])

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"postingDTO\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        body.append(postingDTOData!)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server responded with an error")
                return
            }

            guard let data = data else {
                print("No data received from the server")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Server response: \(json)")
                    // 서버 응답 JSON 데이터를 처리하는 로직을 추가하세요.
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}

extension uploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func openCamera() {
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }

    // 이미지 선택 완료 시 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        
        guard let userPickedImage = info[.originalImage] as? UIImage else {
            fatalError("선택된 이미지를 불러오지 못했습니다: userPickedImage의 값이 nil입니다.")
        }
        
        imageView.image = userPickedImage
        
        // 이미지 뷰의 모든 서브뷰 숨기기
        for subview in imageView.subviews {
            subview.isHidden = true
        }
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
