import Foundation
import UIKit

protocol ImageDownLoadProtocol {
    func downloadImage(from url: URL, completion: @escaping(UIImage?)-> Void)
}

extension ImageDownLoadProtocol{
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            let session = URLSession(configuration: .default)
            DispatchQueue.global(qos: .background).async {
                print("In background")
                session.dataTask(with: URLRequest(url: url)) { data, response, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "Unknown error")
                    }
                    if let data = data, let image = UIImage(data: data) {
                        print("Downloaded image")
                        DispatchQueue.main.async {
                            print("dispatched to main")
                            completion(image)
                        }
                    }
                    }.resume()
            }
        }
}
