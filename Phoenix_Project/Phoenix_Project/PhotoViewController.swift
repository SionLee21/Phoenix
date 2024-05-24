import UIKit

class PhotoViewController: UIViewController {
    
    // 이미지 뷰 속성
    var imageView: UIImageView!
    
    // 이미지 피커 컨트롤러 속성
    var imagePickerController = UIImagePickerController()
    
    // 업로드 버튼 속성
    var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 뷰 생성 및 설정
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = view.center
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(imageView)
        
        // 업로드 버튼 생성 및 설정
        uploadButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        uploadButton.center = CGPoint(x: view.center.x, y: imageView.frame.maxY + 30)
        uploadButton.setTitle("업로드", for: .normal)
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.backgroundColor = .blue
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        
        view.addSubview(uploadButton)
        
        // 이미지 피커 컨트롤러 설정
        imagePickerController.delegate = self
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

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 이미지 선택 완료 시 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        
        guard let userPickedImage = info[.originalImage] as? UIImage else {
            fatalError("선택된 이미지를 불러오지 못했습니다 : userPickedImage의 값이 nil입니다. ")
        }
        
        imageView.image = userPickedImage
    }
}
