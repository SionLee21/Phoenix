import UIKit

class modalViewController: UIViewController {
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 명언"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.text = "2024/05/24"
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "청춘 날씨:"
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gachaImage: UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "modalImage")
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        return mainImage
    }()
<<<<<<< HEAD
//
//
=======
>>>>>>> 99bd656 (마ㅣ막)
    
    let weatherIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    let chatButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        var text = AttributedString.init("댓글 달기")
        text.foregroundColor = #colorLiteral(red: 0.4235294118, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        config.attributedTitle = text
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 45, bottom: 12, trailing: 45)
        let downloadButton = UIButton(configuration: config)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.layer.cornerRadius = 20
        return downloadButton
    }()
    
    let saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 0.3019607663, green: 0.3019607663, blue: 0.3019607663, alpha: 1)
        var text = AttributedString.init("저장 하기")
        text.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        config.attributedTitle = text
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 45, bottom: 12, trailing: 45)
        let downloadButton = UIButton(configuration: config)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.layer.cornerRadius = 20
        return downloadButton
    }()
    
    let textView: ModalLinedTextView = {
        let tv = ModalLinedTextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textAlignment = .left
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        return tv
    }()
    
    let postContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        fetchRandomPosting()
    }
    
    func setup() {
        view.addSubview(gachaImage)
        view.addSubview(date)
        view.addSubview(chatButton)
        view.addSubview(saveButton)
        view.addSubview(weatherLabel)
        view.addSubview(weatherIconView)
        view.addSubview(textView)
        view.addSubview(postContentLabel)
        
        NSLayoutConstraint.activate([
            gachaImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 273),
            gachaImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            gachaImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            gachaImage.widthAnchor.constraint(equalToConstant: 317),
            gachaImage.heightAnchor.constraint(equalToConstant: 182),
            
            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            date.bottomAnchor.constraint(equalTo: gachaImage.topAnchor, constant: -10),
            
            weatherLabel.bottomAnchor.constraint(equalTo: gachaImage.safeAreaLayoutGuide.topAnchor, constant: -10),
            weatherLabel.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 140),
            
            weatherIconView.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor, constant: 4),
            weatherIconView.bottomAnchor.constraint(equalTo: gachaImage.safeAreaLayoutGuide.topAnchor, constant: -10),
            weatherIconView.widthAnchor.constraint(equalToConstant: 16),
            weatherIconView.heightAnchor.constraint(equalToConstant: 16),
            
            chatButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            chatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -47),
            
            saveButton.leadingAnchor.constraint(equalTo: chatButton.trailingAnchor, constant: 7),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -47),
            
            postContentLabel.topAnchor.constraint(equalTo: gachaImage.bottomAnchor, constant: 20),
            postContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            postContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func fetchRandomPosting() {
        guard let url = URL(string: "http://192.168.0.19:8080/api/postings/random") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching random posting: \(error.localizedDescription)")
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let postingData = json as? [String: Any] {
                    DispatchQueue.main.async {
                        self.updateUI(with: postingData)
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func updateUI(with postingData: [String: Any]) {
        guard let postContent = postingData["postContent"] as? String else {
            print("postContent is nil")
            return
        }
        
        guard let feeling = postingData["feeling"] as? Int else {
            print("feeling is nil")
            return
        }
        
        guard let imageId = postingData["imageId"] as? Int else {
            print("imageId is nil")
            return
        }
        
        print("postContent: \(postContent)")
        print("feeling: \(feeling)")
        print("imageId: \(imageId)")
        
        textView.text = postContent
        textView.textColor = .black
        postContentLabel.text = postContent
        
        updateWeatherIcon(with: feeling)
        fetchImage(with: imageId)
    }
    
    func updateWeatherIcon(with feeling: Int) {
        weatherIconView.image = nil // 초기화
        
        switch feeling {
        case 0:
            weatherIconView.image = UIImage(systemName: "sun.max")?.withRenderingMode(.alwaysTemplate)
            weatherIconView.tintColor = .black
        case 1:
            weatherIconView.image = UIImage(systemName: "cloud.sun")?.withRenderingMode(.alwaysTemplate)
            weatherIconView.tintColor = .black
        case 2:
            weatherIconView.image = UIImage(systemName: "cloud")?.withRenderingMode(.alwaysTemplate)
            weatherIconView.tintColor = .black
        case 3:
            weatherIconView.image = UIImage(systemName: "cloud.rain")?.withRenderingMode(.alwaysTemplate)
            weatherIconView.tintColor = .black
        default:
            break
        }
    }
    
    struct ImageResponse: Codable {
        let imageId: Int
        let filePath: String
    }
    
    func fetchImage(with imageId: Int) {
        guard let url = URL(string: "http://192.168.0.19:8080/api/images/\(imageId)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response is not a HTTP response")
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                print("Server responded with status code: \(httpResponse.statusCode)")
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    print("Response body: \(body)")
                }
                return
            }
            
            guard let data = data else {
                print("No data received from the server")
                return
            }
            
            do {
                let imageResponse = try JSONDecoder().decode(ImageResponse.self, from: data)
                self.downloadImage(from: imageResponse.filePath)
            } catch {
                
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func downloadImage(from filePath: String) {
        guard let url = URL(string: filePath) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received from the server")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.gachaImage.image = image
                }
            }
        }.resume()
    }
}

class ModalLinedTextView: UITextView, UITextViewDelegate {
    let lineSpacing: CGFloat = 40
    let maxNumberOfLines: Int = 4
    
    var placeholder: String? {
        didSet {
            self.text = placeholder
            self.textColor = .lightGray
        }
    }
}

