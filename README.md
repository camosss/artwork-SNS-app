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

- [로그인, 회원가입](#1. 로그인-회원가입)
- [피드](#2. 피드)
- [검색](#3. 검색)
- [업로드](#4. 업로드)
- [프로필](#5. 프로필)
- [알림](#6. 알림)
- [게시물](#7. 게시물)
- [메세지](#8. 메세지)


1. 로그인-회원가입
> **Firebase를 사용하여 사용자 등록 및 인증**
>
> ***로그인***
> 

![simulator_screenshot_AA72AF4C-836F-44DB-90F0-6B72B4E68B32.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4035f289-a30a-4f2e-b398-96d20a2e98b3/simulator_screenshot_AA72AF4C-836F-44DB-90F0-6B72B4E68B32.png)

- 앱 실행 시 로그인 View 가 로드됩니다. 로그인 View 에는 id/password 에 대한 두 개의 TextField 가 있습니다.
- 아래에는 TextField 에 채워진 정보로 Firebase 에 등록된 사용자를 확인하고, 메인탭으로 전환을 하는 로그인 버튼이 있습니다.
- 로그인 버튼 아래에는 회원가입 View 로 전환하는 버튼이 있습니다.

### Firebase 등록된 사용자 목록

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2f8792e9-b3fb-4752-a18c-66d076fba1fe/스크린샷_2021-07-30_오후_3.49.16.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2f8792e9-b3fb-4752-a18c-66d076fba1fe/스크린샷_2021-07-30_오후_3.49.16.png)

`LoginController` 안에서 로그인 버튼을 눌렀을 때, `JGProgressHUD` 프레임워크를 사용하여 사용자 확인과정이 끝날때까지 로딩뷰가 생성됩니다. 

`AuthDataResultCallback` 을 통해 로그인 이벤트가 완료되면 `signIn` 으로 로그인 처리를 진행합니다.

![스크린샷 2021-09-23 오후 1.35.29.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cb8d7873-aa59-42b1-83aa-3812d76c0d99/스크린샷_2021-09-23_오후_1.35.29.png)

![스크린샷 2021-09-23 오후 1.38.21.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fce38a96-9d89-4ca9-be52-06d237f3dbe7/스크린샷_2021-09-23_오후_1.38.21.png)

로그인 성공 후 MainTap 으로 전환하기 위해 `MainController` 에서 `checkIfUserIsLoggedIn()` 함수를 호출하여 유저의 정보를 불러와 MainView 를 구성합니다.

앱을 다시 실행하였을 때 `Auth.auth().currentUser == nil` 의 조건을 통해 현재 사용자가 로그인 되어있지 않다면 로그인화면으로 전환합니다.

![스크린샷 2021-09-23 오후 1.52.54.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d3cbee83-b1e6-424c-a8e2-765c872fdac8/스크린샷_2021-09-23_오후_1.52.54.png)

***로그인*** ***키보드 높이 조절***

`LoginkeyboardMoves` 함수를 통해 Textfield 를 Tap 하면 `keyboardSize.height - 100` 만큼 `view.frame.origin.y` 를 올려줍니다.

![스크린샷 2021-09-23 오후 2.08.36.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a6454fda-1327-4abf-8c98-051ccee6789c/스크린샷_2021-09-23_오후_2.08.36.png)

입력을 마친 뒤 화면을 Tap 하거나 키보드를 닫으면 원상태로 돌아옵니다.

![스크린샷 2021-09-23 오후 2.12.10.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/56cdeae1-701a-4474-a3cd-aac4bd9100ad/스크린샷_2021-09-23_오후_2.12.10.png)

> ***회원가입***
> 

![simulator_screenshot_1A1B54EC-2F64-48B7-B319-D9D90FAA4B2D.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/014f60ba-6d18-4aff-b872-e4aedc4cd4b4/simulator_screenshot_1A1B54EC-2F64-48B7-B319-D9D90FAA4B2D.png)

- 회원가입 View 는 프로필 이미지 등록을 위한 Photo 버튼과 이름, 전공, 이메일, 비밀번호를 입력할 Textfield 로 구성됩니다.
- Textfield 가 채워지면 회원가입 버튼을 통해 Firebase 에 사용자를 등록하고, MainTapView 로 전환됩니다.
- 이미 계정이 있다면 `이미 계정이 있으신가요?` 버튼을 통해 로그인 화면으로 전환됩니다.

- Photo 버튼을 클릭하면 `UIImagePickerController` 객체를 생성 `present` 로 `UIImagePickerController` 객체를 띄우고, 앨범에 접근합니다.

![스크린샷 2021-09-23 오후 2.16.10.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/58468825-db7c-484b-b04a-c4aba0d15f9c/스크린샷_2021-09-23_오후_2.16.10.png)

1️⃣ 앨범에서 이미지 선택

2️⃣ `setImage` 함수를 이용하여 선택한 이미지 삽입 (Photo 버튼 Frame 사이즈에 맞게)

3️⃣ 앨범 화면 `dismiss`

![스크린샷 2021-09-23 오후 2.22.28.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c91d70f2-d032-4206-b262-60db2d6983c5/스크린샷_2021-09-23_오후_2.22.28.png)

- 그런 다음, TextField 를 정보에 맞게 작성한 뒤 회원가입 버튼을 눌러 Firebase 에 사용자 등록을 진행합니다.

![스크린샷 2021-09-23 오후 2.25.53.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/dfc16f9b-7fd2-49c7-aaa1-c0dda753b15a/스크린샷_2021-09-23_오후_2.25.53.png)

- 앨범에서 선택한 UIImage 를 Firebase Storage 에 저장합니다.

각 이미지를 JPEG 데이터로 변환한 뒤, 고유의 값 `UUID` 을 지정하여 `/profile_images/` 경로에 파일이름을 저장합니다.

![스크린샷 2021-09-23 오후 2.32.11.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2d29d9bc-bf62-48af-a481-da30647973c3/스크린샷_2021-09-23_오후_2.32.11.png)

![스크린샷 2021-09-29 오후 5.59.15.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8b41fea4-e351-4a42-9806-e10dae3d1e43/스크린샷_2021-09-29_오후_5.59.15.png)

- 저장되 이미지 url 을 포함하여 나머지 값도 Data 형식에 맞춰 Firebase 에 새로운 사용자 정보를 등록합니다.
- 그리고 위의 로그인 과정과 동일하게 사용자 정보를 확인하여 MainTap 으로 전환합니다.

![스크린샷 2021-09-23 오후 2.26.43.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/80894568-6eec-4792-8bbe-ea5d1064c108/스크린샷_2021-09-23_오후_2.26.43.png)

회원가입 ***키보드 높이 조절***

회원가입 화면은 로그인 화면과 다르게 키보드를 올릴 때, `view.frame.origin.y` 를 같이 올리지 않고 작성을 마친 뒤 화면을 Tap 했을 때, 키보드 창이 사라지도록 했습니다.

![스크린샷 2021-09-23 오후 2.12.10.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/56cdeae1-701a-4474-a3cd-aac4bd9100ad/스크린샷_2021-09-23_오후_2.12.10.png)







