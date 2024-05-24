import UIKit

class ViewController: UIViewController {
    // 이미지 뷰 속성
    var imageView: UIImageView!
    
    // 이미지 피커 컨트롤러 속성
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 뷰 생성 및 설정
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = view.center
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        // 카메라 버튼 생성 및 설정
        let cameraButton = UIButton(type: .system)
        cameraButton.setTitle("Camera", for: .normal)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        cameraButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        cameraButton.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        view.addSubview(cameraButton)
        
        // 이미지 피커 컨트롤러 설정
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
    }
    
    // 카메라 버튼 탭 이벤트 처리
    @objc func cameraButtonTapped() {
        present(imagePickerController, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 선택 완료 시 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        
        guard let userPickedImage = info[.originalImage] as? UIImage else {
            fatalError("선택된 이미지를 불러오지 못했습니다 : userPickedImage의 값이 nil입니다. ")
        }
        
        imageView.image = userPickedImage
    }
}
