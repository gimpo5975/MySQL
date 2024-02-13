use jointestdb;
-- 1. porderTBL테이블에서 custid가 'c1'인 자료를 모두 삭제
delete from pordertbl where custid='c1'; 
select * from pordertbl;
-- 2. porderTBL 테이블의 모든 자료를 삭제
delete from pordertbl;
-- 3. porderTBL 테이블 자체를 제거
drop table pordertbl;
-- 4. customerTBL 테이블에서 gender가 '남'인 자료만 삭제
select * from customertbl;
delete from customertbl where gender='남'; 
-- 5. customerTBL 테이블에서 address가 '서울 강남'인 자료들을 모두 '강남'으로 수정
update customertbl set address = '강남' where address like '서울 강남';
-- 6. productTBL 테이블에서 price를 10%씩 인상하기
update producttbl set price = price*1.1;
-- 7. productTBL 테이블에서 price가 2000이상인 제품들의 region을 '대구'로 변경
update producttbl set region = '대구' where price >=2000;
select * from producttbl;
-- 8. productTBL 테이블에서 pname이 '사과' 또는 '망고'인 데이터를 삭제하기
delete from producttbl where pname in ('사과','망고');
-- 9. productTBL 테이블의 데이터를 모두 삭제 하기
delete from producttbl;
-- 10. productTBL 테이블을 완전 삭제하기
drop table producttbl;