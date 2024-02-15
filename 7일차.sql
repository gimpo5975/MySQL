use jointestdb;
/*
  저장 프로시저(stored procedure) : mysql에서 제공되는 프로그램 기능
      쿼리문의 집합으로 어떠한 동작을 일괄 처리하기 위한 용도로 사용
        데이터베이스 개체 중 하나다. 테이블 처럼 각 데이터베이스 내부에 저장된다.
        <형식>
        delimiter 구분자   -- 구분자는 어떤 것이든 상관 없음. $$, //, $,...
        create procedure 스토어드프로시저명1()    -- 프로시저 만들기
         begin  -- 스토어드 프로시저를 시작하는 부분
                  sql문을 사용한 프로그래밍
         end 구분자 -- 스토어드 프로시저가 끝나는 부분
      delimiter ; -- 다음 sql문들을 위해서 반드시 세미콜론(;)으로 마무리 해야 함
        
       delimiter 구분자   -- 구분자는 어떤 것이든 상관 없음. $$, //, $,...
        create procedure 스토어드프로시저명2()    -- 프로시저 만들기
         begin  -- 스토어드 프로시저를 시작하는 부분
                  sql문을 사용한 프로그래밍
         end 구분자 -- 스토어드 프로시저가 끝나는 부분
      delimiter ; -- 다음 sql문들을 위해서 반드시 세미콜론(;)으로 마무리 해야 함
        
      call 스토어드프로시저명1()  -- 프로시저를 호출(프로시저를 사용하려고 할 때)
        call 스토어드프로시저명2() 
  */
  drop procedure if exists testProc;  -- 만약 testProc 스토어드 프로시저가 있으면 제거
  --  drop procedure testProc;
  
  -- 스토어드 프로시저 생성 
  delimiter //  
  create procedure testProc()
   begin
      select cname, address, phone
      from customertbl
        where phone is not null;

    end //
  delimiter ;  
  -- 선언, 구분자를 ;로 선언
  
  -- 스토어드 프로시저가 필요한 부분에서 호출
  call testProc();

drop procedure if exists ifProc;  -- 만약 testProc 스토어드 프로시저가 있으면 제거
  --  drop procedure ifProc;

  /*
    프로시저의 실행문장 끝 - ;
   -- 변수 선언 :  declare 변수명  타입;
   -- 변수에 값 담기 :  set 변수명 = 값;   
   if 조건 then
      select 조건이 참일 때 실행할 문장;
   end if;  -- if문 종료
    
    if 조건 then
      select 조건이 참일 때 실행할 문장;
   else
      select 조건이 거짓일 때 실행할 문장;
   end if;  -- if 문 종료
  
  */
    
  -- 스토어드 프로시저 생성 
     -- 선언, 구분자를 선언
  delimiter //  
  create procedure ifProc()
   begin
      declare jumsu int;
        set jumsu = 100;
        
        if jumsu>=80 then
         select "80점 이상으로 합격";
        else
         select "80점 미만으로 불합격";
      end if;

    end //
  delimiter ;  

   call ifProc();

drop procedure if exists ifProc2;  
delimiter //  
  create procedure ifProc2()
   begin
      declare score int;
        set score = 30;
        
        if score>=80 then
         select "상" as "성적";
        elseif score>=60 then
         select "중" as "성적";
      else
         select "하" as "성적";
      end if;

    end //
  delimiter ;  

call ifProc2();

/*
   case
      when 조건 then
          조건을 만족할 때 실행할 문장;
      when 조건 then
          실행할 문장
             ....
      else
          실행할 문장;
      end case;
*/
drop procedure if exists caseProce;  
delimiter //  
 create procedure caseProce()
   begin
      declare score int;
        declare grade char(1);
        set score = 70;
        
        case
         when score >=90 then
            set grade = 'A';
         when score >=80 then
            set grade = 'B';
         when score >=70 then
            set grade = 'C';
         when score >=60 then
            set grade = 'D';
         else
            set grade = 'F';
        end case;
      
        select concat('취득 점수는 ', score, '입니다') as '점수', concat('학점은 ', grade) as '학점';
    end //
  delimiter ;  

call caseProce();

-- 1. productTBL 테이블에서 pcode가 'ba123' 또는 'or321'인 자료 검색 스토어드프로시저 작성
--    pname, price, region 검색
--    pcodeProce  : 스토어드 프로시저명

 drop procedure if exists pcodeProce;  -- 만약 testProc 스토어드 프로시저가 있으면 제거
   
  -- 스토어드 프로시저 생성 
  delimiter //  
  create procedure pcodeProce()
   begin
      select pname, price, region
      from producttbl
        where pcode in('ba123' , 'or321');

    end //
  delimiter ;  
-- where pcode ='ba123' or pcode='or321';

call pcodeProce();

-- 2. su라는 변수에 50을 담아 상, 하를 처리하는 스토어드 프로시저 작성
--  su가 80점 이상이면 '상',  su가 80점 미만 하'로 처리
-- scoreProce : 스토어드 프로시저명

drop procedure if exists scoreProce;  
delimiter //  
  create procedure scoreProce()
   begin
      declare su int;
        set su = 50;
        
        if su>=80 then
         select "상" as "성적";
        else
         select "하" as "성적";
      end if;

    end //
  delimiter ;  

call scoreProce();

-- 3. pordertbl 테이블을 custid가 c2이고 amount 가 8인 자료 이용해서 주문일 몇일째인지를 구한 후
--  구한 날짜가 3일 이전이면  주문일은 아직 3일이 되지 않았습니다.
--  3일 이후이면 주문일이 3일이 지났습니다로  표시하는 스토어드프로시저 작성
-- 스토어드 프로시저명 : orderdateProce

-- 현재 날짜 : current_date()
-- 날짜 차이 : datediff(현재날짜, 주문일자)
-- 날짜 변수 타입 : date

drop procedure if exists orderdateProce;  
delimiter //  
  create procedure orderdateProce()
   begin
      declare jumun date;  /* 주문일자 */
        declare curdate date;  /* 오늘날짜 */
        declare days int ;  /* 주문 경과 일수 */
        
        select orderdate into jumun from jointestdb.pordertbl where custid='c2' and amount=8;
        set curdate = current_date();  -- 현재 오늘 날짜
        set days = datediff(curdate, jumun);  -- 두 날짜 차이(주문 경과 일수)
        
        if days >=3  then
         select concat('주문한지 ',days,' 지났습니다. 빠른 배송처리하겠습니다.') as '주문경과일';
      else
         select concat('주문한 일자가 ', days ,' 지났습니다. 즐거운 시간 되세요.') as '주문경과일';
      end if;
    end //
  delimiter ;  

call orderdateProce();





  
select * from pordertbl;
select * from producttbl;
select * from customertbl;
  
  
  
  
  
  