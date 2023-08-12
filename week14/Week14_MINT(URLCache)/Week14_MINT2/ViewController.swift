//
//  ViewController.swift
//  Week14_MINT2
//
//  Created by mint on 2023/08/09.
//

import UIKit

class ViewController: UIViewController {
    let cache = URLCache.shared
    //let cache = URLCache(memoryCapacity: 40 * 1024 * 1024 , diskCapacity: 40 * 1024 * 1024)
    
    private var firstImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()

    private var secondImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private let firstImageButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("첫번째 이미지 받아오기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBrown
        button.addTarget(self, action: #selector(tappedFirstImageButton), for: .touchUpInside)
        
        return button
    }()

    private let secondImageButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("두번째 이미지 받아오기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.addTarget(self, action: #selector(tappedSecondImageButton), for: .touchUpInside)
        
        return button
    }()
    
    private let initializationButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("이미지 초기화", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemMint
        button.addTarget(self, action: #selector(tappedInitializationButton), for: .touchUpInside)
        
        return button
    }()
    
    private let removeCacheButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("캐시 비우기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(tappedRemoveCacheButton), for: .touchUpInside)
        
        return button
    }()
    
    enum Image {
        case first, second
        
        var urlString: String {
            switch self {
            case .first:
                return "https://wallpaperaccess.com/download/europe-4k-1369012"
            case .second:
                return "https://wallpaperaccess.com/download/europe-4k-1318341"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func loadImageUrl(_ url: URL, _ loadImage: UIImageView) -> UIImageView {
        let startTime = CFAbsoluteTimeGetCurrent()
        let request = URLRequest(url: url)
        
        if (self.cache.cachedResponse(for: request) != nil) {
            if let data = self.cache.cachedResponse(for: request)?.data,
               let image = UIImage(data: data) {
                print("캐시된 데이터가 있습니다.")
                loadImage.image = image
                let durationTime = CFAbsoluteTimeGetCurrent() - startTime
                print("시간: \(durationTime)")
                return loadImage
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                if let response = response,
                   let data = data,
                   let image = UIImage(data: data) {
                    let cacheData = CachedURLResponse(response: response, data: data)
                    self.cache.storeCachedResponse(cacheData, for: request)
                    loadImage.image = image
                    print("새로운 이미지를 받아왔습니다.")
                    
                }
            }
        }.resume()
        return loadImage
        
    }
    
    @objc private func tappedFirstImageButton() {
        guard let url = URL(string: Image.first.urlString) else {
            return
        }
        let image = loadImageUrl(url, firstImage)
        firstImage = image
    }
    
    @objc private func tappedSecondImageButton() {
        guard let url = URL(string: Image.second.urlString) else {
            return
        }
        let image = loadImageUrl(url, secondImage)
        secondImage = image
    }
    
    @objc private func tappedInitializationButton() {
        firstImage.image = nil
        secondImage.image = nil
        print("이미지를 초기화합니다.")
    }
    
    @objc private func tappedRemoveCacheButton() {
        cache.removeAllCachedResponses()
        print("모든 캐시 데이터를 삭제했습니다.")
    }
}

extension ViewController {
    private func configureUI() {
        configureFirstImageView()
        configureFirstImageButton()
        configureSecondImageView()
        configureSecondImageButton()
        configureInitializationButton()
        configureRemoveCacheButton()
    }
    
    private func configureFirstImageView() {
        view.addSubview(firstImage)
        NSLayoutConstraint.activate([
            firstImage.widthAnchor.constraint(equalToConstant: 200),
            firstImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),
            firstImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            firstImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureFirstImageButton() {
        view.addSubview(firstImageButton)
        NSLayoutConstraint.activate([
            firstImageButton.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 10),
            firstImageButton.widthAnchor.constraint(equalToConstant: 220),
            firstImageButton.heightAnchor.constraint(equalToConstant: 50),
            firstImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureSecondImageView() {
        view.addSubview(secondImage)
        NSLayoutConstraint.activate([
            secondImage.widthAnchor.constraint(equalTo: firstImage.widthAnchor),
            secondImage.heightAnchor.constraint(equalTo: firstImage.heightAnchor),
            secondImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondImage.topAnchor.constraint(equalTo: firstImageButton.bottomAnchor, constant: 30)
        ])
    }
    
    private func configureSecondImageButton() {
        view.addSubview(secondImageButton)
        NSLayoutConstraint.activate([
            secondImageButton.topAnchor.constraint(equalTo: secondImage.bottomAnchor, constant: 10),
            secondImageButton.widthAnchor.constraint(equalTo: firstImageButton.widthAnchor),
            secondImageButton.heightAnchor.constraint(equalTo: firstImageButton.heightAnchor),
            secondImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureInitializationButton() {
        view.addSubview(initializationButton)
        NSLayoutConstraint.activate([
            initializationButton.topAnchor.constraint(equalTo: secondImageButton.bottomAnchor, constant: 30),
            initializationButton.widthAnchor.constraint(equalToConstant: 330),
            initializationButton.heightAnchor.constraint(equalToConstant: 70),
            initializationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureRemoveCacheButton() {
        view.addSubview(removeCacheButton)
        NSLayoutConstraint.activate([
            removeCacheButton.topAnchor.constraint(equalTo: initializationButton.bottomAnchor, constant: 10),
            removeCacheButton.widthAnchor.constraint(equalTo: initializationButton.widthAnchor),
            removeCacheButton.heightAnchor.constraint(equalTo: initializationButton.heightAnchor),
            removeCacheButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}



