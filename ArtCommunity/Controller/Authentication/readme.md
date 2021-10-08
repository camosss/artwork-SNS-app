
## 로그인,회원가입
**Firebase를 사용하여 사용자 등록 및 인증**

> ***로그인***


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

---

### 로그인 키보드 높이 조절

`LoginkeyboardMoves` 함수를 통해 Textfield 를 Tap 하면 `keyboardSize.height - 100` 만큼 `view.frame.origin.y` 를 올려줍니다.

![image](https://user-images.githubusercontent.com/74236080/135277557-b9c14944-cd34-48aa-8d73-36cfb9bcd27e.png)

입력을 마친 뒤 화면을 Tap 하거나 키보드를 닫으면 원상태로 돌아옵니다.

![image](https://user-images.githubusercontent.com/74236080/135277628-0c46ef6c-8ac2-4ec6-addf-32978758a435.png)

---


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


