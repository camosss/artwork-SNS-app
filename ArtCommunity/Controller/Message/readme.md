## 메세지


1. **메세지**

> 처음 메세지 화면은 상대의 유저정보와 최신 대화내용을 구성
> 


**Firebase에  `recent-messages` collection을 만들어서 최근 대화 텍스트를 [addSnapshotListener] 메서드로 실시간으로 업데이트해서 가져옵니다.**


<img src = "https://user-images.githubusercontent.com/74236080/135288047-e678bec1-950b-4d7c-84b4-625d87624dba.png" width="30%" height="30%">



Message 객체에 `chatPartnerId` 는 메세지창에 메세지를 보낸 유저를 가리킨다.

![image](https://user-images.githubusercontent.com/74236080/135288115-e2200831-32ff-4f5d-a25b-b6f9d44041f4.png)



`chatPartnerId` 와의 **Conversation** 데이터를 실시간으로 가져와서 TableView 에 가장 최근 대화 내용을 띄웁니다.

![image](https://user-images.githubusercontent.com/74236080/135288217-86e6aac8-678c-4b76-a9df-d90fd9b50855.png)




2. **새 매세지**

<img src = "https://user-images.githubusercontent.com/74236080/135288301-8f8aa655-b8f2-4afc-875e-f15d1bf92661.png" width="30%" height="30%">



- [검색]에서와 같이 그대로 유저정보를 가져옵니다.
- 해당 유저를 선택하면 해당 유저와의 채팅화면으로 전환됩니다.




3. 채팅


<img src = "https://user-images.githubusercontent.com/74236080/135288414-9d470c90-0139-41b0-be78-7d40f4c618da.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/135288430-77dd5494-1412-4358-870c-24ac76d6963e.png" width="30%" height="30%">




- **로그인한 사용자와 구분하기 위해 [왼쪽] [오른쪽]으로 제약조건(NSLayoutConstraint)을 추가해서 
좌, 우 레이아웃으로 설정합니다.**


![image](https://user-images.githubusercontent.com/74236080/135288507-491a2098-7942-4dd8-8766-98ef7d72f4e2.png)

![image](https://user-images.githubusercontent.com/74236080/135288533-b01059c7-a8dc-44be-8638-5e9c847efe02.png)

![image](https://user-images.githubusercontent.com/74236080/135288547-02b6cf52-936a-4567-b701-312636830d34.png)





- **앞선 최근 메세지 텍스트를 가져오는 것과 마찬가지로 메세지를 보내면 실시간으로 업데이트해서 View에 띄울 수 있게 해줍니다.**

![image](https://user-images.githubusercontent.com/74236080/135288570-3c98f3d3-76e1-434f-afd6-da73ff1fa8b0.png)



보낸 메세지는 Firebase 에 아래와 같이 저장됩니다.

- 보낸 사용자 uid
- text 내용
- 보낸 시간
- 받는 사용자 uid
    
    
![image](https://user-images.githubusercontent.com/74236080/135288602-f0c48836-086e-450b-8174-5389b1bc39fe.png)
