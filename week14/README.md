# 14주차: URLSession

![](https://hackmd.io/_uploads/HJXd60V33.png)
![](https://hackmd.io/_uploads/H1NKp0N3n.png)

![](https://hackmd.io/_uploads/HkGqpRVn3.png)
![](https://hackmd.io/_uploads/H17jp0Vnh.png)

![](https://hackmd.io/_uploads/rke2a0N23.png)
![](https://hackmd.io/_uploads/S1onpC4nn.png)

![](https://hackmd.io/_uploads/r1UTp04n2.png)
![](https://hackmd.io/_uploads/SybCpC43h.png)

![](https://hackmd.io/_uploads/SJTCpCVhh.png)
![](https://hackmd.io/_uploads/H1k4R0Vhn.png)
![](https://hackmd.io/_uploads/rJaN0043n.png)

![](https://hackmd.io/_uploads/H1jBCAN23.png)
![](https://hackmd.io/_uploads/ry6vR0V23.png)
![](https://hackmd.io/_uploads/S1puRRE22.png)
![](https://hackmd.io/_uploads/rk3tCRE2n.png)

![](https://hackmd.io/_uploads/ry2qCCVhn.png)
![](https://hackmd.io/_uploads/rkFjAANn3.png)

![](https://hackmd.io/_uploads/H1j2C0Nnn.png)
![](https://hackmd.io/_uploads/Bk6RRA433.png)
![](https://hackmd.io/_uploads/ryiJJyrh2.png)
![](https://hackmd.io/_uploads/BJPgJyS3h.png)

![](https://hackmd.io/_uploads/r1xWbJ1H3h.png)
![](https://hackmd.io/_uploads/r1Uzk1Bnn.png)

# 14주차: Cache

![](https://hackmd.io/_uploads/H1whE-Whn.png)
![](https://hackmd.io/_uploads/BJahVW-2h.png)
데이터들은 어디에 저장되고 어떻게 사용될까요? 먼저 하드 디스크에 우리의 데이터들이 전부 저장됩니다. 때문에 하드 디스크는 용량이 매우 크고, 기억을 하는 것에 치중되어 있습니다. 
RAM, 메모리는 그러한 하드 디스크에서 앱을 실행하는데에 필요한 중요 데이터들을 들고 있습니다. 그러나 여전히 내용은 방대하고, RAM은 디스크보단 기억할 수 있는 양이 적고, CPU와 가까워서 빠르지만 어찌 되었건 기억을 하는 것에만 능력이 치중되어 있습니다.
CPU는 RAM에서 받은 데이터들을 이용해 앱을 실행합니다. 기억보다는 성능이 중요해, 꾸준하게 성능이 업그레이드 되어 왔습니다. 때문에 RAM과 CPU는 기억과 성능으로 각자의 목적이 다르기에 서로서로 성능차이가 점점 심하게 나게 됩니다. RAM이 CPU를 쫓아가지 못해 CPU가 RAM이 데이터를 찾아서 주기를 기다려야 하는 병목 현상이 발생한 것입니다. 
![](https://hackmd.io/_uploads/H1DyBWZ22.png)
이를 해결하기 위해 완충기의 역할을 하는 캐시 메모리가 등장했습니다. 캐시 메모리는 데이터를 가져오는 속도를 높이고 비용을 낮추기 위해 사용합니다. CPU의 일부라고도 볼 수 있게 작은 칩으로 CPU에 직접 붙어 있거나 연결되어 있습니다.
![](https://hackmd.io/_uploads/S1rZyGZh2.png)
캐시 메모리는 저장할 때 기본적인 규칙이 있습니다. 애초에 캐시라는 개념 자체가 만들어진 이유가 필요한 데이터를 빠르게 가져오기 위해서였기에 앞으로 쓰일 데이터들을 미리 예상하여 캐시에 넣어놓을 때의 규칙으로 컴퓨터의 성능을 향상시키는 역할을 합니다.
시간 지역성
공간 지역성
![](https://hackmd.io/_uploads/H1obsb-3n.png)
지금까지의 캐시 메모리는 하드웨어적으로 존재하는 캐시 메모리에 대한 내용이었습니다. 그러나 캐시는 `자주 사용하는 데이터나 값을 미리 복사해놓는 임시 공간`을 뜻하는 말로 소프트웨어적인 부분에서도 사용될 수 있습니다. 때문에 CPU, 메모리, 디스크 세 곳 어디든 임시 공간을 만들어 데이터를 저장하면 캐시를 저장할 수 있는 것입니다.
![](https://hackmd.io/_uploads/Sk9YnWW33.png)
지금까지 캐시라는 개념에 대해서 알아보았습니다. 다음은 저희가 사용하는 iOS에서 캐싱할 수 있게 해주는 두가지의 클래스이자 캐싱 방식인 NS Cache와 URL Cache입니다.
![](https://hackmd.io/_uploads/SybFKQbn2.png)
먼저 NS Cache입니다. key-value 타입으로 메모리에만 저장되는 메모리 캐싱 방식입니다. 메모리 캐싱이기에 앱을 종료하면 데이터가 날아갑니다. 
![](https://hackmd.io/_uploads/r1DaItMhn.png)
내부에 링크드 리스트처럼 연결되어 있으며 여러가지 설정을 할 수 있는데 이중 눈여겨볼 것으로 totalCostLimit가 있습니다. 캐시는 작은 공간이기에 매번 모든 데이터를 들고 있을 수 없습니다. 때문에 용량이 가득 차면 기존에 있던 것들을 삭제해서 자리를 만들어줘야 합니다. 
![](https://hackmd.io/_uploads/By5C8tz2n.png)
기본적으로 NSCache는 용량이 가득 찼을 때 자동으로 기존 데이터들을 삭제해주는데 이때 어떠한 것부터 삭제할 것인지를 판별하는 기준을 주는 것이 바로 cost입니다. 가장 작은 cost가 제일 불필요한 데이터로 판단해 삭제합니다. 때문에 totalCostLimit를 설정해주었다면 매번 캐시할 때 cost값도 같이 넘겨줘야합니다. 
![](https://hackmd.io/_uploads/BkroPYM33.png)
그러나 이것을 설정해주지 않고 만들었었기에 setObject에서 cost값을 넘겨줄 필요가 없고 이 경우 만일 용량이 가득 차면 NSCache는 캐싱된 Object의 순서대로 자동 삭제합니다.
![](https://hackmd.io/_uploads/Sy1ZuYG3h.png)
다음은 URL Cache입니다. URL Cache는 NS Cache보다 조금 더 나중에 만들어졌어요. 두 가지 큰 차이점이 있는데 NS Cache는 key - value로 data를 넘겨주었다면 URL Cache는 Request를 그대로 사용하여 확인한다는 점입니다. Request에 알맞는 response가 저장되어 있다면 그것을 반환합니다. 또한 메모리 캐싱 뿐만 아니라 디스크 캐싱도 가능해 앱을 종료해도 캐시 데이터가 날아가지 않고 설정에 따라 앱을 삭제해도 데이터를 보존할 수도 있다.
![](https://hackmd.io/_uploads/rkFdFFGh2.png)
shared가 기본구현되어 있기에 이를 사용해서 선언해주었습니다. 이때 캐싱된 데이터들은 메모리와 디스크 중 어디에 저장될까요? 공식 문서에 나와있는 기본 정책 값은 .allowed로 두 위치 모두 사용할 수 있다고 되어 있습니다. 
![](https://hackmd.io/_uploads/H1uTKtfnh.png)
그러나 내부 구현을 보면 두 위치 모두 4 MB, 20 MB로 용량이 할당되어 있습니다. 다만 response가 캐시 용량의 5% 이상인 경우는 저장되지 않고 매번 새로운 request를 보냅니다. 때문에 우리의 이미지는 용량이 1.5MB 정도 되기 때문에 메모리가 아닌 디스크에 저장될 것입니다. 기본적인 디스크 캐시 디렉토리에 하위 디렉토리를 넣어주고 싶다면 nil 대신 diskPath를 만들어 넣어주면 됩니다.
![](https://hackmd.io/_uploads/B1p-qtM3h.png)
request를 넣어 저장된 response가 있다면 해당 response를 사용하여 이미지를 불러옵니다.
![](https://hackmd.io/_uploads/B1145YG3n.png)
그러나 만일 없다면 새롭게 서버에서 받아오며 storeCachedResponse를 이용해 request와 response를 저장합니다.
![](https://hackmd.io/_uploads/HJwd9Yf23.png)
![](https://hackmd.io/_uploads/ryptcYzh2.png)
URL Request에도 캐시 정책을 설정할 수 있습니다. 기본적인 설정은 이 그림과 같습니다.
Q. 그런데 위의 실험에서 제시한 이미지 URL을 URLRequest에 담아서 요청을 할 경우, 이미지가 자동으로 캐싱이 되지 않는 것을 확인할 수 있습니다. 그 이유는 무엇일까요? -> 해결 못 함.
![](https://hackmd.io/_uploads/SJ_EsFz23.png)
지금까지 캐시에 대해서 알아보았습니다. 성능 향상을 위해 자주 사용하거나 최근 사용하거나 사용할 것 같은 데이터들을 임시 공간에 저장하는 내용이었습니다. 이처럼 목적은 조금 다르지만 일부의 정보를 저장하는 방법에는 다른 것들도 있습니다. 
![](https://hackmd.io/_uploads/H1cFjFGh2.png)
먼저 쿠키입니다. HTTP는 Stateless라고 합니다. 이는 클라이언트가 누구인지, 어떤 상태인지에 대한 정보를 포함하지 않는다는 뜻입니다. 때문에 클라이언트가 누구인지를 서버가 알 수 있게 쿠키가 등장했습니다. 한번이라도 해당 서버에 클라이언트가 접근한다면 서버는 response에 쿠키를 들려서 보냅니다. 클라이언트는 해당 쿠키를 가지고 있으면서 기본적인 정보, 설정 등이 쿠키에 저장됩니다. 추후에 서버에 클라이언트가 요청을 할 때 자동으로 쿠키도 함께 요청을 통해 서버로 넘어갑니다. 서버는 해당 쿠키를 받고 기존에 접속했던 사용자임과 동시에 어떠한 설정을 해놓았는지 알게 됩니다.
![](https://hackmd.io/_uploads/Sky2pFz22.png)
그러나 쿠키는 브라우저에서만 사용가능하기 때문에 브라우저를 사용하는 것이 아닌 네이티브 앱에서는 사용할 수 없습니다.
![](https://hackmd.io/_uploads/Hkt_g5znh.png)
참고로 저희가 사용하는 URL Session에서도 쿠키 정책을 가지고 있습니다.
![](https://hackmd.io/_uploads/SJe6atMnh.png)
이러한 쿠키의 단점을 어느 정도 해결하는 친구들이 등장했습니다. 클라이언트만 알고 있게 하는 Web Storage와 서버만 알고 있게 하는 Session입니다. Web Storage는 클라이언트에 저장만 할 뿐 매번 다시 서버에 전송하는 쿠키와 다르게 서버에는 전송하지 않습니다. 저장 용량도 5MB로 더 큽니다. 다만 독립된 storage로 각각 공유할 수가 없고 만료 기간을 설정해 줄 수도 없습니다. 
![](https://hackmd.io/_uploads/SJELAYf32.png)
앞서 쿠키는 클라이언트가 수정할 수 있는 정보입니다. 그러나 어떠한 결제를 했었고와 같은 중요한 정보들은 서버만 알고 있어야 하는 경우가 있습니다. 이런 경우를 위해 서버에서만 알고 있는 Session을 사용합니다. Session은 서버에 Session DataBase라는 저장공간을 만듭니다. 이곳에는 사용자들에 대한 중요한 정보들이 있습니다. 클라이언트가 아이디와 비번을 쳐서 로그인하면 Session DataBase에 사용자에 대한 정보가 생성됩니다. 그리고 이 세션 id를 쿠키에 들려서 클라이언트에게 보냅니다. 클라이언트는 오직 이 세션 id만 알고 있게 됩니다. 그러나 다시 서버에 요청을 할 때 클라이언트는 쿠키에 세션 id를 같이 보내게 되고 이 세션 id를 보고 서버는 세션 DB에서 클라이언트의 정보를 찾아 사용합니다.
![](https://hackmd.io/_uploads/rytSg9M2n.png)
그러나 Session은 DB가 필요한 만큼 수없이 많은 유저 정보를 만들어줄 수는 없습니다. 비용이 매우 많이 들게 되기 때문입니다. 
![](https://hackmd.io/_uploads/HyElmczh3.png)
이러한 점들을 보완한 것이 토큰입니다. 토큰은 서버가 DB를 가지고 있지 않습니다. 쿠키처럼 클라이언트가 정보를 가지고 있는데 특수한 처리가 되어 있는 것입니다. 클라이언트가 로그인해서 생겨난 유저 data를 서버는 사인을 해서 클라이언트에 보냅니다. 암호화하는 것은 아닙니다. 중간에 가로채거나 했을 때 데이터를 전부 확인할 수 있습니다. 다만 변경할 수 없습니다. 내용을 변경하게 되면 사인의 유효성을 검사했을 때 통과할 수 없습니다. 때문에 서버는 단순히 토큰의 유효성을 검사만 할 뿐 저장하고 있지는 않게 되서 비용이 적게 듭니다.
![](https://hackmd.io/_uploads/S1e3X5z33.png)
![](https://hackmd.io/_uploads/S1f3YvNhh.png)
지금까지 캐시, 쿠키, 세션, 토큰 등 다양한 저장 및 인증방식에 대해 알아보았습니다. 감사합니다~


### 참고자료
[🍎 NS Cache](https://developer.apple.com/documentation/foundation/nscache)
[📖 NS Cache](https://github.com/apple/swift-corelibs-foundation/blob/main/Sources/Foundation/NSCache.swift)
[🍎 URL Cache](https://developer.apple.com/documentation/foundation/urlcache)
[📖 URL Cache](https://github.com/apple/swift-corelibs-foundation/blob/main/Sources/FoundationNetworking/URLCache.swift)
[캐시메모리](https://www.techtarget.com/searchstorage/definition/cache-memory)
