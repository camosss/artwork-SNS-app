## 업로드

> **`YPImagePicker` 라이브러리를 사용하여 이미지 업로드**
>

<img src = "https://user-images.githubusercontent.com/74236080/135282578-836b1185-546e-4f34-9036-c05544ce2e33.png" width="30%" height="30%">



1️⃣   Main Tap Bar 에서 `+` 를 클릭하면 **앨범의 접근을 요청**합니다.

info.plist 에서 `Privacy - Photo Library Usage Description` 를 추가해줍니다.

![image](https://user-images.githubusercontent.com/74236080/135282731-26fa8f09-4a7f-4730-ace0-99abffdd10b1.png)




> **[MainTapController]에서 `UITabBarControllerDelegate` 메소드를 호출합니다.**
> 

![image](https://user-images.githubusercontent.com/74236080/135283108-4460ad59-01c6-48ed-885e-fbe60a2ac6ad.png)






2️⃣   `YPImagePicker` 라이브러리를 통해 이미지를 가져와 필터와 자르기 기능을 사용할 수 있습니다.

<img src = "https://user-images.githubusercontent.com/74236080/135283176-a6e09934-216a-4b05-baca-a1fd27cb0bdf.png" width="30%" height="30%">




3️⃣   필터와 자르기 등 이미지 선택을 마치면 `upload View` 로 전환됩니다.


<img src = "https://user-images.githubusercontent.com/74236080/135283285-e2bf8986-1f54-4d89-9e89-bb55b59ce109.png" width="30%" height="30%">


- `upload View` 는 선택한 이미지와 작품명과 작품을 소개하는 TextField 로 구성됩니다.
- TextField 의 작성을 마치면 `Share` 버튼을 통해 Firebase 에 게시물을 저장하고, Feed 로 화면이 전환되면서 게시물을 업로드합니다.

---

입력을 마친 뒤 `Share` 버튼을 누르면 로딩 뷰가 생성되고, PostService 의 `uploadPost` 함수를 호출합니다.

![image](https://user-images.githubusercontent.com/74236080/135283363-ac97099d-3402-4672-a63f-673f64ebd70c.png)



이미지를 포함한 데이터를 저장한 뒤 `Firebase_Post` 컬렉션에 데이터를 추가합니다.
또한, 팔로잉한 유저의 게시물에도 추가해서, `Following-Feed` 에도 업로드되도록 합니다.

![image](https://user-images.githubusercontent.com/74236080/135283434-19c07c49-8bcd-4884-917d-caeda5330744.png)

![image](https://user-images.githubusercontent.com/74236080/135283473-fd7a66c5-2919-4af6-88e9-7148b6fc10c9.png)

