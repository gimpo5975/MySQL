-- 교재 내용
USE madang;
select * from book;
select * from customer;
select * from Orders;
select * from Imported_Book;
/*
  하위 쿼리(subquery, 부속질의) : 하나의 sql 문 안에 다른 sql 문이 중첩된 질의문
         데이터가 대량일 경우 데이터를 모두 합쳐서 연산하는 조인보다는
            필요한 데이터만 찾아서 공급해 주는 부속질의의 성능이 더 좋음
      1) 스칼라 부속질의(scalar subquery) : select 절에 사용
                                    단일 값을 반환
        2) 인라인 뷰(inline view, table subquery) : from 절에 사용
                                    결과를 뷰 형태로 반환
        3) 중첩 질의(nested subquery) : where 절에 사용
    
    - 실행순서는 부속질의 부터 실행하고 주질의 문을 실행
    
    -- 부속질의 결과가 하나의 행일 수도 있지만  (>, <, >=,<=, =, <>)
        여러 행인 경우 (any, all, in)
        any(=some) : 서브쿼리의 여러 개의 결과 중 한 가지만 만족해도 됨(or 와 비슷)
        all : 서브쿼리의 여러 개의 결과를 모두 만족해야 함( and 와 비슷)
        in  : 서브쿼리의 여러 개의 결과와 같은 것, in() 해당하는 것들을 뽑음
       
*/
-- 1. 마당서점의 고객별 판매액을 출력(고객이름과 고객별 판매액 출력)
-- customer 테이블, orders 테이블 이용
 
 -- 스칼라 하위 쿼리 이용
 select (select name 
         from Customer C 
            where O.custid = C.custid ) as name, 
      sum(saleprice)
from  orders O 
group by O.custid;
 
 -- join을 이용 
select name, sum(saleprice)
from orders O 
   inner join customer c
    on O.custid = C.custid
group by O.custid;

-- 2. orders 테이블에서 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 검색
-- 주의 : where 절에는 집계함수(sum, avg, max, min,...)를 사용할 수 없음
-- 중첩질의 (하위 쿼리)
   select orderid, saleprice
   from Orders
   -- where saleprice <= avg(saleprice);  -- 에러, where절에 집계함수 사용할 수 없음
   where saleprice <= ( select avg(saleprice)
                    from orders);  -- 부속 질의 부터 실행 , 평균 주문금액 이하


-- 3. orders 테이블에서 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 검색
   select orderid, custid, saleprice
   from orders o1
   where saleprice > (select avg(saleprice)
                  from orders o2
                        where o1.custid = o2.custid ); -- 각 고객의 평균 주문금액보다

-- 4. orders 테이블에서 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하기
   select sum(saleprice) as 총판매액
    from orders
    where custid in (select custid
                 from customer
                      where address like '%대한민국%' ); -- like '대한민국%'

-- 5. orders 테이블에서 대한민국에 거주하지 않는 고객에게 판매한 도서의 총 판매액을 구하기
   select sum(saleprice) as 총판매액
    from orders
    where custid not in (select custid
                 from customer
                      where address like '%대한민국%' ); -- like '대한민국%'


-- 6. orders 테이블에서 3번 고객이 주문한 도서의 최고 금액보다 
--    더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 검색
   select orderid, saleprice 
   from orders
   where saleprice > (select max(saleprice)
                  from orders
                  where custid = 3);

   select orderid, saleprice 
   from orders
   where saleprice > all(select saleprice
                  from orders
                  where custid = 3);


-- 7. Exists 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하기 
select sum(saleprice) as 총판매액
from orders O
where Exists (select *
           from customer C
           where address like '%대한민국%' and O.custid = C.custid);

-- 8. customer 테이블과 orders 테이블을 이용하여 고객번호가 2 이하인 
--  고객의 판매액을 구하기 
-- 고객 이름과 고객별 판매액 출력
-- 인라인 뷰
select name, sum(saleprice) as 판매액
from ( select custid, name
      from customer
        where custid<=2) as C,
        orders as O
where  C.custid = O.custid
group by C.name;

-- --------------------------------
 /* 
   뷰(view) : 가상 테이블, 논리적 테이블
            일반 사용자 입장에서는 테이블과 같은객체
      장점 : 보안에 도움이 된다.
            복잡한 쿼리를 단순화 시켜 줄 수 있다.
   create view 뷰이름 as select 컬럼명,... from 테이블명 where 조건;
     -- 수정 가능한 뷰 : or replace
   create or replace view 뷰이름([컬럼명,...]) as select 컬럼명,... from 테이블명 where 조건;
 */
use jointestdb;
select * from pordertbl;
select * from producttbl;
select * from customertbl;
 -- 1. pordertbl 테이블을 이용하여 order_view 뷰를 만드시오.
 --  뷰에는  orderDate, amount 만 보여지게
--  create view 뷰이름 as select 문;
   create view order_view 
   as 
      select orderdate, amount 
      from  pordertbl ;

   create or replace view  order_view   -- 수정할 수 있는 view
   as 
      select orderdate, amount 
      from  pordertbl ;
      
   select * from order_view;  -- 확인도 뷰테이블로 확인, 다만 가상 테이블

-- 2. order_view 테이블에서 amount 가 40이상인 자료만 검색
   select orderdate, amount
   from order_view
   where amount>=40;

-- 3. customertbl테이블에서 gender가 '여'인 자료들을 이용해 woman_view라는 뷰를 생성하시오.
-- 뷰에는 cname, address, phone만 
   create view woman_view
   as 
      select cname, address, phone
      from customertbl
      where gender='여';

   select * from woman_view;

-- 3-1. woman_view라는 뷰를 제거하시오.
   drop view woman_view;

-- 4. order_view 테이블에서 orderdate별로  amount 의 합계
--  orderdate가 2023-12-01 이후인 자료만 그룹 짓기
  /*
   select
   from
   where
   group by
   having
   order by
  */
   select orderdate, sum(amount)
   from order_view
   where orderdate >= '2023-12-01'
   group by orderdate
    order by orderdate desc;  -- 내림 차순 정렬





