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
온라인 쇼핑몰 프로젝트인 만큼 여러 기능 가운데 가장 신경써서 구현한 기능은 관리자의 상품 등록을 시작으로 고객의 구매까지 이어지는 상품&주문 관리 기능입니다.

<details>
  <summary><h3>관리자용 페이지 - 상품 등록</h3></summary>
  <br>

  <h4>- 상품 정보 입력폼</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/71dd79c7-5493-497a-98bc-2f3045065359" width="500px">
      <img src="https://github.com/user-attachments/assets/12711609-83e0-41a7-ae78-3338bd505bcc" width="500px">
    </p>
  </div>

  상품 등록 페이지의 모습입니다.<br> 
  상품 관리에 필요한 일련의 정보들을 Controller를 통해 DB로 전달하기 위한 입력폼을 구성했습니다.
  <br><br>

  <h4>- 상품 매입가에 따른 판매가 최소치 설정</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsRegist.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/32cc16a9-dc59-40f1-9cda-ddb84ff3c1c4" width="500px">
      <img src="https://github.com/user-attachments/assets/424e20dd-ab2a-4bed-9bfb-625b3babd09a" width="500px">
    </p>
  </div>
  매입가 보다 판매가를 낮은 값으로 입력할 수 없도록 하기 위해 매입가의 입력 값이 변경되는 경우 판매가를 입력하는 number 타입 input 태그의 min 속성 값을 매입가에 입력된 값으로 변경 되도록 구현했습니다.
  <br><br> 
  판매가를 포함한 number 타입 input 태그의 입력 값이 min 속성보다 작은 경우 
  입력된 값을 min값으로 변경되도록 구현하는 코드를 추가로 작성했습니다.
  <br><br>

  <h4>- 상품 섬네일 이미지 업로드</h4>
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

  <h4>- 상품 상세 정보 (이미지 + 텍스트) 업로드</h4>
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
  <summary><h3>관리자용 페이지 - 상품 검색</h3></summary>
  <br>

  <h4>- 상품 검색폼</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/6e943083-f368-4b8a-a82e-b1c987c0fb0a" width="500px">
    </p>
  </div>
  상품 목록 페이지중 검색폼의 모습입니다.<br>
  관리자 페이지에서 상품을 조건별로 검색하는 기능을 구현하기 위해 &lt;input type="text"&gt;, &lt;input type="date"&gt;, &lt;input type="number"&gt;, &lt;select&gt;, &lt;input type="radio"&gt; 태그를 사용하여 여러 검색 조건을 입력받는 입력폼을 구현했습니다.
  <br>
  입력받은 값은 SELECT 쿼리문으로 DB에서 상품 목록을 검색할 때의 조건으로 사용됩니다.
  <br><br>
  <strong>&lt;input type="text"&gt;, &lt;input type="date"&gt;, &lt;input type="number"&gt;</strong> 태그로 입력받은 값들은 상품명, 상품 가격과 같이 관리자가 자유롭게 입력할 수 있는 키워드로 SELECT 쿼리문에서 WHERE 절의 비교 조건값으로 사용됩니다.<br>
  <strong>&lt;select&gt;</strong> 태그로 받은 값은 등록일/수정일, 판매가/매입가와 같은 검색 유형을 선택하는 값으로 SELECT 쿼리문에서 WHERE 절의 컬럼명으로 사용됩니다.<br>
  <strong>&lt;input type="radio"&gt;</strong> 태그로는 검색 조건을 선택적으로 입력 받으며 입력 받은 값은 SELECT 쿼리문에서 WHERE 절의 비교 조건값으로 사용됩니다.<br>
  <br><br>

  <h4>- 분류별 상품 검색</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/a8076a80-95ab-4689-b09e-84f9cf78453f" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/6cf0681f-ba96-49b8-b805-faec0a2c3752" width="500px">
    </p>
  </div>
  검색폼 분류 항목에서 &lt;select&gt; 태그로 입력받은 값은 searchkey 파라미터로 전달되어 SELECT 쿼리문에서 WHERE 절의 컬럼명으로 사용됩니다.<br>
  아래는 선택된 검색 유형별로 SELECT 쿼리문에서 어떤 컬럼명이 사용 되는지를 설명한 예시입니다.<br><br>
  
  <strong>상품명</strong> ->  goods_name : tbl_goods(상품) 테이블에서 상품명을 저장한 컬럼<br>
  <strong>일련번호</strong> -> goods_id : tbl_goods(상품) 테이블에서 상품의 일련번호를 저장한 컬럼<br>
  <strong>상품 검색키워드</strong> -> goods_search_key : tbl_goods(상품) 테이블에서 검색 키워드를 저장한 값으로 고객이 상품을 검색할 때 입력할만한, 상품과 관련성이 높은 키워드를 저장하여 검색 노출도를 올리기 위해 사용하는 컬럼입니다.<br> 
  <strong>등록자</strong> -> emp_id : tbl_goods(상품) 테이블에서 상품을 등록한 관리자의 계정 id를 저장한 값이며 유효한 값만을 저장하기 위해 tbl_emp(관리자) 테이블의 PRIMARY KEY를 참조한 컬럼입니다.<br>
  <br>
  검색폼 분류 항목에서 &lt;input type="text"&gt; 태그로 입력 받은 값은 searchKeyVaue 파라미터로 전달되어 SELECT 쿼리문에서 WHERE 절의 조건값으로 사용됩니다.<br>
  LIKE 술어로 조회하기에 선택한 분류(컬럼)에서 입력한 문자열 값과 일부 일치하는 상품들이 검색됩니다.
  <br><br>

  <h4>- 카테고리별 상품 검색</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/f2aba10d-3f57-4d87-a4c4-166555ba704d" width="500px">
    </p>
  </div>
  모든 상품들은 대분류 - 중분류 층으로 이루어진 카테고리 값을 가지고 있습니다.<br>
  상품 검색시 카테고리별 상품 검색이 가능하도록 구현하였습니다.
  <br><br>

  <h4>- 데이터베이스의 카테고리 테이블을 참조하여 검색</h4>
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
  상품 정보중 대분류, 중분류의 카테고리 값은 유효한 값만을 저장하게 하기 위해 DB에서 tbl_goods(상품) 테이블과 tbl_category(카테고리) 테이블간에 FOREIGN KEY 제약 조건을 걸어두었습니다.<br>
  따라서 SELECT 쿼리문에서 카테고리 값을 검색 조건으로 사용할 경우 상품 테이블과 카테고리 테이블을 조인하여 검색합니다.
  <br>
  <strong>*상품 테이블에는 카테고리 관련 정보중 카테고리 번호만 저장되어 있고
  카테고리의 대분류명, 중분류명 값은 카테고리 테이블에 저장되어 있습니다.</strong>
  <br><br>

  <h4>- 관리자 권한에 따라 선택 가능한 카테고리 항목</h4>
  <div>
    ${\textsf{\color{LightGray}최고 권한의 관리자로 로그인한 경우}}$
      <p><img src="https://github.com/user-attachments/assets/c7b89105-3614-413e-8def-9327f805c5e4" width="500px"></p>
  </div>
  <div>
    ${\textsf{\color{LightGray}"헤어케어" 카테고리의 담당 부서 관리자로 로그인 한 경우}}$
      <p><img src="https://github.com/user-attachments/assets/ee09b64d-19e1-4b50-81b7-47854a5ef3af" width="500px"></p>
  </div>
  <div>
    ${\textsf{\color{LightGray}"바디 핸드케어" 카테고리의 담당 부서 관리자로 로그인 한 경우}}$
      <p><img src="https://github.com/user-attachments/assets/c794de13-d08e-4bc0-9c4a-0ba427ca7a5d" width="500px"></p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
      <p><img src="https://github.com/user-attachments/assets/7d08eee4-8fdd-4308-9a36-a0e4bf082123" width="650px"></p>
  </div>

  카테고리 항목에서 &lt;select&gt; 태그 내의 선택값은 JSTL Core의 if 태그를 사용하여 관리자의 부서에 해당되는 카테고리만 표기 되도록 구현했습니다.
  <br><br>

  <h4>- 관리자 권한에 따라 검색되는 상품 필터링</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/ed6acf6c-42ad-44ae-8b73-58c71a1bf876" width="500px">
    </p>
  </div>
  상품이 검색될 때 카테고리별 담당 부서의 관리자나 최고 권한을 가진 관리자에게만 검색 되도록 제한을 걸었습니다.<br>
  DB의 tbl_category (상품 카테고리) 테이블과 tbl_emp (관리자 정보) 테이블에는 담당 부서명을 저장하는 depart 컬럼이 있으며<br> 
  SELECT 쿼리문으로 상품 조회시 두 테이블의 depart 컬럼의 값을 비교하여 일치하는 경우에만 상품이 검색되는 형태로 구현했습니다.
  <br><br>
  
  검색폼 카테고리 항목에서 &lt;select&gt; 태그로 입력받은 값(카테고리 대분류, 소분류)은 inputCateId 파라미터로 전달됩니다. 선택된 값이 없는 경우 “not_choose” 문자열 값이 전달됩니다.
  depart 파리미터로는 로그인중인 관리자의 부서명 정보가 전달되며 inputCateId로 전달 받은 값이 "not_choose"인 경우 전달받은 depart 파라미터의 값으로 관리자의 부서 정보와 일치하는 상품을 검색합니다.
  <br><br>
  최고 관리자의 경우 부서에 상관없이 모든 상품의 조회가 가능하므로 이 조건을 무시합니다.
  (최고 관리자의 경우 depart로 all 값이 전달되어 이 경우 and cate.depart = #{depart} 쿼리문을 실행하지 않습니다.)
  <br><br>

  <h4>- 입력된 카테고리 값에 따른 상품 검색</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/3a254186-f97a-4dbc-b7b6-67d8b16baec7" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/013516ea-1b56-4fad-968a-9f0d82a57e3e" width="500px">
    </p>
  </div>
  카테고리 항목의 &lt;select&gt; 태그에서 전달된 값이 있는 경우 선택한 카테고리명을 조건으로 상품 목록을 검색합니다.
  <br><br>
  main_type : 대분류명<br>
  Category_id : 중분류명 대신 카테고리 아이디 값으로 비교
  <br><br>
  대분류, 중분류 select 값 중 “전체”를 선택하면 카테고리명 대신 “allType” 문자열 값이 전달됩니다. 
  <br><br>
  이 경우 카테고리명을 조건으로 한 비교 쿼리문을 실행하지 않고 모든 상품을 검색합니다.
  <br><br>
  <strong>* 카테고리 select 항목의 ”전체” 옵션은 최고 관리자에게만 노출됩니다.</strong>
  <br><br>

  <h4>- 판매 상태별 상품 검색</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/a4244871-4e13-470f-9f26-300cdf94ce7b" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/377ff229-01ab-4db0-9368-6173dc30d864" width="500px">
    </p>
  </div>
  판매 상태별로 상품을 검색하기 위해 판매 상태 정보를 담은 값을 saleActive 파라미터로 전달합니다.
  <br><br>
  <strong>상품 목록 페이지</strong>에서 검색하는 경우 saleActive의 값이 <strong>for_sale</strong>로 전달되며<br>
  <strong>삭제 상품 목록 페이지</strong>에서 검색 하는 경우 saleActive 값이 <strong>goods_delete</strong>로 전달됩니다.
  <br><br>

   <h4>- 가격, 등록 일자별 상품 검색</h4>
   <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/71a29991-acfd-4f7b-bfda-d8de57286912" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/3acef6de-03ec-4a37-a29e-5f2410eae129" width="500px">
    </p>
  </div>
  입력한 가격 범위(매입가/판매가), 일자 범위(등록일/수정일)를 조건으로 상품을 검색합니다.
  <br><br>
  ${priceRangeSelect} : 등록/수정일 항목의 &lt;select&gt; 태그에서 선택한 값<br>
  #{priceBeign} : 판매 항목의 첫번째 &lt;input type="number"&gt; 입력폼에 입력한 값<br>
  #{priceEnd} : 판매 항목의 두번째 &lt;input type="number"&gt; 입력폼에 입력한 값
  <br><br>
  ${dateRangeSelect} : 등록/수정일 항목의 &lt;select&gt; 태그에서 선택한 값<br>
  #{dateBeign} : 등록/수정일 항목의 첫번째 &lt;input type="date"&gt; 입력폼에 입력한 값<br>
  #{dateEnd} : 등록/수정일 항목의 두번째 &lt;input type="date"&gt; 입력폼에 입력한 값
  <br><br>
  ${turnSelect} : 정렬기준 항목의 &lt;input type="radio"&gt; 태그 중 선택한 값<br>
  ${listSort} : 내림자순, 오름차순 중 선택한 값
  <br><br>

  <h4>- 목록 페이지의 페이지 번호에 따른 검색 상품수 범위 설정</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/goods/goodsList.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/48414fa3-2026-46af-bd69-5a30c827f8cf" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/resources/mappers/adminGoodsMapper.xml 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/e223c9e4-5a98-4356-9a9b-34cd1bd74394" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/AdminGoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/6d0a1417-527e-4a39-b7ed-70b142598b34" width="500px">
    </p>
  </div>
  LIMIT 술어를 사용하여 상품 목록 페이지의 페이지 번호에 따라 검색할 상품의 범위를 설정합니다.
  <br><br>
  pageCnt (정수형 변수) : 제한된 조회 범위 중 시작 순번<br>
  PAGE_MAX_AD_GOODS_CNT (정수형 상수) : 한 페이지에 표시할 최대 상품 개수 = 10
  <br><br>
  예로 페이지 번호가 3이면<br>
  pageCnt = (3-1) * 10 = 20<br>
  조회된 상품 중 21번째 상품부터 10개의 상품을 정보를 반환합니다<br>
  <strong>*LIMIT의 범위는 0번부터 순번을 새기 시작하므로 20은 21번째 상품을 의미</strong>
  <br><br>
  
  <h4>- 검색된 상품 정보 전달</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/AdminGoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/f53ebaff-d52a-4409-81de-b274304b84fd" width="500px">
    </p>
  </div>
  조회된 상품 정보들은 GoodsVO 클래스형 배열 변수에 저장되어 다시 상품 목록 페이지로 전달됩니다.
  <br><br>
</details>

<details>
  <summary><h3>고객용 페이지 - 상품 구매</h3></summary>
  <br>

  <h4>- 상품 정보 조회</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/sera/controller/GoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/41b9a6bb-fd1d-4fb0-a0fd-7e4512ab8486" width="500px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/goodsOne.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/5258ad76-31db-4245-8c4f-7546899052f7" width="1000px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/goodsOne.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/fdf43819-9786-448a-86cf-2f452549abfc" width="700px">
    </p>
  </div>
  상품 상세 페이지입니다. <br> 
  Contorller로 상품 상세 페이지 호출 요청이 전달되면 요청과 함께 전달받은 상품 일련번호 값으로 DB의 tbl_goods(상품 정보) 테이블에서 일련번호에 해당하는 상품 정보를 검색하여 
  ValueObject GoodsVO 클래스형 변수 gvo에 값을 저장한 후 상품 페이지 view에 goodsInfo라는 이름으로 상품 정보를 전달합니다.
  <br><br><br>

  <h4>- 상품 재고량에 따른 상품 구매량 제한</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/goodsOne.jsp}}$
    <p><img src="https://github.com/user-attachments/assets/c0f8ea4d-4d8c-4ac0-a342-44bca4df87b2" width="500px"></p>
    <p><img src="https://github.com/user-attachments/assets/5674f910-4aec-497f-bcaf-d1b55437d79d" width="700px"></p>
    <p><img src="https://github.com/user-attachments/assets/55152f42-be8d-4a9b-acc3-4da6c6ef54e4" width="500px"></p>
    <p><img src="https://github.com/user-attachments/assets/d156ce03-7549-4c57-8c86-3d362dbb47e6" width="500px"></p>
  </div>
  Contorller에서 전달받은 상품 정보(goodsInfo)의 속성 amount는 상품의 재고량을 저장한 값으로 구매 수량을 입력하는 &lt;input type="number"&gt; 태그에서 max 속성의 값으로 사용됩니다.<br>
  입력된 구매 수량의 값이 amount 값을 초과하는 경우 구매 수량의 값을 amount와 동일한 값으로 변경시키고 최대 구매 가능한 수량을 구매 수량 입력란 우측에 표기하여 재고량 이상으로 구매할 수 없도록 설정하였습니다.
  <br><br>

  <h4>- 상품 구매 방식 선택</h4>
  BUY IT NOW 버튼을 클릭하면 주문서 작성 페이지를 호출하고<br>
  ADD TO CART 버튼을 클릭하면 상세 페이지에 표시중인 상품 정보를 DB의 tbl_cart(장바구니) 테이블에 저장합니다.
  <br><br>

  <h4>- 장바구니 담기</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/sera/controller/GoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/430547ed-a624-4ca9-9d27-733d7bd85c4d" width="500px">
    </p>
  </div>
  상품 상세 페이지에서 ADD TO CART 버튼을 클릭하여 장바구니 페이지를 호출하면 상품 정보와 회원 로그인 중인 고객의 id 정보를 DB의 tbl_cart(장바구니) 테이블에 저장합니다.<br>
  고객의 회원 id는 장바구니 테이블에 등록된 회원간의 장바구니 정보를 구별하는데 사용됩니다.
  <br><br>

  <h4>- 장바구니에 이미 담긴 상품을 추가로 담기</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/sera/controller/GoodsController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/8ebfdfb9-09f8-4909-ac41-bc014a7272d6" width="500px">
    </p>
  </div>
  장바구니에 이미 등록되어 있는 상품을 추가로 담는 경우 상품 정보를 추가로 INSERT 시키는것이 아닌 기존에 담긴 동일 상품의 정보중 구매 수량 값만을 UPDATE 시킵니다.<br>
  구매 수량 값을 추가시킬 때 기존에 담긴 구매 수량과 추가로 담는 구매 수량의 합산 값이 상품의 재고량을 초과하는 경우 구매 수량 값을 재고량 값으로 UPDATE 시킵니다.
  <br><br>

  <h4>- 장바구니에서 구매 수량 변경</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/cart.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/34cb9454-da6d-4c11-bf02-89e9948f3aa3" width="300px">
    </p>
     <p>
      <img src="https://github.com/user-attachments/assets/4d8b3c0d-27dd-4319-9d8b-ed6d2380f4b7" width="700px">
      <img src="https://github.com/user-attachments/assets/59dc8e8c-f4c8-4381-98ed-0220e59369ef" width="700px">
    </p>
  </div>
  장바구니에서도 구매 수량 변경을 가능하게 구현 했습니다. <br> 
  변경된 구매 수량이 DB에 반영될 때 마다 페이지 재호출이 반복되면 사용자에게 피로를 유발하기에 DB에 반영하는 작업 호출은 Ajax를 통하여 비동기로 처리하였습니다.
  이 때 역시 상품의 재고량 이상의 구매 수량을 입력하는것은 불가능하도록 설정했습니다.
  <br><br>

  <h4>- 장바구니에서 주문서 페이지 호출</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/cart.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/3d498f8e-2d05-45a6-877b-264539014ea4" width="600px">
    </p>
  </div>
  장바구니 페이지에서 전체구매 버튼을 클릭하면 Controller를 통해 주문서 페이지를 호출하는데<br>
  이 때 로그인 중인 회원의 id를 통해 DB의 tbl_cart(장바구니) 테이블에서 상품 정보들을 검색하여 CartVO(ValueObject) 배열 변수에 저장합니다.<br>
  저장된 상품 정보는 orderInfo라는 이름으로 주문서 페이지 view에 전달됩니다.<br><br>
  그와 동시에 DB의 tbl_member(회원) 테이블에서 회원의 마일리지 정보를 검색하여 회원 로그인 세션에 저장시킵니다.
  <br><br>

  <h4>- 주문서 작성(구매 상품 목록)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/orderForm.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/654bb8e0-b484-4d48-9393-cdb940f4e95b" width="500px">
      <img src="https://github.com/user-attachments/assets/1af0016b-e7ab-4ad7-b5f0-7b5dbc048131" width="500px">
    </p>
  </div>
  주문서 작성 페이지중 구매하는 상품의 목록을 안내해주는 단락입니다.<br>
  url를 입력하여 주문서 페이지에 접속하는 등 올바르지 않은 경로로 주문서 페이지에 접근하여 표시할 상품 정보가 없는 경우 "상품 정보가 없습니다." 메세지기 출력 되도록 설정하였습니다. 
  <br><br>

  <h4>- 주문서 작성(배송 정보 작성)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/orderForm.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/fd3996f3-8a2c-4a61-91ac-27e0fc9749be" width="500px">
      <img src="https://github.com/user-attachments/assets/3383a226-feef-4ffc-b731-de90c432c0a9" width="500px">
    </p>
  </div>
  주문자의 배송지 정보를 작성하는 단락입니다.<br>
  회원 로그인이 되어 있는 경우 DB의 tbl_member(회원) 테이블에서 배송에 필요한 정보를 조회하여 자동으로 기입하도록 구현했습니다.
  <br><br>

  <h4>- 주문서 작성(결제 정보 작성)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/orderForm.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/592bfb79-6e51-48aa-bfae-9f8669806f80" width="330px">
      <img src="https://github.com/user-attachments/assets/0c33809e-53ce-44ea-89fb-976575b154b1" width="330px">
      <img src="https://github.com/user-attachments/assets/11107087-837b-40a2-aa4c-7f698d307505" width="330px">
    </p>
    <p><img src="https://github.com/user-attachments/assets/ae1a8b08-8d7d-431c-896b-c15ce558f430" width="600px"></p>
  </div>
  마일리지로 결제 금액을 할인하고 결제 수단을 선택하는 단락입니다.<br>
  마일리지 입력란은 &lt;input type="number"&gt; 태그로 구현되어 있으며 회원이 보유중인 마일리지 값이 &lt;input type="number"&gt; 태그의 placeholder 속성으로 표시되어 최대 얼마의 할인이 가능한지 알 수 있도록 구현했습니다.<br>
  마일리지 입력란은 보유중인 마일리지 보다 큰 액수를 입력하면 보유중인 마일리지 최대 액수로 입력 값이 변경되며<br>
  보유 마일리지가 총 주문 금액 보다 큰 경우 마일리지 최대 금액을 입력하면 총 주문 금액으로 입력 값이 변경되도록 설정하였습니다.
  <br><br>

  <h4>- 주문서 작성(총 결제 금액 확인)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/orderForm.jsp 중}}$
    <p><img src="https://github.com/user-attachments/assets/0fd06d88-3c41-4ce0-8d6a-e2ec5103eaf5" width="500px"></p>
    <p><img src="https://github.com/user-attachments/assets/3a874c42-6689-4d83-a1ce-b815ed3abf96" width="500px"></p>
  </div>
  결제할 총 금액을 안내하는 결제 금액란입니다.<br>
  상품 목록에 표시된 금액을 모두 합산한 후 마일리지 사용이 이루어진 경우 사용액 만큼 차감하여 표시하도록 구현했습니다.
  <br><br>
  
  <h4>- 주문서 작성(주문 결과)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/goods/orderForm.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/88d97a81-04a3-4b22-ac84-cdca741949fe" width="500px">
      <img src="https://github.com/user-attachments/assets/d1457642-b846-40ab-b71c-0c5d84bc2027" width="500px">
    </p>
    <p>
      <img src="https://github.com/user-attachments/assets/30559109-81a8-4055-9470-e8fb00334cd2" width="500px">
      <img src="https://github.com/user-attachments/assets/7cef2d53-3003-4360-870b-274f8bf5d864" width="500px">
    </p>
  </div>
  주문서 작성 완료 후 결제 버튼을 누르면 결제 요청에 대한 처리 결과를 보여주는 주문 결과 페이지를 호출하게 됩니다.<br>
  결제 처리 결과에 따라 다른 메세지를 출력하게 구현했습니다.
  <br><br>
  <strong>결제가 정상적으로 이루어진 경우 </strong> : "주문이 완료 되었습니다." 메세지를 출력합니다.<br>
  <strong>비정상적인 경로로 주문 결과 페이지를 호출한 경우 </strong> : "잘못된 접근입니다." 메세지를 출력합니다.<br>
  <strong>주문 요청한 수량보다 재고가 적은 경우 </strong> : "요청 구매 수량보다 재고 수량이 적어 구매가 불가합니다." 메세지를 출력합니다.<br> 주문이 여러 사용자에게서 동시다발적으로 이루어질 경우 주문 처리 도중에 다른 주문자에 의해 재고가 차감되는 경우를 대비한 메세지입니다. 
  <strong>주문한 상품의 정보를 찾을 수 없는 경우 </strong> : "상품 정보가 존재하지 않아 주문이 불가합니다." 메세지를 출력합니다.<br> 고객의 주문 처리 도중 관리자가 상품을 삭제하는 경우를 대비한 메세지입니다.
  <br><br>
</details>

<details>
  <summary><h3>주문 관리</h3></summary>
  <br>
  <h4>- 구매 내역 조회 (고객)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/member/mypage.jsp 중}}$
    <p><img src="https://github.com/user-attachments/assets/71d18ef0-43b9-4cb2-84b8-e8f72205c65d" width="500px"> </p>
    <p><img src="https://github.com/user-attachments/assets/e28344a4-3bcd-4938-b93c-16c60b4b9652" width="300px"> </p>
  </div>
  마이페이지중 주문내역을 주문 상태별로 보여주는 진행 주문 단락입니다.<br>
  DB의 tbl_orders(주문내역) 테이블에서 회원의 검색한 회원의 주문 정보중 주문 상태값을 orderStauts라는 이름으로 전달받아 주문 상태별로 정렬시켰습니다.
  <br><br>

  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/member/mypage.jsp 중}}$
    <p><img src="https://github.com/user-attachments/assets/c25e85ff-23ca-4ae8-abc5-8666c62d5a66" width="500px"></p>
    <p><img src="https://github.com/user-attachments/assets/379c1cae-ac44-4791-83fc-2d7bcdc1326c" width="500px"></p>
  </div>
  회원의 주문 목록을 나열한 단락입니다.<br>
  같은 주문번호에 해당하는 주문 목록을 묶어서 출력하기 위해 DB에서 주문번호를 먼저 검색하여 주문번호 목록을 ovoNumber 변수에 저장합니다.<br>
  ovoNumber 변수에 저장된 주문번호를 이용하여 주문번호 별로 검색된 주문 상세 정보들을 allOrders 변수에 저장합니다.<br>
  allOrders를 마이페이지 view로 전달하여 같은 주문번호에 속하는 주문번호들을 묶어서 출력합니다.
  <br><br>

  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/member/mypage.jsp 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/328967eb-1df2-4129-9677-1999cdf1813b" width="500px">
    </p>
  </div>
  주문상태에 따라 주문에 대한 취소/반품 요청을 하거나 구매 확정을 진행하고 후기를 작성하는게 가능합니다.
  <br><br>
  <strong>결제완료</strong> : 이 단계에서는 주문 취소 요청하는 것이 가능합니다.<br>
  <strong>배송준비중</strong> : 이 단계에서는 주문 취소 요청이 불가합니다.<br>
  <strong>배송중</strong> : 이 단계에서는 주문 취소 요청이 불가합니다.<br>
  <strong>배송완료</strong> : 이 단계에서는 주문 취소는 불가하나 반품 요청이 가능합니다. 혹은 구매 확정을 진행할 수 있습니다.<br>
  <strong>구매확정</strong> : 이 단계에서는 주문 취소, 반품 모두 불가합니다.<br>
  <br><br>

  <h4>- 구매 내역 조회 (관리자)</h4>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/webapp/WEB-INF/views/admin/order/orderList.jsp}}$
    <p>
      <img src="https://github.com/user-attachments/assets/39e5c41b-57b2-429c-a870-e615ac67a85f" width="700px">
    </p>
  </div>
  <div>
    ${\textsf{\color{LightGray}/sera/src/main/java/org/admin/controller/AdminOrderController.java 중}}$
    <p>
      <img src="https://github.com/user-attachments/assets/dbbd03ff-dd65-437d-a53c-6fa925c14eeb" width="700px">
    </p>
  </div>
  관리자용 페이지의 주문 목록 페이지입니다<br>
  DB의 tbl_orders(주문 정보) 테이블에서 주문 정보를 검색하여 반환된 정보를 OrverVO(ValueObject) 배열 변수에 저장합니다.<br>
  저장된 주문 정보들을 orderList라는 이름으로 Controller에서 주문 목록 페이지 view로 전달하여 화면에 출력합니다.
  <br><br>   
  
  
</details>
<br><br>

## 🖇️ <u>데이터베이스 설계</u>
이전 직장에서 쇼핑몰을 관리해본 경험을 바탕으로 상품 관리에 필요한 요소를 분석하여 데이터베이스를 설계하였습니다.
<br>
<div><img src="https://github.com/user-attachments/assets/cce31d5c-b44d-442d-8544-72f1d28314ba" width="1000px"></div>


//작성중


