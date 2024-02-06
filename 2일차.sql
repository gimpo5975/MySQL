show databases;
use jointestdb;
select * from porderTBL;
select * from productTBL;
select * from customerTBL;

-- 1. porderTBL 테이블에서 orderdate, pcode, amount 검색
select orderdate, pcode, amount
from porderTBL;

-- 2. 컬럼명에 별명을 붙이기
--    내부적으로 처리할 때는 컬럼명을 사용하고, 보여주는 화면에서 별명
--    porderTBL 테이블에서 orderdate, pcode, amount 검색하되
--    pcode는 제품코드, orderdate는 주문 날짜, amount 주문수량으로 표시
--    컬럼명 as 별명(=별칭),    컬럼명 as "주문 날짜",  컬럼명 별명
select orderdate as "주문 날짜", pcode as 제품코드, amount 주문수량
from porderTBL;

-- 3. pordertbl 테이블에서 custid가 c1 이거나 c3인 제품들의
--    orderdate(주문날짜), custid(회원아이디), amount(수량)
--   컬럼명 = 값 or 컬럼명 = 값
--   컬럼명 in(값1, 값2,...)
/*
   select 컬럼명,...
   from  테이블명
   where 조건;
*/
select orderdate as 주문날짜, custid as "회원 아이디", amount as 수량
from pordertbl
where custid = 'c1' or custid ='c3';

select orderdate 주문날짜, custid as "회원 아이디", amount  수량
from pordertbl
where custid in('c1' ,'c3');

-- 4. customerTBL 테이블에서 phone이 null 자료들의 cname(고객이름), address(주소)를
--  검색하시오.
--   null 이다 : is null,    null 이 아니다 : is not null
select cname as 고객이름, address as 주소
from customerTBL
where phone is null ; -- 반드시 컬럼명 조건연산

-- 5. customerTBL 테이블에서 성별(gender)가 '여'이고 address가 '강남'으로 끝나는 자료를 검색
--  ~~이고 and
--  이름이 김으로 시작하고 : 컬럼명 like '김%'  - 첫글자는 반드시 김, 나머지 어떤 글자나 가능
--                            김a, 김가나다, 김123,...
--         점으로 끝나고 :  컬럼명 like '%점' - 마지막 글자는 반드시 점,
--                                          나머지 앞글자는 어떤 것이나 가능, 백화점, 신세계 마트점, 점
--         글자 중에 '화'자가 포함된 것 :  컬럼명 like '%화%' - 백화점, 화장실, 국화,
select *
from customerTBL
where gender='여' and address like '%강남';

-- 6. productbl 테이블에서 pname(과일이름)이 '바'로 시작하거나 price가 1000이상 2500이하인
-- 자료들의 pcode(상품 코드), pname(과일이름), region(생산지)를 검색하시오.
--  컬럼명 >= 값1 and 컬럼명 <= 값2  - 컬럼명 between 값1 and 값2
--  컬럼명 > 값1 and 컬럼명 < 값2  - between 사용불가
--  컬럼명 <> 값1  : 같지 않다. 포함하지 않는다, 서로 다르다
--  컬럼명 = 값1 : 같다, 포함한다.

select pcode as "상품 코드", pname as 과일이름, region as 생산지
from producttbl
where pname like '바%' or price between 1000 and 2500;

select pcode as "상품 코드", pname as 과일이름, region as 생산지
from producttbl
where pname like '바%' or price>=1000 and price<=2500;

-- 7. pordertbl 테이블에서 custid가 'c1', 'c3', 'c5'가 아닌 자료들의
-- orderid(주문아이디), pcode(제품코드), custid(고객코드), amount(주문 수량)을
-- 검색  
--  <> : 같지 않다.   not in(값1,...)  : 값이 아닌것 즉 포함하지 않은 것
select orderid as 주문아이디, pcode as 제품코드, custid as 고객코드, amount as "주문 수량"
from pordertbl
where custid <> 'c1' and custid <> 'c3' and custid <> 'c5';

select orderid as 주문아이디, pcode as 제품코드, custid as 고객코드, amount as "주문 수량"
from pordertbl
where custid not in('c1', 'c3', 'c5');

-- 8. producttbl테이블에서 가격을 기준으로 오름차순 정렬하여 검색하시오.
--  order by : 정렬,    컬럼명 asc : 오름차순 정렬, 컬럼명 desc : 내림차순 정렬
/*
   select
   from
   where
   order by 
*/
select *
from producttbl
-- where  조건이 없을 시 생략 
order by  price asc;

-- 9. pordertbl테이블에서 custid의 중복을 제외하고 주문한 고객 코드(custid)를 검색하시오.
-- distinct 컬럼명 - 컬럼에서 중복된 자료를 제외한다.
select distinct custid
from pordertbl ;

-- 10. customertbl 테이블의 모든 자료를 검색하되, null은 '번호없음'으로 표시하여 출력
-- 화면에 출력할 때만 조건에 맞는 대치문자가 출력이 되고, 실제 저장은 null로 저장 됨
-- mysql : ifnull(컬럼명,대치문자)
-- 			if(컬럼명 is null, null 일때 대치할 값, not null 일때 대치할 값)
-- 오라클 : nvl(컬럼명, 대치문자)
-- 			nvl2(컬럼명, null일때 대치할 값, null이 아닐때 대치할 값)
select custid, cname, gender, address, ifnull(phone, '번호없음') as phone
from customertbl;

use shopdb;
create table productinfotbl(
pcode char(10) not null primary key,
pname varchar(100) not null,
price int default 0 check(price<100000),
region varchar(100) not null 
);

select * from productinfotbl;

insert into productinfotbl(pcode, pname, price, region) values
('a123', 'apple', 50000,'대구');
-- insert into productInfoTBL values('a123', 'apple', 50000, '대구')
insert into productinfotbl(pcode,pname,region) values
('k123','kiwi','제주');
-- insert into productInfoTBL values('k123', 'kiwi', '제주'); -- 에러, 컬럼수가 테이블의 
                  -- 컬럼수와 다르면 컬럼명을 생략할 수 없음
-- insert into productInfoTBL(pcode, pname, price, region)
--       values('o123', 'orange', 150000, '대구');       -- check 조건에 맞지 않음
