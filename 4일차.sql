use jointestdb;

/*
  조인 : 테이블을 연결해서 마치 하나의 테이블인 것 처럼 사용
      내부 조인
      외부 조인


*/
select * from porderTBL;
select * from productTBL;
select * from customerTBL;


-- 1. porderTBL 테이블과  productTBL테이블을 이용해서 판매금액을 구하기
-- orderid, pcode, amount(수량), price(가격), 판매금액(수량 * 가격), pname(제품명)
-- region(원산지)

-- 연관있음을 알수 있는 것 :  pcode, 참조 관계 설정되어 있음

select porderTBL.orderid, porderTBL.pcode, porderTBL.amount as 수량,
      productTBL.price, (porderTBL.amount * productTBL.price) as 판매금액,
        productTBL.pname as 제품명, productTBL.region as 원산지
from porderTBL, productTBL  -- 테이블을 두개 이상 작성시 콤마(,)로 구분
where porderTBL.pcode = productTBL.pcode ; -- 조건
    -- 테이블명.컬럼명 : 컬럼이 어디에 소속되어 있는지 명확하게 밝히는 것

select O.orderid, O.pcode, O.amount as 수량,
      P.price, (O.amount * P.price) as 판매금액,
        P.pname as 제품명, P.region as 원산지
from porderTBL as O, productTBL P  
             -- alias : 테이블명 as 별칭, 또는 테이블명 별칭
where O.pcode = P.pcode ; -- 조건

select O.orderid, O.pcode, O.amount as 수량,
      P.price, (O.amount * P.price) as 판매금액,
        P.pname as 제품명, P.region as 원산지
from porderTBL O inner join productTBL P   
      on O.pcode = P.pcode;   -- 두 테이블에서 여기 조건과 일치하는 것만 검색

-- 2. porderTBL 테이블과  productTBL테이블을 이용해서 pname, 주문금액(수량 * 단가)
--  판매수량(amount)을 검색하되, 판매수량이 50이상인 것만
-- where 조건이용
   select pname, amount, (amount * price) as 주문금액
   from porderTBL O, productTBL P
   where O.pcode = P.pcode and O.amount >= 50 ;

-- 조인 - 내부조인(inner join)을 이용
   select pname, amount, (amount * price) as 주문금액
   from porderTBL O inner join productTBL P
         On O.pcode = P.pcode 
   where O.amount >= 50 ;
 
-- 3. porderTBL 테이블, productTBL테이블, customerTBL 테이블을 이용하여
-- 주소가 강남으로 끝나고, amount가 50이하인 자료를 찾아
--  orderDate, amount, pname, cname을 검색하시오.
 
--  select orderDate, amount, pname, cname
 select O.orderDate, O.amount, P.pname, c.cname
 from  porderTBL O inner join productTBL P
         inner join customerTBL C
      on O.pcode = P.pcode and O.custid = C.custid
 where  O.amount >= 50;

-- 4. porderTBL 테이블에서 판매수량이 가장 많은 제품의 최고 판매수량과 pcode를 검색

-- porderTBL 테이블에서 판매수량이 가장 많은 제품의 판매수량
   select max(amount) from porderTBL;

select * from pordertbl;
-- porderTBL 테이블에서 판매수량이 가장 많은 제품들의 최고 판매수량과 pcode
   select pcode, max(amount) 
    from porderTBL 
    group by pcode;

-- porderTBL 테이블에서 판매수량이 가장 많은 제품의 최고 판매수량과 pcode를 검색
-- 하위질의문 = 부속질의문 = subquery
--  쿼리문 안에 또다른 쿼리문을 삽입
--  실행은 하위 쿼리부터 실행 됨

select pcode, amount
from porderTBL
where amount = (   -- porderTBL 테이블에서 가장 큰 금액을 찾고, 그 값이 amount와 같은 것
               -- 이렇게 하위절을 쓰는 까닭은 where에는 집계함수를 사용할 없기 때문
                 select max(amount)
             from porderTBL
                ); 












