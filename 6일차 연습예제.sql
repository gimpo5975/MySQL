-- 1. 마당서점의 고객별 판매액을 출력(고객이름과 고객별 판매액 출력)
-- customer 테이블, orders 테이블 이용
select (select name from Customer C where O.custid = C.custid ) as name, sum(saleprice) from  orders O 
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
--   더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 검색
 select orderid, saleprice 
   from orders
   where saleprice > (select max(saleprice)
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
-- ======================================
 -- 1. pordertbl 테이블을 이용하여 order_view 뷰를 만드시오.
 --  뷰에는  orderDate, amount 만 보여지게
--  create view 뷰이름 as select 문;
 create view order_view 
   as 
      select orderdate, amount 
      from  pordertbl ;
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
-- 3-1. woman_view라는 뷰를 제거하시오.
drop view woman_view;
-- 4. order_view 테이블에서 orderdate별로  amount 의 합계
--  orderdate가 2023-12-01 이후인 자료만 그룹 짓기
select orderdate, sum(amount)
   from order_view
   where orderdate >= '2023-12-01'
   group by orderdate
    order by orderdate desc;  -- 내림 차순 정렬