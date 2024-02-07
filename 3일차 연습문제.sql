use jointestdb;
select * from pordertbl;
-- 1. porderTBL 테이블에서 amount의 합계, 평균, 최댓값, 최솟값 구하기
select sum(amount) as 합계, avg(amount) as 평균, max(amount) as 최댓값, min(amount) as 최솟값 from pordertbl; 
-- 2. porderTBL 테이블에서 amount의 합계, 평균 구하되, 평균을 소수점이하 첫째자리까지
select sum(amount) as 합계, format(avg(amount),1) as 평균 from pordertbl;
-- 3. porderTBL 테이블에서 고객 코드(custid) 가 'c1'인 고객의 amount의 합계 구하기
select custid as c1 ,sum(amount) as 합계 from pordertbl where custid ='c1';
-- 4. porderTBL 테이블에서 전체 판매건수 구하기
select count(orderid) as 판매건수 from pordertbl;
-- 5. porderTBL 테이블에서 고객 코드(custid) 가 'c1'인 고객의 구매건수 구하기 
select count(orderid) as 구매건수 from pordertbl where custid='c1';
-- 6. porderTBL 테이블에서 전체 판매건수 구하기
   -- 출력형태) 전체 주문 건수는  ~~ 건 입니다.  컬럼명 : 주문상황
select concat('전체 주문 건수는',count(orderid),'건 입니다') as 주문상황 from pordertbl;
-- 7. porderTBL 테이블에서 고객 코드(custid) 가 'c2'인 고객의 구매건수 구하기 
-- 출력 형태) c2 고객님의 구매 건수는 ~~ 입니다.   컬럼명 : 주문상황
select concat(custid,' 고객님의 구매 건수는',count(orderid),'건 입니다') as 주문상황 from pordertbl where custid ='c2'; 
-- 8. porderTBL 테이블에서 고객 코드(custid)별로 주문 합계와 평균, 건수를 구하시오.
--  그룹 : 고객코드,  함수 - sum, avg, count
select custid,sum(amount) as 합계, format(avg(amount),1) as 평균, count(orderid) as 건수 from pordertbl group by custid;
-- 9. porderTBL 테이블에서 고객 코드(custid)별 구매수량(amount)의 합계를 구하되,
--  수량(amount)이 20이상인 고객들을 대상으로 구하기.
select custid,sum(amount) as 합계, format(avg(amount),1) as 평균, count(orderid) as 건수 from pordertbl where amount >= 20 group by custid;
-- 10. porderTBL 테이블에서 고객 코드(custid)별 구매수량(amount)의 합계를 구하되,
--  수량(amount)이 20이상인 고객이면서 합계가 50이상인 고객 들을 대상으로  구하기
select custid,sum(amount) as 합계, format(avg(amount),1) as 평균, count(orderid) as 건수 from pordertbl 
where amount >= 20 group by custid having sum(amount)>=50;

-- ----------------------------------------------------------------------------------------------------------------------------------------------
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


------------------------------------------
-- 1. porderTBL 테이블에서 amount의 합계, 평균, 최댓값, 최솟값 구하기

-- 2. porderTBL 테이블에서 amount의 합계, 평균 구하되, 평균을 소수점이하 첫째자리까지

-- 3. porderTBL 테이블에서 고객 코드(custid) 가 'c1'인 고객의 amount의 합계 구하기

-- 4. porderTBL 테이블에서 전체 판매건수 구하기

-- 5. porderTBL 테이블에서 고객 코드(custid) 가 'c1'인 고객의 구매건수 구하기 

-- 6. porderTBL 테이블에서 전체 판매건수 구하기
	-- 출력형태) 전체 주문 건수는  ~~ 건 입니다.  컬럼명 : 주문상황

-- 7. porderTBL 테이블에서 고객 코드(custid) 가 'c2'인 고객의 구매건수 구하기 
-- 출력 형태) c2 고객님의 구매 건수는 ~~ 입니다.   컬럼명 : 주문상황

-- 8. porderTBL 테이블에서 고객 코드(custid)별로 주문 합계와 평균, 건수를 구하시오.
--  그룹 : 고객코드,  함수 - sum, avg, count

-- 9. porderTBL 테이블에서 고객 코드(custid)별 구매수량(amount)의 합계를 구하되,
--  수량(amount)이 20이상인 고객들을 대상으로 구하기.

-- 10. porderTBL 테이블에서 고객 코드(custid)별 구매수량(amount)의 합계를 구하되,
--  수량(amount)이 20이상인 고객이면서 합계가 50이상인 고객 들을 대상으로  구하기

--------------------------------------------


-- 문제1) productdb를 삭제하시오.
-- drop 객체 삭제할개체의 이름
drop database productdb;
-- 문제2) prodb라는 데이터베이스를 생성하시오.
-- create 개체종류 개체명
create database prodb;

-- 문제3) prodb에 작업할 수 있도록 prodb를 활성화시키시오.
-- use 데이터베이스명;
use prodb;
-- 문제4) prodb에 custbl 테이블을 생성
/* 컬럼명 : custid - char(5), null 허용하지 않음(반드시 입력해야 함), 기본키로 설정
		   cname - varchar(20) null 허용하지 않음
		   gender - char(4) 
           address - varchar(50)
           phone - char(20)
*/

drop table if exists custbl;

-- create 개체종류 개체명
create table custbl(
custid char(5) not null primary key,
cname varchar(20) not null,
gender char(4),
address varchar(50),
phone char(20)
);

-- 문제5) 테이블이 제대로 만들어졌는지 확인
-- select
select * from custbl;

-- 문제6) custbl에 다음 데이터를 삽입하시오.
-- insert into 테이블명(컬럼명, 컬럼명,...) values(값1, 값2,...);
insert into custbl(custid,cname,gender,address,phone) values('c1', '김미연','여','관악','010-123-4567');
insert into custbl(custid,cname,gender,address,phone) values('c2','박보검','남','송파', NULL);
insert into custbl(custid,cname,gender,address,phone) values('c3','이승기','남','동작','010-234-4567');
insert into custbl(custid,cname,gender,address,phone) values('c4','정애란','여','관악','010-134-4568');
insert into custbl(custid,cname,gender,address,phone) values('c5','윤태화','여','동작', NULL);
insert into custbl(custid,cname,gender,address,phone) values('c6','김태연','남','관악','010-237-4570');
insert into custbl(custid,cname,gender,address,phone) values('c7','최미경','여','강남','010-284-4571');
insert into custbl(custid,cname,gender,address,phone) values('c8','이미란','여','강남','010-333-4572');
insert into custbl(custid,cname,gender,address,phone) values('c9','박지성','남','신림','010-444-4573');
insert into custbl(custid,cname,gender,address,phone) values('c10','박세리','여','송파', NULL);
insert into custbl(custid,cname,gender,address,phone) values('c21','박민성','남','신림','010-444-4573');

-- 문제7) prodb인 데이터베이스에 protbl 테이블을 생성한후 제시된 자료를 삽입하시오.
-- create,  insert
/*
	pcode - char(10) 반드시 입력해야 함, 기본키로 설정
	pname - varchar(50)  반드시 입력해야 함
    price - int 반드시 입력해야 함
    region - varchar(100) 반드시 입력해야 함
*/
    -- int 약 -21억 ~ 약 21억
    -- small -32768 ~ 32767
    -- date : 날짜
    -- primary key : null 허용하지 않고, 중복허용하지 않음(유일하다)
    -- unique : 중복허용하지 않음(유일하다), null 허용
    --         email 입력한다면 - 유일, 입력할 수도 있고 안할 수도 있음(필수입력아닐때)
	--         email varchar(20) uique
drop table if exists protbl;
create table protbl(
pcode char(10) not null primary key,
pname varchar(50) not null,
price int not null,
region varchar(100) not null
);
select * from protbl;
insert into protbl (pcode,pname,price,region) values ('ba123','바나나',2300,'필리핀');
insert into protbl (pcode,pname,price,region) values ('ap231','사과',1000,'대구');
insert into protbl (pcode,pname,price,region) values ('or321','오렌지',500,'필라델피아');
insert into protbl (pcode,pname,price,region) values ('st341','딸기',700,'논산');
insert into protbl (pcode,pname,price,region) values ('ma456','망고',1500,'베트남');

-- 문제8)custbl테이블에서 gender가 '남'인 자료만  모든 컬럼을 검색
-- 검색 : select ,   gender가 '남'이라는 조건 : where 
-- select * 
select * from custbl where gender='남';

-- 문제9) custbl테이블에서 address가 '송파'인 자료들 중
-- custid, cname, phone만 검색
select custid,cname,phone from custbl where address='송파';
-- 문제10) custbl테이블에서 address가 '관악'인 아닌 자료들 중
-- custid, cname, address만 검색하되 custid는 고객ID, cname은 고객명으로
-- 컬럼명을 출력
select custid as 고객ID, cname as 고객명, address as 주소 from custbl where address <> '관악';

-- 문제11) custbl테이블에서  address가 '송파' 아니고 gender가 '남'인
-- 자료 중 cname과  phone, address만 검색하되,  cname은 고객명으로  phone은 휴대폰으로
-- 컬럼명을 표시하고, address를 기준으로 내림차순 정렬하시오.
select cname as 고객명, phone as 휴대폰, address as 주소
from custbl
where address <> '송파' and gender='남'
order by address desc;
-- 문제12) protbl에서 price가 1000이상 2300이하인 자료들의 pcode, pname 검색
-- 단 pcode는 상품코드, pname은 상품명으로 컬럼명을 표시
select pcode as 상품코드, pname as 상품명 from protbl where price between 1000 and 2300;
-- 문제13) protbl에서 price가 1000이상 2300이하인 자료들의 pcode, pname, price검색
-- 단 pcode는 상품코드, pname 은 상품명, price는 가격 컬럼명을 표시하도 천단위구분기호로 숫자를 표시
-- format(숫자, 소수점 이하 자릿수) - 소숫점이하를 표시하고 숫자에 천단위 구분 기호 표시
-- format(78957, 1)  => 78,957.0 
select pcode as 상품코드, pname as 상품명, format(price,0) as 가격 from protbl where price between 1000 and 2300;

-- 문제14)  protbl에서 price가 2000이상이거나 700이하인 자료들의
-- pname과 region을 검색하되, pname은 상품명, region은 원산지로 컬럼명 표시
select pname as 상품명, price as 상품가격 ,region as 원산지 from protbl where price <=700 or price>=2300;
select * from protbl;
-- 문제15)  protbl에서 price가 1000미만이거나 pname이 오렌지인 자료들의
-- pname과 region을 검색하되, pname은 상품명, region은 원산지로 컬럼명 표시
select pname as 상품명, region as 원산지, price as 가격 from protbl where price<1000 or pname='오렌지';

-- 문제16) protbl에서 pname이 오렌지, 바나나, 딸기인 자료들을 검색하되, 
-- pname을 기준으로 오름차순 정렬 하시오.
select * from protbl where pname in ('오렌지','바나나','딸기') order by pname;
drop table if exists pordertbl;
-- 문제17) 테이블명이 pordertbl인 테이블을 생성
create table pordertbl(
orderid int auto_increment primary key,
dateorder date,
pcode char(10) not null,
custid char(5) not null,
amount smallint default 1,
foreign key (pcode) references protbl(pcode) on delete cascade,
foreign key (custid) references custbl(custid) on delete cascade
);

/*
  orderid  정수,  자동으로 숫자가 증가하게, 기본키, 중복허용하지 않음
  dateorder 날짜 
  pcode char(10) not null,  외래키 (protbl)
  custid char(5) not null, 외래키(custbl)
  amount smallint  주문량, 기본값은 1으로 처리
*/

insert into pordertbl values(null,'2024-02-07','ba123','c1',10);

select * from pordertbl;
-- 문제18) pordertbl  테이블에서 amount 의 합계와 평균과 최댓값을 구하시오.
select sum(amount) as 합계,format(avg(amount),1) as 평균,max(amount) as 최댓값 from pordertbl; 

-- 문제19) pordertbl  테이블에서  주문(amount)  건수를 구하시오.
select count(amount) from pordertbl;
-- 문제20) custbl테이블에서 회원수를 구하되 아래 형태처럼 구하시오.
 --    회원수 :  ~ 명
select concat('회원수 : ',count(custid),'명') as custid from pordertbl;
-- 문제 21) protbl 테이블에서 판매가격이 가장 높은 금액을 구하되
--   천단위 구분 기호를 표시하시오.
select * from protbl;
select format(max(price),0) as '가장 비싼 금액' from protbl;
-- 문제 22)  pordertbl  테이블에서 주문(amount) 수량이 20개 이상인 상품의
-- 합계와 평균을 구하시오.
select * from pordertbl;
select sum(amount) as 합계, format(avg(amount),1) as 평균 from pordertbl where amount >= 20;
-- 문제23) custbl테이블에서 주소(address)가 '송파'인 사람은 몇명인지 구하시오.
select * from custbl;
select count(custid) as 총합
from custbl
where address='송파';