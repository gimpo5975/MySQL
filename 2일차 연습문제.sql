use jointestdb;
-- 문1) customertbl테이블에서 gender가 "남"인 자료만  모든 컬럼을 검색
-- 검색 : select ,   gender가 "남"이라는 조건 : where 
select * from customertbl where gender='남';

-- 문2) customertbl테이블에서 address가 "서울 송파"인 자료들 중
-- custid, cname, phone만 검색
select custid,cname,phone from customertbl where address='서울 송파';

-- 문3) customertbl테이블에서 address가 "서울 관악"인 자료들 중
-- custid, cname만 검색하되 custid는 고객ID, cname은 고객명으로
-- 컬럼명을 출력
select custid as '고객ID', cname as '고객명' from customertbl where address='서울 관악';

-- 문4) customertbl테이블에서  address가 "서울 동작" 이고 gender가 "남"인
-- 자료 중 cname과  phone만 검색하되,  cname은 고객명으로  phone은 휴대폰으로
-- 컬럼명을 표시
select cname as '고객명', phone as '휴대폰' from customertbl where address ='서울 동작' and gender='남';

-- 문5) producttbl에서 price가 1000이상 2300이하인 자료들의 pcode, pname 검색
-- 단 pcode는 상품코드, pname은 상품명으로 컬럼명을 표시
select pcode as '상품코드', pname as '상품명' from producttbl where price between 1000 and 2300;

-- 문6)  producttbl에서 price가 2000이상이거나 700이하인 자료들의
-- pname과 region을 검색하되, pname은 상품명, region은 원산지로 컬럼명 표시
select pname as '상품명', region as '원산지' from producttbl where price between 2000 and 7000;

-- 문7)  producttbl에서 price가 1000미만이거나 pname이 오렌지인 자료들의
-- pname과 region을 검색하되, pname은 상품명, region은 원산지로 컬럼명 표시
select pname as '상품명', region as '원산지' from producttbl where price<1000 and pname='오렌지';

-- 문8) producttbl에서 pname이 "바나나", "오렌지", "망고"인 자료들의 
--  pcode, pname 검색. 단 pcode는 상품코드, pname은 상품명으로 컬럼명을 표시
select pcode as '상품코드', pname as '상품명' from producttbl where pname in('바나나','오렌지','망고');

-- 문9) customertbl테이블에서 cname의 성이 "박"씨, "정"씨, "김" 씨인 자료들의
-- custid, cname, phone를 검색하되, custid는 고객ID, cname은 고객명으로 컬럼명 표시
select custid as '고객ID', cname as '고객명', phone from customertbl where cname like '박%' or 
cname like '정%' or cname like '김%';

-- 문10) customertbl테이블에서 phone가 null인 자료들의 custid, cname 검색
select custid,cname from customertbl where phone is null;
-- 문11) customertbl테이블에서 phone가 null인 아닌 자료들의 custid, cname 검색
select custid,cname from customertbl where phone is not null;
-- 문12) customertbl테이블에서 address를 검색하되 중복된 자료는 하나만 표시
select distinct address from customertbl;
--------------------------------------------------------------

-- 1. porderTBL 테이블에서 orderdate, pcode, amount 검색
select orderdate,pcode,amount from pordertbl;
-- 2. 컬럼명에 별명을 붙이기
--    내부적으로 처리할 때는 컬럼명을 사용하고, 보여주는 화면에서 별명
--    porderTBL 테이블에서 orderdate, pcode, amount 검색하되
--    pcode는 제품코드, orderdate는 주문 날짜, amount 주문수량으로 표시
select orderdate as '주문 날짜', pcode as '제품코드', amount as '주문수량' from pordertbl;

-- 3. pordertbl 테이블에서 custid가 c1 이거나 c3인 제품들의
--    orderdate(주문날짜), custid(회원아이디), amount(수량)
select orderdate as '주문날짜', custid as '회원아이디', amount as '수량' from pordertbl where custid in ('c1','c3');

-- 4. customerTBL 테이블에서 phone이 null 자료들의 cname(고객이름), address(주소)를
--  검색하시오.
select cname as '고객이름', address as '주소' from customertbl where phone is null;

-- 5. customerTBL 테이블에서 성별(gender)가 '여'이고 address가 '강남'으로 끝나는 자료를 검색
select * from customertbl where gender ='여' and address like '%강남';

-- 6. productbl 테이블에서 pname(과일이름)이 '바'로 시작하거나 price가 1000이상 2500이하인
-- 자료들의 pcode(상품 코드), pname(과일이름), region(생산지)를 검색하시오.
select pcode as '상품 코드', pname as '과일이름', region as '생산지' from producttbl where pname like '바%' and
price between 1000 and 2500;

-- 7. pordertbl 테이블에서 custid가 'c1', 'c3', 'c5'가 아닌 자료들의
-- orderid(주문아이디), pcode(제품코드), custid(고객코드), amount(주문 수량)을
-- 검색 
select orderid as '주문 아이디', pcode  as '제품코드', custid as '고객코드', amount as '주문 수량'
from pordertbl where custid not in ('c1','c3','c5');

-- 8. producttbl테이블에서 가격을 기준으로 오름차순 정렬하여 검색하시오.
select * from producttbl order by price asc;

-- 9. pordertbl테이블에서 custid의 중복을 제외하고 주문한 고객 코드(custid)를 검색하시오.
-- distinct 컬럼명 - 컬럼에서 중복된 자료를 제외한다.
select distinct custid as '고객 코드' from pordertbl;