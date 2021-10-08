## 피드

Feed 메인 View 는 `Home` 과 `Following` 으로 구분하여 `FeedHeader` 에 애니메이션을 적용하여 구분하였습니다.


> ***FeedHeader 에 애니메이션 적용***
> 



뷰 헤더에 필터기능을 줘서 두 섹션을 클릭할 때 애니메이션이 주어지면서 셀의 정보가 바뀌도록 구성합니다.

header View 에 Filter Bar 를 추가해서 뷰를 구성하는데, 총 4가지 file을 만들어 구현했습니다. 

**FeedHeader, FeedFilterView, FeedFilterCell, FeedFilterOptions**



1. **FeedFilterOptions** 에 enum으로 케이스를 나눠줍니다. 각 케이스별 반환할 label을 여기서 설정합니다.

```swift
// CaseIterable -> 모든 case 값들에 대한 컬렉션을 제공하는 타입
enum FeedFilterOptions: Int, CaseIterable {
    case Home
    case Following
    
    var description: String {
        switch self {
        case .Home: return "Home"
        case .Following: return "Following"
        }
    }
}
```



2. **FeedFilterView** 에 들어갈 cell을 따로 만들어줍니다. (**FeedFilterCell**)

- cell안에 들어가 **label**값과 **isSelected**를 bool값으로 줘서 선택했을 때, 폰트사이즈나 텍스트색을 변경

- 그리고 **FeedFilterOptions** 을 프로퍼티값으로 만들어서 didSet 메서드를 통해 프로퍼티 값(label)의 변경 직전 text를 선택된 case 값으로 변경




3. **FeedFilterView** (**FeedHeader** 에 들어갈 filterbar) 안에는 **FeedFilterCell** 을 가져와서 `UICollectionView` 형태로 채워줍니다. 그리고 view 하단에 `layoutSubviews`를 통해 underline을 추가해줘서 애니메이션을 적용합니다.

```swift
// 실제 프레임에 접근하기 위해 layoutSubview 에 넣는다.
override func layoutSubviews() {
    addSubview(underLineView)
    underLineView.anchor(left: leftAnchor, bottom: bottomAnchor, 
													width: frame.width / 2, height: 2)
}
```

또한, 아래와 같은 코드로 프로필 뷰로 넘어갈 때, 첫번째 값이 적용된 상태로 보이게 합니다.

```swift
let selectedFirst = IndexPath(row: 0, section: 0)
collectionView.selectItem(at: selectedFirst, animated: true, 
													scrollPosition: .left)
```

아래의 코드는 **선택된 셀로 넘어갈 때 애니메이션을 적용**하는 코드입니다.

```swift
let cell = collectionView.cellForItem(at: indexPath)
let xPosition = cell?.frame.origin.x ?? 0
UIView.animate(withDuration: 0.1) { self.underLineView.frame.origin.x = xPosition }
```

**FeedFilterView** 에 delegate를 작성하여 **FeedHeader** 에서 선택된 셀의 값을 알 수 있습니다.

```swift
**FeedFilterView**

protocol FeedFilterViewDelegate: AnyObject {
    func filterView(_ view: FeedFilterView, didSelect index: Int)
}
```


---

해당 코드는 `FeedController` 에서 적용한 코드와 시연 영상입니다.

`posts` 와 `followingPosts` 를 `switch case` 문을 통해 반환값을 구분해줍니다.

![image](https://user-images.githubusercontent.com/74236080/135280236-5b5629be-f391-4745-a912-5ac6acb422e4.png)

https://user-images.githubusercontent.com/74236080/135280386-8f1c4972-55d1-4791-b565-92354d7be002.mov


---

> **Home**
>

<img src = "https://user-images.githubusercontent.com/74236080/135280439-2543f5da-7a91-419f-b87a-b90a630f6be9.png" width="30%" height="30%">

- 로그인 후 Main Tap 의 첫번째 View 는 사용자들의 전체 피드가 보여지는 View 입니다.
- Home View 가 로드되는 동시에 `fetchPosts()` 함수를 통해 전체 게시물이 로드됩니다.




게시물은 게시한 시간 순 `timestamp` 으로 구성됩니다.

![image](https://user-images.githubusercontent.com/74236080/135280576-7b77aa91-a5e3-4349-8cd4-766bd14dfdb1.png)



- 홈 피드는 게시물의 **이미지**로만 구성합니다.
![image](https://user-images.githubusercontent.com/74236080/135280628-53f34691-f46c-46fc-a568-84e7673bd986.png)



---

> **Following**
> 

<img src = "https://user-images.githubusercontent.com/74236080/135280697-256e3391-d721-4454-b978-8a1a76e42eff.png" width="30%" height="30%">



- Following View 는 로그인한 사용자가 팔로우한 사용자들의 게시물로만 View 를 구성합니다.
- Following View 가 로드되는 동시에 `fetchFollowingPosts()` 함수를 통해 팔로잉한 사용자의 게시물이 로드됩니다.

![image](https://user-images.githubusercontent.com/74236080/135280765-8bd60842-5437-4b1b-837b-ba5fadc7fdcd.png)



- 팔로잉 피드는 게시물을 게시한 사용자의 프로필 이미지와 이름과 게시물의 이미지로 구성합니다.

> **Following View 에 팔로우한 사용자의 게시물만 가져오기 위해서 Firebase에 각 User에 "following-user-posts"라는 collection을 생성하여 각 User가 Following한 사용자 게시물의 postID를 저장하고 업데이트하는 API코드 작성하였습니다.**
> 

![image](https://user-images.githubusercontent.com/74236080/135280799-ab550bec-2264-4828-a334-c0eceee6acfc.png)




**Firebase ["following-user-posts"] 저장 경로**

![image](https://user-images.githubusercontent.com/74236080/135280846-7574a244-283b-413a-a381-e0f611e15b48.png)

![image](https://user-images.githubusercontent.com/74236080/135280918-348ccb91-2e1e-4662-80fa-6564a2c287a9.png)



### NavigationBar

- navigationBar 의 **왼쪽**은 로그인한 사용자의 프로필을 통해 자신의 `프로필`로 전환할 수 있습니다.
- navigationBar 의 **오른쪽**은 `알림정보`와 `메세지함`으로 전환할 수 있게 했습니다.
