use jointestdb;
select * from porderTBL;
select * from productTBL;
select * from customerTBL;
/* 삭제/update 
-- delete from 테이블명; : 구조만 남기고 내용(튜플, 행, 레코드)을 모두 삭제
--                  drop table 테이블명; : 완전 삭제
-- delete from 테이블명 where  조건;  -- 테이블에서 조건에 해당하는 행만 제거

-- update 테이블명 set 업데이트할컬럼명 = 업데이트할 값 where 조건;
*/

delete from productTBL; -- 참조 관계가 설정 되어 있어 삭제 안됨

-- 1. porderTBL테이블에서 custid가 'c1'인 자료를 모두 삭제
delete from porderTBL where custid='c1';
select * from porderTBL;

-- 2. porderTBL 테이블의 모든 자료를 삭제
delete from porderTBL;
select * from porderTBL;

-- 3. porderTBL 테이블 자체를 제거
drop table porderTBL;
select * from porderTBL;

-- 4. customerTBL 테이블에서 gender가 '남'인 자료만 삭제
delete from customerTBL where gender = '남';
select * from customerTBL;

-- 5. customerTBL 테이블에서 address가 '서울 강남'인 자료들을 모두 '강남'으로 수정
update customerTBL set address='강남' where address like '%강남';
select * from customerTBL;

-- 6. productTBL 테이블에서 price를 10%씩 인상하기
update productTBL set price = price * 1.1;
select * from productTBL;

-- 7. productTBL 테이블에서 price가 2000이상인 제품들의 region을 '대구'로 변경
update productTBL set  region='대구' where price >= 2000;
select * from productTBL;

-- 8. productTBL 테이블에서 pname이 '사과' 또는 '망고'인 데이터를 삭제하기
delete from productTBL where pname in('사과', '망고');
-- delete from productTBL where pname='사과' or pname='망고';
select * from productTBL;

-- 9. productTBL 테이블의 데이터를 모두 삭제 하기
delete from productTBL;

-- 10. productTBL 테이블을 완전 삭제하기
drop table productTBL;
-- -------------------------------------------------------
/* join : 관계가 설정되어 있는 테이블들을 연결
		내부조인(inner join, join) : 가장 많이 사용
						양쪽 테이블 모두에서 조건을 만족하는 자료만 조회
                        select 컬럼명,.. 
                        from 연결할 첫번째 테이블명 as 별칭
								inner join 연결할 두 번째 테이블명 as 별칭
                                on 조인 조건
						where 조건;
                         또는
                        select 컬럼명,.. 
                        from 연결할 첫번째 테이블명 as 별칭
								inner join 연결할 두 번째 테이블명 as 별칭
                                on 조인 조건;
		 외부조인(outer join)
			 left outer join = left join : 왼쪽 테이블의 내용은 모두 출력
								오른쪽은 조건에 만족하는 것만 출력
                                select 컬럼명,.. 
								from 연결할 첫번째 테이블명 as 별칭
										left join 연결할 두 번째 테이블명 as 별칭
										on 조인 조건
								where 조건;
                             
             right outer join = right join : 오른쪽 테이블의 내용은 모두 출력
								왼쪽은 조건에 만족하는 것만 출력
			 full outer join = full join : 양쪽 모두 출력
									
		상호조인(cross join)
        셀프조인(self join)

*/
	select orderid,orderDate,pordertbl.pcode, producttbl.pcode, 
			custid, price,  pname,amount, 
			(pordertbl.amount * producttbl.price) as 판매가격
	from pordertbl 
		 inner join producttbl    -- 두 테이블 연결
		 on pordertbl.pcode = producttbl.pcode;  -- 두 테이블을 연결할 조건

-- 1.  pordertbl과  producttbl테이블을 이용해서 orderDate, pcode, 
-- pname,  amount,  판매가격( amount * price)을 조회

-- select O.orderDate, O.pcode, P.pcode, P.pname, O.amount, (O.amount * P.price) as 판매가격    
	select O.orderDate, O.pcode, P.pname, O.amount, (O.amount * P.price) as 판매가격    
	from pordertbl as O   -- pordertbl O
		 inner join producttbl as P -- producttbl P     -- 두 테이블 연결
		 on O.pcode = P.pcode;  -- 두 테이블을 연결할 조건

-- 2. pordertbl 테이블과  customerTBL 테이블을 이용
-- 주문자(cname), 주문일자(orderdate), 개수(amount),  주소(address)를 조회
		select C.cname, O.orderDate, O.amount, C.address
		from porderTBL as O inner join customerTBL as C   -- 두 테이블 연결해서 하나의 테이블로
							on O.custid = C.custid; -- 두 테이블을 연결할 조건

-- 3. pordertbl 테이블과  customerTBL 테이블을 이용
-- cname 이 '김태연'인 사람이 주문한 제품을 검색 
-- 주문자(cname), 주문일자(orderdate), 개수(amount),  주소(address)를 조회
/*
		select 컬럼명,...
        from 연결할 첫번째 테이블명 as 별칭 inner join 연결할 두 번째 테이블명 as 별칭
											on 두 테이블을 연결할 조인 조건
		where 검색 조건;
*/
		select C.cname, O.orderDate, O.amount, C.address
		from pordertbl as O  -- pordertbl O 
				inner join customerTBL as C  -- pordertbl O 
				on O.custid = C.custid 
		where C.cname = '김태연';

-- 4. pordertbl 테이블,  customerTBL 테이블, producttbl 테이블을 모두 이용
-- 주문자(cname), 주문일자(orderdate), 상품명(pname), 
-- 주문수량(amount), 주문금액(amount *  price)
-- 주문수량이 30개이상인 자료만   -- 주문수량 >= 30
-- 주문일자별로 오름차순 정렬하여 조회    -- order by 주문일자 asc(생략 가능, 기본값)
/*
		select 컬럼명,...
        from 연결할 첫번째 테이블명 as 별칭 
					inner join 연결할 두 번째 테이블명 as 별칭
					on 두 테이블을 연결할 조인 조건  -- 두 테이블 연결 끝
                    inner join 세번째로 연결할 테이블명 as 별칭
                    on 세 번째로 연결 조인 조건                    
		where 검색 조건
        order by 정렬할 컬럼명 asc(오름차순) / desc(내림차순);
*/
		select cname, orderdate, pname, amount, (amount * price) as 주문금액
		from customerTBL C 
				inner join porderTBL O  -- 두 테이블 연결1
				on C.custid = O.custid  --  연결조건 1, 참조관계
				inner join productTBL P 
				on O.pcode = P.pcode  -- 연결 조건2,  참조관계
		where amount >= 30
		order by  orderdate asc;

-- 5. pordertbl  테이블과 customertbl테이블을 이용하여
-- left outer join과 right outer join을 비교
/*
								select 컬럼명,.. 
								from 연결할 첫번째 테이블명 as 별칭
										left join 연결할 두 번째 테이블명 as 별칭
										on 조인 조건
								where 조건;
                                
                                select 컬럼명,.. 
								from 연결할 첫번째 테이블명 as 별칭
										right join 연결할 두 번째 테이블명 as 별칭
										on 조인 조건
								where 조건;

*/
-- 1) left outer join 
select * from pordertbl as pt left outer join customertbl as ct on pt.custid=ct.custid;


-- 2) right outer join
select * from pordertbl as pt right outer join customertbl as ct on pt.custid = ct.custid;


-- 6. producttbl과 pordertbl  테이블을 이용하여
-- cross join을 실행하시오.
select * from pordertbl as ot cross join producttbl as pt;