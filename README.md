# <u>Sera Online Shopping Mall</u>
스프링 프레임워크와 MariaDB로 구현한 뷰티 상품 온라인 쇼핑몰 프로젝트입니다.
<br><br>

## 📅 <u>개발 기간</u>
2024.05.01 ~ 2024.07.09
<br><br>

## 🖥️ <u>개발 환경</u>
*  JDK v1.8.0_341
*  Spring Framework 4.3.8.RELEASE
*  STS 3.9.12.RELEASE
*  Apache Tomcat v8.5.99
*  MyBatis v3.4.1
*  MariaDB v10.4.33
*  Toad for MySQL 8.0 Freeware
<br><br>

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
<br> 

## 📍 <u>핵심 기능</u>
온라인 쇼핑몰 프로젝트인 만큼 여러 기능 가운데 가장 신경써서 구현한 기능은 관리자의 상품 등록을 시작으로 고객의 구매까지 이어지는 상품 관리 기능입니다.

<details>
  <summary><strong>관리자 페이지의 상품 등록</strong></summary>
  <br>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/71dd79c7-5493-497a-98bc-2f3045065359" width="500px">
      <img src="https://github.com/user-attachments/assets/12711609-83e0-41a7-ae78-3338bd505bcc" width="500px">
    </p>
  </div>

  상품 등록 페이지의 모습입니다.<br> 
  상품 관리에 필요한 일련의 정보들을 Controller를 통해 DB로 전달하기 위한 입력폼을 구성했습니다.
  
  <br>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/32cc16a9-dc59-40f1-9cda-ddb84ff3c1c4" width="500px">
      <img src="https://github.com/user-attachments/assets/424e20dd-ab2a-4bed-9bfb-625b3babd09a" width="500px">
    </p>
  </div>
  매입가 보다 판매가를 낮은 값으로 입력할 수 없도록 매입가의 입력 값이 변경되는 경우 판매가를 입력하는 number 타입 input 태그의 min 속성 값을 매입가에 입력된 값으로 변경 되도록 구현했습니다.
  <br><br> 
  판매가를 포함한 number 타입 input 태그의 입력 값이 min 속성보다 작은 경우 
  입력된 값을 min값으로 변경되도록 구현하는 코드를 추가로 작성했습니다.
  <br><br>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/72e503ea-d91c-4ca8-aca2-9e3290841d1f" width="300px">
    </p>
  </div>

  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/resources/js/empImageUpload.js 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/4c56710b-6c3c-4441-a19d-74c6c2e31fca" width="500px">
    </p>
  </div>

  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/EmpController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/54471773-fda2-4816-a9d5-73f3e3f4be7e" width="800px">
    </p>
  </div>

  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/AdminGoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/d1e5eb57-c08f-4bff-a354-1dde295278c3" width="500px">
      <img src="https://github.com/user-attachments/assets/0033ca15-709f-4321-8b41-6ec181bf3803" width="400px">
    </p>
  </div>
  상품 섬네일 이미지 등록은 미리보기 처리를 위해 페이지 전체 갱신 없이 ajax로 처리했습니다. 
  <br>
  이때 AdminGoodsController.java에서 goodsRegist.jsp로 전달된 <strong>등록일자 + 로그인한 관리자 id + 현재 상품 이미지 디렉토리 내 파일 수</strong> 조합으로 된 문자열 값을 이미지 파일이 업로드 될 디렉토리명으로 생성하기 위해 ajax url 요청으로 문자열 값을 itemName 파라미터로 전달했습니다.
  <br><br>
  
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/b7e7ae54-b70f-4083-b829-83db4fdf60f4" width="400px">
      <img src="https://github.com/user-attachments/assets/d7fe9e9b-699d-47f6-82d0-834233fb4141" width="500px">
    </p>
  </div>

  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/EmpController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/02a30938-19fd-4223-bb29-3467c9f04e81" width="500px">
    </p>
  </div>

  상품 상세 정보는 이미지와 텍스트가 같이 내용에 첨부될 수 있도록 textarea 태그와 ckeditor로 구현했습니다.
  <br><br>
  이때 상품 섬네일 이미지와 마찬가지로 AdminGoodsController.java에서 goodsRegist.jsp로 전달된 <strong>등록일자 + 로그인한 관리자 id + 현재 상품 이미지 디렉토리 내 파일 수</strong> 조합의 된 문자열 값을 이미지 파일이 업로드 될 디렉토리명으로 생성하기 위해 ajax url 요청으로 문자열 값을 imgaeUploadPath 파라미터로 전달했습니다.

<br><br>

이렇게 입력된 정보들은 goodsRegist.jsp에서 AdminGoodsController.java의 goodsRegist 메서드로 입력 정보의 요청을 전달, AdminGoodsController에서 service, repository 순으로 요청을 전달하여 DB의 상품 정보 테이블에 새로운 상품 정보를 등록합니다.
<br><br>
</details>

<details>
  <summary><strong>관리자 페이지 상품 검색</strong></summary>
  <br>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/6e943083-f368-4b8a-a82e-b1c987c0fb0a" width="500px">
    </p>
  </div>
  관리자 페이지에서 상품을 조건별로 검색하는 기능을 구현하기 위해 &lt;input type="text"&gt;, &lt;select&gt;, &lt;input type="radio"&gt; 태그를 사용하여 여러 조건을 입력받는 입력폼을 구현했습니다.
  <br>
  입력받은 값은 SELECT 쿼리문으로 DB에서 상품 목록을 검색할 때의 조건으로 사용됩니다.
  <br><br>
  &lt;input type="text"&gt; 태그로 입력받은 값들은 상품명, 상품 가격과 같이 관리자가 자유롭게 입력할 수 있는 키워드로 SELECT 쿼리문에서 WHERE 절의 비교 조건값으로 사용됩니다.<br>
  &lt;select&gt; 태그로 받은 값은 등록일/수정일, 판매가/매입가와 같은 검색 유형을 선택하는 값으로 SELECT 쿼리문에서 WHERE 절의 컬럼명으로 사용됩니다.<br>
  &lt;input type="radio"&gt; 태그로 입력받은 값은 검색 조건을 선택하는 값으로 SELECT 쿼리문에서 WHERE 절의 컬럼명으로 사용됩니다.<br>
  <br><br>
  
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/AdminGoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/f53ebaff-d52a-4409-81de-b274304b84fd" width="500px">
    </p>
  </div>
  <br>
  조회된 상품 정보들은 GoodsVO 클래스형 배열 변수에 저장되어 다시 상품 목록 페이지로 전달됩니다.
  <br><br>
  
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/03314e2e-a35b-4bd7-9555-ed62c56c79dd" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}상품 테이블과 카테고리 테이블의 foreign key 제약 관계}}$
    <p>
      <img src="https://github.com/user-attachments/assets/3be0b76b-572c-4527-aafe-781fe9fd11cd" width="500px">
    </p>
  </div>
  상품 정보중 대분류, 중분류와 같은 상품의 카테고리 값은 유효한 값만을 저장하게 하도록 DB에서 tbl_goods(상품) 테이블과 tbl_category(카테고리) 테이블간에 FOREIGN KEY 제약 조건을 걸어두었습니다.<br>
  그렇기에 SELECT 쿼리문에서 카테고리 값을 검색 조건으로 사용할 경우 상품 테이블과 카테고리 테이블을 조인하여 검색합니다.
  
  <strong>*상품 테이블에는 카테고리 번호만 저장되어 있고
  카테고리의 대분류명, 중분류명 값은 카테고리 테이블에만 저장되어 있습니다.</strong>


</details>

//작성중


