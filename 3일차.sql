use jointestdb;

create table mm(
	id int primary key not null,
    name char(5) not null
);

select * from mm;
insert into mm(id, name) values(1, '홍길동');
insert into mm(id, name) values(2,'김자바');
/*
	자동으로 번호 증가
	MySql : 테이블 생성시 컬럼명 뒤에 적음,  컬럼명의 타입 반드시 정수형이어야 함
			id int primary key auto_increment
			auto_increment - 1씩 증가
			auto_increment = 10  - 10씩 증가
            auto_increment = 증가하려는 값 -> 값만큼 증가
				insert into mm2(id, name) values(null, '이강산');
	Oracle : 시퀀스 작성
				create sequence 시퀀스명
					increment by 증가값  -- 생략 가능
                    start with 값        -- 생략가능
					maxvalue 값  -- 생략가능
                    minvalue 값  -- 생략가능
					nocycle | cycle  - 최댓값에 도달했을 때 어떻게 할 것인지. 생략가능
					nocache | cache -- 캐시 할당 여부, 생략 가능
                    noorder | order --  생성순서 여부 , 생략 가능
                 ;
			  insert into mm2(id, name) values(시퀀스명.NEXTVAL, '이강산')

*/

drop table if exists mm2;
create table mm2(
	id int primary key auto_increment not null,
    name char(10) not null,
    gender char(4) default '남',  -- 아무런 값도 입력하지 않으면 무조건 '남'으로 입력
    amount int check (amount>=500)  -- 500이상만 입력할 수 있도록, 체크함
 );

select * from mm2;
insert into mm2(id, name, gender, amount) values(null, '이바다','여', 550);
-- insert into mm2(name,amount) values('남하늘', 450);  
                   -- check 체약에 걸림, 500이상만 입력가능
insert into mm2(name, amount) values('남하늘', 1500); -- id는 자동증가, gender- default로 입력
insert into mm2(id, name, gender, amount) values(null, '이바다','여', 550),
						(null, '김바다','여', 550),
                        (null, '최바다','여', 550);
-- ----------------------------------------------------------------
/*
	* 집계함수
		합계 : sum(컬럼명)
		평균 : avg(컬럼명)
        최댓값 : max(컬럼명)
        최솟값 : min(컬럼명)
        개수 : count(*) : 레코드(행, row)의 개수, null 값도 포함한 개수
			   count(컬럼명) : null 값은 제외하고 개수
*/
select * from porderTBL;
select * from productTBL;
select * from customerTBL;

-- 1. porderTBL 테이블에서 amount의 합계, 평균, 최댓값, 최솟값 구하기
select sum(amount) as 합계, avg(amount) as 평균, max(amount), min(amount)
from porderTBL;

-- 2. porderTBL 테이블에서 amount의 합계, 평균 구하되, 평균을 소수점이하 첫째자리까지
--   format(컬럼명 또는 식, 형식)
--   round(컬럼명 또는 식, 자릿수) : 반올림해서 자릿수까지 구함
--     -3 -2 -1 0     1  2  3  4  -> 자릿수
--     4  5  6  7  .  3  8  7  5 
select sum(amount) as 합계, format(avg(amount), 1) as 평균
from porderTBL;

select sum(amount) as 합계, round(avg(amount), 1) as 평균
from porderTBL;

-- 3. porderTBL 테이블에서 고객 코드(custid) 가 'c1'인 고객의 amount의 합계 구하기
select custid as 고객코드, sum(amount) as 합계
from porderTBL
where custid = 'c1';

-- 4. porderTBL 테이블에서 전체 판매건수 구하기
select count(*) as 판매건수
from porderTBL ;   -- 출력형태 : 25

		-- 출력형태)  ~~건
		-- concat() : 문자열 연결
        -- mysql
			-- concat(값1, 값2, 값3,...)  : 값1값2
			-- concat('홍길동님 ', concat(count(*) , '건 주문')) -> 홍길동님 3건 주문
        
        -- 오라클
			-- concat(값1, 값2)  : 값1값2
			-- concat('홍길동님 ', concat(count(*) , '건 주문')) -> 홍길동님 3건 주문
select concat(count(*), '건') as 판매건수
from porderTBL;

-- 5. porderTBL 테이블에서 고객 코드(custid) 가 'c1'인 고객의 구매건수 구하기 
select count(custid) as 구매건수
from porderTBL
where custid='c1';

-- 6. porderTBL 테이블에서 전체 판매건수 구하기
-- 출력형태) 전체 주문 건수는  ~~ 건 입니다.  컬럼명 : 주문상황
select concat('전체 주문 건수는 ', count(*), '건 입니다.') as 주문상황
from porderTBL;

-- 7. porderTBL 테이블에서 고객 코드(custid) 가 'c2'인 고객의 구매건수 구하기 
-- 출력 형태) c2 고객님의 구매 건수는 ~~ 입니다.   컬럼명 : 주문상황

select concat(custid, '고객님의 구매 건수는 ', count(custid), '입니다.') as 주문상황
from porderTBL
where custid='c2';

-- ---------------------------------------------------------
/* 그룹 별로 합계, 평균,... group by 묶을 컬럼명
							having  그룹에 해당하는 조건
*/ 

-- 8. porderTBL 테이블에서 고객 코드(custid)별로 주문 합계와 평균, 건수를 구하시오.
--  그룹 : 고객코드,  함수 - sum, avg, count

select custid, sum(amount) as 합계, avg(amount) as 평균, count(custid) as구매건수
from porderTBL
group by custid ;

-- 9. porderTBL 테이블에서 고객 코드(custid)별 구매수량(amount)의 합계를 구하되,
--  수량(amount)이 20이상인 고객들을 대상으로 구하기.
select custid, sum(amount) as 합계
from porderTBL
where amount >= 20
group by custid;

-- 10. porderTBL 테이블에서 고객 코드(custid)별 구매수량(amount)의 합계를 구하되,
--  수량(amount)이 20이상인 고객이면서 합계가 50이상인 고객 들을 대상으로  구하기
select custid, sum(amount) as 합계  -- 5
from porderTBL   -- 1
where amount >= 20  -- 2
group by custid  -- 3
having sum(amount) >=50;  -- 4
