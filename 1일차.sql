drop database if exists shopdb;	-- Ctrl+Enter : 현재 커서 있는 구문만 실행
								-- Ctrl + Shift + Enter : 범위 설정한 부분을 한번에 실행
create database shopdb;    -- shopdb 데이터베이스 생성    
drop table if exists productTBL; -- productTBL이 존재하다면 제거하라

use shopdb; -- shopdb 데이터베이스 열기(접속)

-- create table productTBL( -- productTBL 테이블 생성
-- 	pcode char(10) not null primary key,
--     pname varchar(100) not null,	-- 오라클 varchar2(100)
--     price int not null, -- 오라클 : number, number(크기)
--     region varchar(100) not null
-- );                        

create table productTBL( -- productTBL 테이블 생성
	pcode char(10) not null ,
    pname varchar(100) not null,	-- 오라클 varchar2(100)
    price int not null, -- 오라클 : number, number(크기)
    region varchar(100) not null,
    primary key (pcode)
);                        

select * from productTBL;

drop table if exists porderTBL;

create table porderTBL( -- porderTBL 테이블 생성
	orderid int not null,
    dateOrder date not null,
    pcode char(10),	-- foreign key(외래키, FK)
    custid char(5),	-- foreign key(외래키, FK)
	amount int not null,
    foreign key (pcode) references productTBL(pcode),	-- 제약조건명은 알아서 설정됨
   --  				제약조건명	          내것 컬럼명             참조하는 테이블명(컬럼명)
    -- constraint pcode_FK foreign key (pcode) references productTBL(pcode),
    primary key (orderid)
);

-- 제약 조건 추가 => custid에 외래키 제약을 설정
alter table pordertbl 
add constraint custid_FK foreign key (custid) 
references customertbl(custid) 
on delete cascade;	-- 부모가 삭제되면 자식도 함께 삭제


select * from porderTBL;

drop table if exists customerTBL;

create table customerTBL(	-- customerTBL 생성 
	custid char(5) not null,
    cname varchar(100) not null,
    gender char(4),
    address varchar(100) not null,
    phone char(20),
    primary key (custid)
);
select * from customerTBL;

--    자료 삽입 테이블명(컬럼명,...) 
insert into producttbl(pcode, pname, price, region)
	--     (값,...) 컬럼명의 개수와 값의 개수와 위치가 일치해야한다.
    values ('ba123', '바나나', 2300, '필리핀');
insert into producttbl values ('ap231', '사과', 1000, '대구');

