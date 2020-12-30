import Foundation




class NetworkManager {
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
//MARK: - Public
    func fetch<T: Decodable>(url: URL, callback: @escaping (Result<T, NetworkManagerError>) -> Void) {
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    callback(.failure(.unknownError))
                    return
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    callback(.failure(.responseCodeIsInvalid))
                    return
                }
                
                guard let data = data else {
                    callback(.failure(.noData))
                    return
                }
                
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    callback(.failure(.failedToDecodeJsonToCodableStruct))
                    return
                }
                
                callback(.success(decodedData))
            }
        }
        task?.resume()
        
        
       
    }
    
    
    
    
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    callback(.failure(.unknownError))
                    return
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    callback(.failure(.responseCodeIsInvalid))
                    return
                }
                
                guard let data = data else {
                    callback(.failure(.noData))
                    return
                }

                callback(.success(data))
            }
        }
        task?.resume()
    }
    
//MARK: - Private
    private let session: URLSession
    
    private var task: URLSessionDataTask?
    
   
}
