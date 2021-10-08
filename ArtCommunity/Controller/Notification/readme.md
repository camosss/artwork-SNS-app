## 알림

알림의 기능은 A가 B의 게시물에 **댓글, 좋아요, 팔로잉** 했을 때, B의 계정에 알림이 뜨도록 구현합니다.

```swift
// 로그인한 계정 A
guard let currentUid = Auth.auth().currentUser?.uid else { return }

// 알림을 받을 계정 B
guard postOwnerUid != currentUid else { return }
```

![image](https://user-images.githubusercontent.com/74236080/135286753-e0136a26-7dfd-43a6-ad1e-a3bf678a0b07.png)



---

1️⃣    **댓글** 

**CommentController** 에서 댓글 `게시` 버튼을 누르면,  `post.ownerUid` 의 사용자에게 알림

![image](https://user-images.githubusercontent.com/74236080/135286781-82831dfc-139d-42f5-99ce-f9db35681822.png)




2️⃣    **좋아요**

**PostController** 에서 ❤️  을 누르면, `post.ownerUid` 의 사용자에게 알림

![image](https://user-images.githubusercontent.com/74236080/135286819-cd498f65-9df7-4861-a69b-671e96dcc95a.png)




3️⃣    **팔로우**

ProfileController 에서 팔로우 버튼을 누르면, 해당 사용자의 `user.uid` 의 사용자에게 알림

![image](https://user-images.githubusercontent.com/74236080/135286847-932999bb-e17b-46bc-b959-b5f72c7f8acf.png)





---

### PostOwnerUid

- 알림 View 로 이동을 하면, 해당 사용자에게 저장된 알림들이 로드됩니다. (시간순 `timestamp`)


![image](https://user-images.githubusercontent.com/74236080/135286872-1a05bc9c-59ca-41a6-a1be-1a7ff992e8ff.png)

![image](https://user-images.githubusercontent.com/74236080/135286902-1411a8f9-a5fb-4eb2-85ae-28665b55a979.png)



- 다른 사용자가 해당 사용자에게 팔로우를 했다는 알림이 있으면, **그 사용자에 대한 팔로우 여부를 체크**하여 팔로우 / 언팔로우 할 수 있습니다.

![image](https://user-images.githubusercontent.com/74236080/135286916-78a3bf3f-00da-431f-bbd7-44a4678ba244.png)

---


<img src = "https://user-images.githubusercontent.com/74236080/135286973-b763f743-3bbf-44d1-92e5-7697977bbd89.png" width="30%" height="30%">


> **알림 타입을 [좋아요] [팔로우] [댓글]로 구분**
> 

> **알림 타입에 따른 화면 전환**
> 
- [좋아요] 알림 → 해당 게시물
- [팔로우] 알림 → 해당 사용자의 프로필
- [댓글] 알림 → 해당 게시물의 댓글

> **버튼 기능 구분**
> 
- 프로필 이미지 → 해당 사용자 프로필
- 팔로우 버튼
- 게시물 이미지 → 해당 게시물



1. **알림 타입을 [좋아요] [팔로우] [댓글] 을 Enum 타입으로 구분**

![image](https://user-images.githubusercontent.com/74236080/135287102-04039ba2-644a-454e-9226-05ce2a3a2eec.png)



2. **알림 타입에 따른 화면 전환**
    
    
![image](https://user-images.githubusercontent.com/74236080/135287137-9e83d06c-ecf0-4138-9d0a-81a41907fe23.png)


    

3. **버튼 기능 구분**

![image](https://user-images.githubusercontent.com/74236080/135287171-ab9c3a9f-105e-40ab-b8d7-837b83a525e7.png)
