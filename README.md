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

- [로그인, 회원가입](#로그인,회원가입)
- [피드](#피드)
- [검색](#검색)
- [업로드](#업로드)
- [프로필](#프로필)
- [알림](#알림)
- [게시물](#게시물)
- [메세지](#메세지)



## 로그인,회원가입
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

![image](https://user-images.githubusercontent.com/74236080/135277843-d45ed780-1697-459f-9181-d25c3713780b.png)

![image](https://user-images.githubusercontent.com/74236080/135277892-e348808a-e9c7-48b5-8703-5bb76f2aa82b.png)

- 저장된 이미지 url 을 포함하여 나머지 값도 Data 형식에 맞춰 Firebase 에 새로운 사용자 정보를 등록합니다.
- 그리고 위의 로그인 과정과 동일하게 사용자 정보를 확인하여 MainTap 으로 전환합니다.

![image](https://user-images.githubusercontent.com/74236080/135277970-f1794963-ef6d-4adb-bbf5-2ef833b44a7b.png)

### 회원가입 키보드 높이 조절

회원가입 화면은 로그인 화면과 다르게 키보드를 올릴 때, `view.frame.origin.y` 를 같이 올리지 않고 작성을 마친 뒤 화면을 Tap 했을 때, 키보드 창이 사라지도록 했습니다.

![image](https://user-images.githubusercontent.com/74236080/135278025-d5ab62ae-76ea-4083-8d10-45a6f8bef594.png)


---

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


---

## 검색

<img src = "https://user-images.githubusercontent.com/74236080/135281781-6a932ff5-5b30-4a1e-846e-708647876e63.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135281802-563ed5d0-057e-4a40-8241-d8b62789086b.png" width="30%" height="30%">

> **검색 화면은 `TableView` 로 구성하여 navigationBar 에 Search Bar 를 추가해서 검색기능을 구현하였습니다.**
> 

![image](https://user-images.githubusercontent.com/74236080/135282165-564da0de-225a-4388-8fb5-bf9cb09e4fb9.png)


> **`filterUsers` 프로퍼티를 만들어서 사용자의 이름과 전공에 포함되는 단어를 필터하여 사용자를 찾을 수 있게 구현하였습니다.**
> 

![image](https://user-images.githubusercontent.com/74236080/135282225-3bb91e72-f460-41f3-b00a-996a7d9b320c.png)

![image](https://user-images.githubusercontent.com/74236080/135282268-210390a3-68d5-4eb1-8857-9f9f864e4f6d.png)

![image](https://user-images.githubusercontent.com/74236080/135282311-15ea6486-e33e-456e-8924-9be81652936f.png)

> **로그인한 사용자는 목록에서 제거해주었습니다.**
> 

![image](https://user-images.githubusercontent.com/74236080/135282348-00730e29-5b0f-4206-9329-f8645217c2a1.png)


---

## 업로드

> **`YPImagePicker` 라이브러리를 사용하여 이미지 업로드**
>

<img src = "https://user-images.githubusercontent.com/74236080/135282578-836b1185-546e-4f34-9036-c05544ce2e33.png" width="30%" height="30%">

1️⃣ Main Tap Bar 에서 `+` 를 클릭하면 **앨범의 접근을 요청**합니다.

info.plist 에서 `Privacy - Photo Library Usage Description` 를 추가해줍니다.

![image](https://user-images.githubusercontent.com/74236080/135282731-26fa8f09-4a7f-4730-ace0-99abffdd10b1.png)

> **[MainTapController]에서 `UITabBarControllerDelegate` 메소드를 호출합니다.**
> 

![image](https://user-images.githubusercontent.com/74236080/135283108-4460ad59-01c6-48ed-885e-fbe60a2ac6ad.png)

<img src = "https://user-images.githubusercontent.com/74236080/135283176-a6e09934-216a-4b05-baca-a1fd27cb0bdf.png" width="30%" height="30%">

2️⃣   `YPImagePicker` 라이브러리를 통해 이미지를 가져와 필터와 자르기 기능을 사용할 수 있습니다.

<img src = "https://user-images.githubusercontent.com/74236080/135283285-e2bf8986-1f54-4d89-9e89-bb55b59ce109.png" width="30%" height="30%">

3️⃣   필터와 자르기 등 이미지 선택을 마치면 `upload View` 로 전환됩니다.

- `upload View` 는 선택한 이미지와 작품명과 작품을 소개하는 TextField 로 구성됩니다.
- TextField 의 작성을 마치면 `Share` 버튼을 통해 Firebase 에 게시물을 저장하고, Feed 로 화면이 전환되면서 게시물을 업로드합니다.

입력을 마친 뒤 `Share` 버튼을 누르면 로딩 뷰가 생성되고, PostService 의 `uploadPost` 함수를 호출합니다.

![image](https://user-images.githubusercontent.com/74236080/135283363-ac97099d-3402-4672-a63f-673f64ebd70c.png)

이미지를 포함한 데이터를 저장한 뒤 `Firebase_Post` 컬렉션에 데이터를 추가합니다.
또한, 팔로잉한 유저의 게시물에도 추가해서, `Following-Feed` 에도 업로드되도록 합니다.

![image](https://user-images.githubusercontent.com/74236080/135283434-19c07c49-8bcd-4884-917d-caeda5330744.png)

![image](https://user-images.githubusercontent.com/74236080/135283473-fd7a66c5-2919-4af6-88e9-7148b6fc10c9.png)


---

## 프로필

### 로그인한 사용자 프로필


<img src = "https://user-images.githubusercontent.com/74236080/135283774-40f54d7c-cf5e-4e8b-ac86-2c7a21fd6a2c.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135283818-316ef383-a7f2-4774-8a8f-cf1183f319b5.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135283839-0c30c0a3-6822-4d85-8a90-bed7b518465b.png" width="30%" height="30%">


- 로그인한 사용자의 프로필 View 는 **프로필을 편집**할 수 있는 View 와 **메세지함** View 로 전환할 수 있는 버튼으로 구성됩니다.
- 프로필 View 로 전환이 되면 해당 사용자의 `uid` 를 통해 해당 사용자의 게시물을 로드합니다.
    
    **새로고침** `collectionView.refreshControl?.endRefreshing()`

![image](https://user-images.githubusercontent.com/74236080/135283959-2a7be352-5f9d-46c0-846d-e173111300e3.png)



### 다른 사용자의 프로필

<img src = "https://user-images.githubusercontent.com/74236080/135284066-98a7c773-8b8c-437c-94aa-27d8373368eb.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135284106-a0d38c61-345d-4142-8f0f-dcf326289b2e.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135284085-87eac7f9-248a-4217-be2c-92f622cd8e23.png" width="30%" height="30%">

- 로그인한 사용자가 다른 사용자의 프로필을 들어가면,  **팔로우 / 언팔로우** 기능을 가진 버튼과 해당 사용자와의 **채팅창으로 전환**할 수 있는 버튼으로 구성됩니다.
- 다른 사용자의 프로필로 갔을 때, **팔로우 / 언팔로우** 기능을 위해 현재 프로필 `user.uid` 를 통해 `isFollowed 의 Bool 값`으로 팔로우 여부를 확인합니다.
    
![image](https://user-images.githubusercontent.com/74236080/135284216-108a224c-4b93-4580-a2bc-fa13564e4205.png)

![image](https://user-images.githubusercontent.com/74236080/135284248-b44c9baa-4a3b-4bcf-a965-daca1437454c.png)
    


- 프로필의 팔로우와 언팔로우의 수를 체크해서 UI 에 띄웁니다.

![image](https://user-images.githubusercontent.com/74236080/135284302-3d72f60e-3ce6-4b2d-bacd-a0905fc0ccaf.png)
![image](https://user-images.githubusercontent.com/74236080/135284318-0bb5de68-d752-4843-b9fc-d3daa5d6f730.png)


- `ProfileHeaderDelegate` 를 연결하여 로그인한 사용자의 프로필과 아닌 프로필을 구분해서 기능을 구현했습니다.
    
    

> **프로필 편집 / 팔로우**
> 

![image](https://user-images.githubusercontent.com/74236080/135284376-b191dab3-e6f8-4623-88fb-5ab1958db1f2.png)


> **메세지 함 / 로그인한 사용자와의 채팅 View**
> 

![image](https://user-images.githubusercontent.com/74236080/135284422-3576413d-ae87-474e-a07e-03b602c9826f.png)

---

### 프로필 편집

편집 기능을 구현하기 전 **게시물**이나 **알림** 기능을 구현할 때, 데이터를 `User` 로 설정하지 않고, `user.profileImage`, `user.name` ,,, 이런 식으로 설정을 해놔서 업데이트 코드를 짜는 과정에서 시간이 많이 지체 되었습니다.

애초에 앱 출시 목적이 아닌 기능을 구현해보는 공부과정으로 시작했기에 전체 코드를 엎기보단 **update** 코드를 작성해주는 방법으로 코드를 작성하였습니다.

- 우선 프로필 이미지나 사용자 정보 중 하나만 입력되더라고 편집 기능이 실행 될 수 있도록 경우의 수를 나누어 주었습니다.

1️⃣  프로필 이미지만 변경

2️⃣  사용자 정보만 변경

3️⃣  프로필 이미지와 사용자 정보 둘다 변경

![image](https://user-images.githubusercontent.com/74236080/135284547-214c245b-a871-4b44-9c32-e315d4adf22c.png)

![image](https://user-images.githubusercontent.com/74236080/135284578-9fbb74cd-e8e8-4fa8-8779-f0a8434e4852.png)

**사용자 정보 업데이트**

saveUserData() 를 호출하면, 사용자의 `name`, `major`, `bio` 데이터를 업데이트합니다.

게시물과 알림 각각 코드에 `whereField` 를 사용하여 `uid` 와 동일화시켜서 게시물과 알림의 user 정보도 같이 업데이트 해줍니다.

![image](https://user-images.githubusercontent.com/74236080/135284605-7cde55c4-d4e9-4bc9-b47c-855cd08f8037.png)

**프로필 이미지 변경**

사용자 정보를 업데이트시키는 방식과 같이 프로필 이미지도 업데이트하는 코드를 작성하였으나, 업데이트가 밀리는 오류가 생겨서 수정중에 있습니다.

![image](https://user-images.githubusercontent.com/74236080/135284634-f5fd27c3-a2e5-4537-81d7-eb57f50e11ca.png)



### **로그아웃**

<img src = "https://user-images.githubusercontent.com/74236080/135284768-9ae72168-7b4e-42fc-aaac-300f3ad82504.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135284792-e9596731-c25e-46c1-9d97-2dd22bcd30aa.png" width="30%" height="30%">

> 편집 View 의 **Footer** **View** 에 로그아웃 버튼을 생성하여 로그아웃 기능을 구현하였습니다.
> 

1. FooterView - **Protocol** 생성

![image](https://user-images.githubusercontent.com/74236080/135284873-128e389c-c32e-4e6d-b4b5-27cc82ba21dd.png)


2. 편집 VC 에 [EditProfileFooterDelegate] **Protocol** 을 채택하여 **로그아웃** **actionSheet** 띄우기

![image](https://user-images.githubusercontent.com/74236080/135284919-bac40fb5-76b5-4006-8929-4d45f1b89f7c.png)

로그아웃을 눌렀을 때, 편집 View 가 닫히고 로그인 View 로 이동하기 위해 
편집 VC 에 **새로운 Protocol 을 생성**하였습니다.

3. [EditProfileControllerDelegate] **Protocol** 생성

- **handleLogout** 추가

편집 View 가 사라지고, **handleLogout()** 실행

```swift
self.dismiss(animated: true) { self.delegate?.handleLogout() }
```

![image](https://user-images.githubusercontent.com/74236080/135285003-ad83b310-5d22-4dc2-8a61-420c364336e4.png)

4. 프로필 VC 에 **Protocol** 을 채택하여 **handleLogout()** 실행

![image](https://user-images.githubusercontent.com/74236080/135285049-ff3348ef-8e10-4830-bcef-16637ec70245.png)

https://user-images.githubusercontent.com/74236080/135285170-44893043-debb-492d-b63d-3e859cff7c6a.mov






