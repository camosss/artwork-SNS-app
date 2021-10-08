## 프로필

### 로그인한 사용자 프로필


<img src = "https://user-images.githubusercontent.com/74236080/135283774-40f54d7c-cf5e-4e8b-ac86-2c7a21fd6a2c.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135283818-316ef383-a7f2-4774-8a8f-cf1183f319b5.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135283839-0c30c0a3-6822-4d85-8a90-bed7b518465b.png" width="30%" height="30%">


- 로그인한 사용자의 프로필 View 는 **프로필을 편집**할 수 있는 View 와 **메세지함** View 로 전환할 수 있는 버튼으로 구성됩니다.
- 프로필 View 로 전환이 되면 해당 사용자의 `uid` 를 통해 해당 사용자의 게시물을 로드합니다.
    
    
    
    
    **새로고침** `collectionView.refreshControl?.endRefreshing()`

![image](https://user-images.githubusercontent.com/74236080/135283959-2a7be352-5f9d-46c0-846d-e173111300e3.png)


---


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
    
    
---


> **프로필 편집 / 팔로우**
> 

![image](https://user-images.githubusercontent.com/74236080/135284376-b191dab3-e6f8-4623-88fb-5ab1958db1f2.png)

---


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


---

### 로그아웃

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
