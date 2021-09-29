# 🎨 미대생 홍보앱

> 스토리보드 없이 코드로만 작성했습니다.

> MVVM 패턴으로 작성했습니다.

> DB관리는 Firebase를 이용했습니다.

---

<img width="875" alt="View" src="https://user-images.githubusercontent.com/74236080/127725022-90b0a5e4-dac3-441f-914e-e4c32bc7ecb1.png">

***주요 기능 및 시연 영상 등 자세한 내용은 링크에 있습니다.***

[미대생 홍보앱 포트폴리오](https://www.notion.so/dfff8b5b6d994661b75e4c7482b14eed)


### ⚒  사용 기술
---
- Swift
- CocoPods
- Firebase
- Figma

### 💁‍♂️  상세 내용
---
***사용 대상***

- 미대생 또는 무명디자이너

***문제 의식***

- 음원사이트에서 무명의 아티스트의 음악을 쉽게 접할 수 없기에 [사운드 클라우드]와 같은 앱을 통해 접할 수 있는 것과 같이 미대생, 무명 디자이너의 작품을 쉽게 접할 수 있는 앱

***기대 효과***

- 댓글을 통해 서로의 작품을 피드백하고 감상하면서 소통을 할 수 있습니다.
- 기업 관계자들이나 관련 직종의 사용자들이 무명의 사람들의 작품을 보고 기업과 연결 또는 스카웃을 하는데 도움을 줄 수 있습니다.

---

### 💁🏻  기능 소개

- [로그인, 회원가입](#1-로그인-회원가입)
- [피드](#2-피드)
- [검색](#3-검색)
- [업로드](#4-업로드)
- [프로필](#5-프로필)
- [알림](#6-알림)
- [게시물](#7-게시물)
- [메세지](#8-메세지)



## 로그인, 회원가입
> **Firebase를 사용하여 사용자 등록 및 인증**
> 
> ***로그인***
> 
<img src = "https://user-images.githubusercontent.com/74236080/135277223-a33c6e3e-6aca-4ae9-959c-07e0cda1dcfe.png" width="30%" height="30%">

- 앱 실행 시 로그인 View 가 로드됩니다. 로그인 View 에는 id/password 에 대한 두 개의 TextField 가 있습니다.
- 아래에는 TextField 에 채워진 정보로 Firebase 에 등록된 사용자를 확인하고, 메인탭으로 전환을 하는 로그인 버튼이 있습니다.
- 로그인 버튼 아래에는 회원가입 View 로 전환하는 버튼이 있습니다.

### Firebase 등록된 사용자 목록

![image](https://user-images.githubusercontent.com/74236080/135277297-907b31e9-240e-40be-b71f-96322b6cec66.png)


`LoginController` 안에서 로그인 버튼을 눌렀을 때, `JGProgressHUD` 프레임워크를 사용하여 사용자 확인과정이 끝날때까지 로딩뷰가 생성됩니다. 

`AuthDataResultCallback` 을 통해 로그인 이벤트가 완료되면 `signIn` 으로 로그인 처리를 진행합니다.

![image](https://user-images.githubusercontent.com/74236080/135277366-ed66ade2-b457-4dfd-a0ec-2d7d6b46f194.png)

![image](https://user-images.githubusercontent.com/74236080/135277454-28fcca1a-89fc-47a5-8ba0-ad039d2f5f63.png)

로그인 성공 후 MainTap 으로 전환하기 위해 `MainController` 에서 `checkIfUserIsLoggedIn()` 함수를 호출하여 유저의 정보를 불러와 MainView 를 구성합니다.

앱을 다시 실행하였을 때 `Auth.auth().currentUser == nil` 의 조건을 통해 현재 사용자가 로그인 되어있지 않다면 로그인화면으로 전환합니다.

![image](https://user-images.githubusercontent.com/74236080/135277517-db5d3cc3-1088-4251-bfdc-feae6aed20a9.png)

### 로그인 키보드 높이 조절

`LoginkeyboardMoves` 함수를 통해 Textfield 를 Tap 하면 `keyboardSize.height - 100` 만큼 `view.frame.origin.y` 를 올려줍니다.

![image](https://user-images.githubusercontent.com/74236080/135277557-b9c14944-cd34-48aa-8d73-36cfb9bcd27e.png)

입력을 마친 뒤 화면을 Tap 하거나 키보드를 닫으면 원상태로 돌아옵니다.

![image](https://user-images.githubusercontent.com/74236080/135277628-0c46ef6c-8ac2-4ec6-addf-32978758a435.png)

> ***회원가입***
> 
<img src = "https://user-images.githubusercontent.com/74236080/135277667-23a39922-e4aa-43f7-bff5-68154612f010.png" width="30%" height="30%">

- 회원가입 View 는 프로필 이미지 등록을 위한 Photo 버튼과 이름, 전공, 이메일, 비밀번호를 입력할 Textfield 로 구성됩니다.
- Textfield 가 채워지면 회원가입 버튼을 통해 Firebase 에 사용자를 등록하고, MainTapView 로 전환됩니다.
- 이미 계정이 있다면 `이미 계정이 있으신가요?` 버튼을 통해 로그인 화면으로 전환됩니다.

- Photo 버튼을 클릭하면 `UIImagePickerController` 객체를 생성 `present` 로 `UIImagePickerController` 객체를 띄우고, 앨범에 접근합니다.

![image](https://user-images.githubusercontent.com/74236080/135277703-162633e6-1bd6-447f-8a85-2ae64dbacba6.png)

1️⃣  앨범에서 이미지 선택

2️⃣  `setImage` 함수를 이용하여 선택한 이미지 삽입 (Photo 버튼 Frame 사이즈에 맞게)

3️⃣  앨범 화면 `dismiss`

![image](https://user-images.githubusercontent.com/74236080/135277745-0844c1e6-265f-4ec3-b332-68f84c4be83e.png)

- 그런 다음, TextField 를 정보에 맞게 작성한 뒤 회원가입 버튼을 눌러 Firebase 에 사용자 등록을 진행합니다.

![image](https://user-images.githubusercontent.com/74236080/135277793-76751753-60de-4a34-af38-eb2398459cb3.png)

- 앨범에서 선택한 UIImage 를 Firebase Storage 에 저장합니다.

각 이미지를 JPEG 데이터로 변환한 뒤, 고유의 값 `UUID` 을 지정하여 `/profile_images/` 경로에 파일이름을 저장합니다.

<img src = "https://user-images.githubusercontent.com/74236080/135277843-d45ed780-1697-459f-9181-d25c3713780b.png" width="30%" height="30%">

![image](https://user-images.githubusercontent.com/74236080/135277892-e348808a-e9c7-48b5-8703-5bb76f2aa82b.png)
- 저장된 이미지 url 을 포함하여 나머지 값도 Data 형식에 맞춰 Firebase 에 새로운 사용자 정보를 등록합니다.
- 그리고 위의 로그인 과정과 동일하게 사용자 정보를 확인하여 MainTap 으로 전환합니다.

![image](https://user-images.githubusercontent.com/74236080/135277970-f1794963-ef6d-4adb-bbf5-2ef833b44a7b.png)

### 회원가입 키보드 높이 조절

회원가입 화면은 로그인 화면과 다르게 키보드를 올릴 때, `view.frame.origin.y` 를 같이 올리지 않고 작성을 마친 뒤 화면을 Tap 했을 때, 키보드 창이 사라지도록 했습니다.

![image](https://user-images.githubusercontent.com/74236080/135278025-d5ab62ae-76ea-4083-8d10-45a6f8bef594.png)


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

1. **FeedFilterView** 에 들어갈 cell을 따로 만들어줍니다. (**FeedFilterCell**)

- cell안에 들어가 **label**값과 **isSelected**를 bool값으로 줘서 선택했을 때, 폰트사이즈나 텍스트색을 변경

- 그리고 **FeedFilterOptions** 을 프로퍼티값으로 만들어서 didSet 메서드를 통해 프로퍼티 값(label)의 변경 직전 text를 선택된 case 값으로 변경

2. **FeedFilterView** (**FeedHeader** 에 들어갈 filterbar) 안에는 **FeedFilterCell** 을 가져와서 `UICollectionView` 형태로 채워줍니다. 그리고 view 하단에 `layoutSubviews`를 통해 underline을 추가해줘서 애니메이션을 적용합니다.

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

**FeedFilterView** 에 delegate를 작성하여 **FeedHeader** 에서 선택된 셀의 값을 알 수 있다.

```swift
**FeedFilterView**

protocol FeedFilterViewDelegate: AnyObject {
    func filterView(_ view: FeedFilterView, didSelect index: Int)
}
```

해당 코드는 `FeedController` 에서 적용한 코드와 시연 영상입니다.

`posts` 와 `followingPosts` 를 `switch case` 문을 통해 반환값을 구분해줍니다.

![image](https://user-images.githubusercontent.com/74236080/135280236-5b5629be-f391-4745-a912-5ac6acb422e4.png)

https://user-images.githubusercontent.com/74236080/135280386-8f1c4972-55d1-4791-b565-92354d7be002.mov

> **Home**
>

<img src = "https://user-images.githubusercontent.com/74236080/135280439-2543f5da-7a91-419f-b87a-b90a630f6be9.png" width="30%" height="30%">

- 로그인 후 Main Tap 의 첫번째 View 는 사용자들의 전체 피드가 보여지는 View 입니다.
- Home View 가 로드되는 동시에 `fetchPosts()` 함수를 통해 전체 게시물이 로드됩니다.

게시물은 게시한 시간 순 `timestamp` 으로 구성됩니다.

![image](https://user-images.githubusercontent.com/74236080/135280576-7b77aa91-a5e3-4349-8cd4-766bd14dfdb1.png)

- 홈 피드는 게시물의 **이미지**로만 구성합니다.
![image](https://user-images.githubusercontent.com/74236080/135280628-53f34691-f46c-46fc-a568-84e7673bd986.png)

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




