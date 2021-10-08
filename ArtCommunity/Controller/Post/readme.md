## 게시물


<img src = "https://user-images.githubusercontent.com/74236080/135287267-f1998996-30b0-43fb-9113-097a04d08fed.png" width="30%" height="30%">


- `게시물 이미지`, `작품 제목`, `작품 소개`, `댓글`, `좋아요`, `게시한 시간`, `게시한 사용자 프로필이미지`, `이름` 으로 구성되어있습니다.
- 좋아요 버튼을 누르면 하트는 빨간색으로 바뀌고, 카운트 수가 UI 에 띄워집니다.
- 댓글 또한 댓글을 작성하면 댓글 카운트가 세집니다.
- 아래 프로필 이미지와 이름은 해당 게시물을 올린 사용자의 프로필로 이동할 수 있습니다.



<img src = "https://user-images.githubusercontent.com/74236080/135287380-7d3931f8-ae54-40de-874e-3a9f59e4efa3.png" width="30%" height="30%">


- 헤더 View 에는 해당 게시물의 정보를 띄우고, Cell 은 댓글을 단 사용자의 정보와 댓글을 띄웁니다.
- 해당 View 에 `InputTextView` 를 추가해서 댓글기능을 구현합니다.

---

### InputTextView 구현

1. UIView (CommentInputAccesoryView) 를 생성하여 `InputTextView` 와 `UIButton` 을 배치합니다.
- UI 구성에서 comment줄과 inputAccesoryView가 겹치지 않게 백그라운드 색상을 **white** 로 설정합니다.
- 그리고 키보드를 열고 내리면서의 높이 변화와 장치의 화면에 따라 유연하게 변형하는 코드도 추가합니다.


![image](https://user-images.githubusercontent.com/74236080/135287465-fead0dde-9229-473b-9d05-e401d4006d67.png)

- Cell 과 구분을 두기 위한 선을 추가해줍니다.


![image](https://user-images.githubusercontent.com/74236080/135287488-1336e3d9-141a-41e9-ba88-32c42969cc6a.png)


2. CommentController 로 넘어와서 InputTextView 의 `frame` 을 잡아줍니다.
    
![image](https://user-images.githubusercontent.com/74236080/135287528-115b8ca1-bfc8-4a9e-9e0d-c0d7068fba28.png)
    

Main Tab Bar 를 사라지게 하고 InputTextView 로 띄울 수 있게 화면이 나타날 때 Tab Bar 를 숨기고, 화면이 사라질 때 Tab Bar 를 띄웁니다.


![image](https://user-images.githubusercontent.com/74236080/135287596-22c98d17-cc0e-47b3-8c11-fc2a614e9d1d.png)

3. CommentInputAccesoryView 에 Protocol 을 생성하여, CommentVC 에 **Protocol** 을 채택해 댓글 데이터를 Firebase 에 저장합니다.

![image](https://user-images.githubusercontent.com/74236080/135287643-76445f59-9ae4-4032-8130-e94b1c77e4b4.png)



- Firebase 에 저장하는 데이터 형식은 다음과 같습니다.

![image](https://user-images.githubusercontent.com/74236080/135287686-fb8c255f-f9f0-4fa8-a8ae-f5af1a87d1df.png)


- 댓글을 게시하고 난 뒤, text 는 없앱니다.

```swift
inputView.clearCommentTextView()
```

![image](https://user-images.githubusercontent.com/74236080/135287715-6f0594bc-9c05-4868-8f9a-5cc3a9a3fd8d.png)



---

**사용자가 댓글을 게시하는 순간 Cell 에 추가할 수 있도록 구현합니다.**

CommentVC 를 로드할 때, 해당 게시물의 댓글을 가져옵니다.

![image](https://user-images.githubusercontent.com/74236080/135287756-349467c8-e57d-477e-9790-311ed5a9632c.png)



해당 게시물에 `comments` 컬렉션을 생성하여 시간순으로 데이터를 저장합니다.

```swift
let query = COL_POSTS.document(postID).collection("comments")
						.order(by: "timestamp", descending: true)
```

해당 쿼리는 Firebase 에서 데이터의 변경을 감지하는 **addSnapshotListener** 을 사용하여 즉시 Cell 에 반영할 수 있도록 합니다.

**addSnapshotListener**

> 해당 댓글을 수신한 다음 해당 댓글을 기반으로 UI를 업데이트합니다.
API 호출을 수동으로 수행할 필요없이 데이터베이스에 추가되는 즉시 새로운 comment가 데이터를 새로고침하기 위해 포스트하는 것과 같습니다.
>


![image](https://user-images.githubusercontent.com/74236080/135287817-080aad67-ea97-4492-8a1e-2f76392fd368.png)



https://user-images.githubusercontent.com/74236080/135287862-22d06441-f807-4077-b1ca-9f088f8d0713.mov

