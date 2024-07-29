create table member(
	id varchar2(10) not null,	-- 아이디
	pass varchar2(10) not null, -- 패스워드
	name varchar2(30) not null, -- 이름
	regidate date default sysdate not null, -- 생성날짜
	primary key(id) -- 기본키 생성
) -- 회원용 테이블

create table board(
	num number primary key,		-- 게시글 번호(시퀀스)
	title varchar2(200) not null, -- 제목
	content varchar2(2000) not null, -- 내용
	id varchar2(10) not null, -- 작성자 (= member id)
	postdate date default sysdate not null, -- 작성일
	visitcount number(6) -- 조회수
) -- 게시글 테이블

-- 외래키 설정(부모(member)-자식(board))
alter table board add constraint board_member_fk foreign key(id) references member(id);

-- 시퀀스 설정(자동 번호 주입)
create sequence seq_board_num
	increment by 1	--증가값
	start with 1	-- 시작값
	minvalue 1		-- 최소값 1
	nomaxvalue		-- 최대값 X
	nocycle			-- 반복 없음
	nocache;		-- 미리 만들지 않음
	
drop sequence seq_board_num;	
	
insert into board(num, title, content, id, postdate, visitcount) values (seq_board_num.nextval, '제목 1', '내용 1', 'kkk1', sysdate, 0);	
insert into board(num, title, content, id, postdate, visitcount) values (seq_board_num.nextval, '제목 2', '내용 2', 'kkk1', sysdate, 0);	
insert into board(num, title, content, id, postdate, visitcount) values (seq_board_num.nextval, '제목 3', '내용 3', 'kkk1', sysdate, 0);	
insert into board(num, title, content, id, postdate, visitcount) values (seq_board_num.nextval, '제목 4', '내용 4', 'kkk1', sysdate, 0);	
insert into board(num, title, content, id, postdate, visitcount) values (seq_board_num.nextval, '제목 5', '내용 5', 'kkk1', sysdate, 0);		

insert into member(id, pass, name) values('kkk1', '1234', '가나다');
insert into member(id, pass, name) values('kkk2', '1111', '김지선');
insert into member(id, pass, name) values('kkk3', '2222', '문지현');
insert into member(id, pass, name) values('kkk4', '3333', '조용재');
insert into member(id, pass, name) values('kkk5', '4444', '이영훈');

select * from member;

select * from member where id='kkk1' and pass='1234';

select B.*, M.* from member M inner join board B on M.id = B.id where num=4;

update board set visitcount = visitcount+1 where num=3;