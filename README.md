# <u>Sera Online Shopping Mall</u>
스프링 프레임워크와 MariaDB로 구현한 뷰티 상품 온라인 쇼핑몰 프로젝트입니다.

## 📅 <u>개발 기간</u>
2024.05.01 ~ 2024.07.09

## 🖥️ <u>개발 환경</u>
*  JDK v1.8.0_341
*  Spring Framework 4.3.8.RELEASE
*  STS 3.9.12.RELEASE
*  Apache Tomcat v8.5.99
*  MyBatis v3.4.1
*  MariaDB v10.4.33
*  Toad for MySQL 8.0 Freeware

## 🗃️ <u>구현 기능</u>
### 🛒 고객용 페이지

<details> 
  <summary><strong>1. 회원 계정 관리</strong></summary>
  
  - 회원가입
  - 로그인/로그아웃
  - 아이디 찾기/비밀번호 재설정
</details>

<details>
  <summary><strong>2. 메인 페이지</strong></summary>
  
  - 베스트셀러 상품 출력
  - 피부 타입별 추천 상품 출력
</details>

<details>
  <summary><strong>3. 마이 페이지</strong></summary>
  
  - 회원정보 수정
  - 회원 탈퇴
  - 마일리지 조회
  - 주문 내역 조회
  - 주문 취소/반품 요청
</details>

<details>
  <summary><strong>4. 상품 목록</strong></summary>
  
  - 상품 목록 및 검색
  - 상품 상세 페이지
  - 상품 조회수 표시
  - 상품 리뷰 및 평가
</details>

<details>
  <summary><strong>5. 장바구니 관리</strong></summary>
  
  - 장바구니 등록
  - 장바구니 조회
  - 장바구니 삭제
</details>

<details>
  <summary><strong>6. 주문 및 결제</strong></summary>
  
  - 주문 등록
  - 비회원 주문
  - 결제 처리
  - 마일리지 적립
  - 마일리지 차감
</details>

### ⚙️ 관리자용 페이지

<details>
  <summary><strong>1. 관리자 계정 관리</strong></summary>
  
  - 관리자 등록
  - 로그인/로그아웃
  - 관리자 목록
  - 관리자 검색
  - 관리자 수정
</details>

<details>
  <summary><strong>2. 회원 관리</strong></summary>
  
  - 회원 목록
  - 회원 검색
  - 회원 수정
  - 블랙리스트/휴면 회원 등록
  - 블랙리스트/휴면 회원 목록 조회
  - 블랙리스트/휴면 회원 검색
  - 블랙리스트/휴면 회원 상태 해제
</details>

<details>
  <summary><strong>3. 상품 관리</strong></summary>
  
  - 카테고리 목록 조회
  - 상품 등록
  - 상품 검색
  - 상품 수정
  - 상품 품절
  - 상품 일시 삭제
  - 상품 복원
  - 상품 영구 삭제
</details>

<details>
  <summary><strong>4. 주문 관리</strong></summary>
  
  - 주문 목록
  - 주문 검색
  - 주문 정보 수정
  - 주문 취소/반품 처리
</details>

## 📍 <u>핵심 기능</u>
온라인 쇼핑몰 프로젝트인 만큼 여러 기능 가운데 가장 신경써서 구현한 기능은 관리자의 상품 등록을 시작으로 고객의 구매까지 이어지는 상품 관리 기능입니다.

<details>
  <summary><strong>관리자 페이지의 상품 등록</strong></summary>
  <br>
  <div>
    ${\textsf{\color{gray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/71dd79c7-5493-497a-98bc-2f3045065359" width="500px">
      <img src="https://github.com/user-attachments/assets/12711609-83e0-41a7-ae78-3338bd505bcc" width="500px">
    </p>
  </div>

  일련의 상품 정보들을 input과 select 태그로 입력 받아 form 태그로 Controller로 전달합니다.
  
  <br>
  <div>
    ${\textsf{\color{gray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/32cc16a9-dc59-40f1-9cda-ddb84ff3c1c4" width="500px">
      <img src="https://github.com/user-attachments/assets/424e20dd-ab2a-4bed-9bfb-625b3babd09a" width="500px">
    </p>
  </div>
  매입가 보다 판매가를 낮은 값으로 입력할 수 없도록 매입가의 입력 값이 변경되는 경우 판매가를 입력하는 number 타입 input 태그의 min 속성 값을 매입가에 입력된 값으로 변경 되도록 구현했습니다.

  판매가를 포함한 number 타입 input 태그의 입력 값이 min 속성보다 작은 경우 
  입력된 값을 min값으로 변경되도록 구현하는 코드를 추가로 작성했습니다. 


</details>



//작성중


