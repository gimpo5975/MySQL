use jointestdb;
-- 문제
-- 1. porderTBL 테이블과  productTBL테이블을 이용해서 판매금액을 구하기
-- orderid, pcode, amount(수량), price(가격), 판매금액(수량 * 가격), pname(제품명)
-- region(원산지)
select orderid, po.pcode, amount as 수량, price as 가격, format((amount*price),0) as 판매금액, pname as 제품명, region as 원산지
from pordertbl po join producttbl pd
on po.pcode = pd.pcode;

-- 2. porderTBL 테이블과  productTBL테이블을 이용해서 pname, 주문금액(수량 * 단가)
--  판매수량(amount)을 검색하되, 판매수량이 50이상인 것만
-- where 조건이용
select pname, format((amount*price),0) as 판매금액, amount as 판매수량
from pordertbl po join producttbl pd
on po.pcode = pd.pcode
where amount>=50;
-- 조인 - 내부조인(inner join)을 이용

-- 3. porderTBL 테이블, productTBL테이블, customerTBL 테이블을 이용하여
-- 주소가 강남으로 끝나고, amount가 50이하인 자료를 찾아
--  orderDate, amount, pname, cname을 검색하시오.
select orderdate, amount, pname, cname, address
from pordertbl po join producttbl pd join customertbl ct
on po.pcode=pd.pcode and po.custid = ct.custid
where amount<=50 and address like '%강남';
-- 4. porderTBL 테이블에서 판매수량이 가장 많은 제품의 최고 판매수량과 pcode를 검색
select pcode, amount from pordertbl where amount=(select max(amount) from pordertbl);
-- porderTBL 테이블에서 판매수량이 가장 많은 제품의 판매수량
select max(amount) from pordertbl;

-- 하위질의문 = 부속질의문 = subquery
--  쿼리문 안에 또다른 쿼리문을 삽입
--  실행은 하위 쿼리부터 실행 됨