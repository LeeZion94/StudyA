# 11주차: Protocol Oriented Programming
## 2017 let's Swift : POP - 조성규(야곰)
### 예제코드 구현 및 POP 활용 예시 확인
pop를 구성하는 핵심 적인 요소는 기능별로 작은 조각들로 나뉜 프로토콜과 기본구현(extension)이다.

먼저 공통적으로 가질 수 있는 부분들을 기능별로 Protocol로 묶어주고 묶어준 컴포넌트들을 사용해서 기본구현을 통해서 확장성 있게 해당 Protocol을 채택하고 있는 타입이면 누구든 해당 기능을 사용할 수 있도록 정의할 수 있다.

```swift
protocol ContainContents {
    var contents: [Content] { get }
    var numberOfContents: Int { get }
}

extension ContainContents {
    var contents: [Content] {
        return TimeLineContentObject.shared.contents
    }
    
    var numberOfContents: Int {
        return contents.count
    }
}
```
ViewController가 가지고 있어야하는 공통적인 contents를 담고 있고 Contents를 가지고 오는 역할을 하는 Protocol이다. 프로젝트에서 가지고 있는 ViewController(TableView, CollectionView, DetailView)에서 사용하고 있는 contents를 정의하고 extension을 통해 공통적으로 가져올 수 있도록 설계햇다.

```swift
protocol MediaContainer {
    var content: Content? { get set }
    var media: ContentPresentable { get }
    var note: UILabel { get set }
    
    var videoLayer: AVPlayerLayer { get }
    var mediaImageView: UIImageView { get }
    
    func contentChanged()
}

extension MediaContainer {
    func contentChanged() {
        guard let content = content else {
            mediaImageView.isHidden = true
            mediaImageView.image = nil
            videoLayer.isHidden = true
            videoLayer.player = nil
            return
        }
        
        switch content.type {
        case .image:
            mediaImageView.isHidden = false
            videoLayer.isHidden = true
            
            let image = UIImage(contentsOfFile: content.urlString)
            
            mediaImageView.image = image
        case .video:
            mediaImageView.isHidden = true
            videoLayer.isHidden = false
            
            let videoURL = URL(filePath: content.urlString)
            let player = AVPlayer(url: videoURL)
            
            videoLayer.player = player
        }
        
        note.text = content.note
    }
    
    var media: ContentPresentable {
        switch content!.type {
        case .image:
            return mediaImageView
        case .video:
            return videoLayer
        }
    }
}
```
Cell (TableView, CollectionView) 및 DetailView에서 직접적으로 보여줘야하는 content를 가지고 있고 content가 변경되었을 경우 존재하는 content에 대한 기본 setting을 진행하는 MediaContrainer Protocol이다. Extension을 통해서 content에 따른 기본 세팅을 기본구현되어있다. content로 들어오는 data가 image뿐만아니라 동영상도 들어올 수 있도록 유연하게 설계될 수 있어야하므로 ContentPresentable Protocol을 사용해서 해당 Protocol을 채택한 어떤 타입이든 적용되어 사용될 수 있도록 할 수 있다. 현재는 image, 동영상만 사용할 수 있도록 대응한 상태이다.

Protocol을 사용하면 공통적으로 묶을 수 있는 부분에 대한 코드사용 및 기능의 사용을 통일화 시킬 수 있다. 하지만 Protocol Extension을 통해 기본구현을 하게될 경우 해당 Protocol에서 명시하고 있는 프로퍼티들에서만 사용이 가능한데 where Clause와 함께 사용하게 된다면 where Clause를 통해 추가적으로 제한된 기능을 같이 사용할 수 있으므로 extension을 통한 기본구현 사용시 where Clause를 같이 사용하는 것도 좋을 것 같다.

사용한코드: https://github.com/LeeZion94/POPExample.git

<출처>
발표자료 : https://www.slideshare.net/JoSeongGyu/protocol-oriented-programming-in-swift
참고한 예시 코드 : https://bitbucket.org/yagom/popsocialmediaexample/src/master/
참고영상 : https://www.youtube.com/watch?v=9gkzHUsQiUc 
