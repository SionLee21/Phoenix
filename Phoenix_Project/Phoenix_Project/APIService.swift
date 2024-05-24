import Foundation

class APIService {
    let baseURL = "https://pard-host.onrender.com"
    
    func getPards(from url: URL, completion: @escaping ([Pard]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pards = try decoder.decode([Pard].self, from: data)
                completion(pards, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func addPard(_ pard: Pard, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pard") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pard)
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) { _, _, error in
                completion(error)
            }.resume()
        } catch {
            completion(error)
        }
    }
    
    func getPard(id: Int, completion: @escaping (Pard?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pard/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let pard = try decoder.decode(Pard.self, from: data)
                completion(pard, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func deletePard(id: Int, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pard/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            completion(error)
        }.resume()
    }
    
    func editPard(pard: Pard, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pard/\(pard.id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pard)
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) { _, _, error in
                completion(error)
            }.resume()
        } catch {
            completion(error)
        }
    }
}
