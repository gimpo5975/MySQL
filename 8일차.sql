USE madang;
select * from book;
create table book_back(
   bookid_1 int,
    bookname_1 varchar(40),
    publisher_1 varchar(40),
    price_1 int
);
select * from book_back;

drop trigger insertBook;
 delimiter //
 create trigger insertBook
   after insert 
    on book
    for each row
begin
 declare average int;
 insert into book_back values(NEW.bookid, NEW.bookname, NEW.publisher, NEW.price);
end //
 delimiter ;
 insert into book values(30, '테스트2', '이상미디어1', 53000);
 insert into book values(31, '테스트 1', '이상미디어', 25000);
 select * from book ;
 select * from book_back ;