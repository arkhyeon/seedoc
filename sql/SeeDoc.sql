-- web 계정으로 만들어주세요~
create user web1
identified by web1
default tablespace users;
grant connect, resource to web1;

drop user web1 cascade;
commit;

------------------------------------------------------------------------------
----------------------------- 회원 테이블 -------------------------------------
------------------------------------------------------------------------------

--유저테이블
create table tbl_user (
	user_id	varchar2(30)	NOT NULL, --회원 아이디
	user_pwd varchar2(100)	NOT NULL, -- 비밀번호
	user_name varchar2(30)	NOT NULL, -- 회원 이름
	user_email varchar2(100)	NOT NULL, -- 이메일
	user_phone varchar2(13)	NOT NULL, -- 전화번호
	user_gender char(1)	NOT NULL, -- 성별(M/F)
	user_birth varchar2(8)	NOT NULL, -- 생년월일
	user_addr varchar2(100)	NULL, -- 주소
	user_symptom varchar2(200)	NULL, -- 증상
	user_role char(1) default 'U' not null, -- 권한(일반_U, 관리자_A)
	user_enroll_date Date DEFAULT sysdate NOT NULL, --(가입일)
    CONSTRAINT pk_user_id primary key(user_id),
    CONSTRAINT ck_user_gender check(user_gender in ('M', 'F')),
    CONSTRAINT ck_user_rate check(user_role in ('U', 'A'))
);

--병원 테이블
CREATE TABLE hospital (
	hosp_id	varchar2(30) NOT NULL, -- 병원 아이디
	hosp_pwd varchar2(100)	NOT NULL, -- 병원 비밀번호
	hosp_name varchar2(30)	NOT NULL, -- 병원 이름
    hosp_addr varchar2(100) NOT NULL, -- 병원 주소
	hosp_tel varchar2(13) NOT NULL, -- 병원 전화번호
	hosp_info varchar2(2000) NULL, -- 병원 소개글
	hosp_conv varchar2(100) NULL, -- 편의시설
	hosp_enroll_date Date DEFAULT sysdate NOT NULL, -- 병원 회원 가입일
    CONSTRAINT pk_hosp_id primary key(hosp_id)
);
select * from tbl_user;
--병원 의사 테이블
CREATE TABLE hosp_doctor (
	doctor_no varchar2(30)	NOT NULL, -- 의사번호
	hosp_id	varchar2(30) NOT NULL, --	병원아이디
	doctor_name	varchar2(30) NOT NULL, --	의사이름
	hosp_dept varchar2(30)	NOT NULL, -- 병원과
	doctor_treat varchar2(300)	NULL, -- 진료내용
	doctor_spec	varchar2(300) NULL, --	학력/전공
    constraint pk_doctor_no primary key(doctor_no),
    constraint fk_hosp_doctor_id foreign key(hosp_id) references hospital(hosp_id) on delete cascade
);
UPDATE tbl_user
SET user_pwd = '0000'
WHERE user_id = 'honggd' and user_name ='홍길동';

--병원 운영 시간 테이블
CREATE TABLE hospital_time (
	hosp_id	varchar2(30) NOT NULL, -- 아이디
	mon_open varchar2(8)	NULL, -- 월 오픈
	mon_end	varchar2(8)	NULL, -- 월 마감
	tue_open varchar2(8)	NULL, -- 화 오픈
	tue_end	varchar2(8)	NULL, -- 화 마감
	wed_open varchar2(8)	NULL, -- 수 오픈
	wed_end	varchar2(8)	NULL, -- 수 마감
	thu_open varchar2(8)	NULL, -- 목 오픈
	thu_end	varchar2(8)	NULL, -- 목 마감
	fri_open varchar2(8)	NULL, -- 금 오픈
	fri_end	varchar2(8)	NULL, -- 금 마감
	sat_open varchar2(8)	NULL, -- 토 오픈
	sat_end	varchar2(8)	NULL, -- 토 마감
	sun_open varchar2(8)	NULL, -- 일 오픈
	sun_end	varchar2(8)	NULL, -- 일 마감
	lun_open varchar2(8)	NULL, -- 점심시간시작
	lun_end	varchar2(8)	NULL, -- 점심시간끝
    constraint fk_hospital_time_id foreign key(hosp_id) references hospital(hosp_id) on delete cascade
);

-- 병원 사진 파일 테이블
CREATE TABLE hospital_file (
	doctor_no varchar2(30) NULL, -- 의사번호
	hosp_id	varchar2(30)	NOT NULL, -- 병원아이디
	board_original_filename	varchar2(100)	NULL, -- 첨부파일사용자등록이름
	board_renamed_filename	varchar2(100)	NULL, -- 첨부파일서버이름
    use varchar2(30) NULL, --첨부파일용도
    constraint fk_hosp_file_doctor_no foreign key(doctor_no) references hosp_doctor(doctor_no) on delete cascade,
    constraint fk_hosp_file_hosp_id foreign key(hosp_id) references hospital(hosp_id) on delete cascade
);

-- 예약 테이블
CREATE TABLE booking (
	booking_no char(10) NOT NULL,   --	예약번호
	user_id	varchar2(30)	NOT NULL, --	환자아이디
	hosp_id	varchar2(30)	NOT NULL,  --	병원아이디
    doctor_no varchar2(30)	NULL, -- 의사번호
	user_name varchar2(30)	NOT NULL, --	환자이름
	booking_date Date NOT NULL, --	예약일
	booking_time VARCHAR2(8) NOT NULL, --	예약시간
	sysmptom varchar2(300)	NULL, -- 증상
	booking_state char(1) default 'A' NOT NULL, -- 예약상태
	booking_cancle varchar2(300) NULL, --	취소사유(병원측)
    constraint pk_booking_no primary key(booking_no),
    constraint fk_booking_user_id foreign key(user_id) references tbl_user(user_id) on delete set null,
    constraint fk_booking_hosp_id foreign key(hosp_id) references hospital(hosp_id) on delete set null,
    constraint fk_booking_doctor_no foreign key(doctor_no) references hosp_doctor(doctor_no) on delete set null,
    CONSTRAINT ck_booking_state check(booking_state in ('A', 'F', 'C')) -- Approval, finish, CANCLE
);

--예약 완료 테이블(data 보관 테이블)
CREATE TABLE booking_complete (
	booking_no char(10) NOT NULL,   --	예약번호
	user_id	varchar2(30)	NOT NULL, --	환자아이디
	hosp_id	varchar2(30)	NOT NULL,  --	병원아이디
    doctor_no varchar2(30)	NOT NULL, -- 의사번호
	user_name varchar2(30)	NOT NULL, --	환자이름
	booking_date Date NOT NULL, --	예약일
	booking_time char(8) NOT NULL, --	예약시간
	sysmptom varchar2(300)	NULL, -- 증상
	booking_state char(1) default 'A' NOT NULL, -- 예약상태
	booking_cancle varchar2(300) NULL, --	취소사유(병원측)
    constraint pk_booking_com_no primary key(booking_no),
	CONSTRAINT ck_booking_com_state check(booking_state in ('A', 'F', 'C')) -- Approval, finish, CANCLE
);

-- 병원 review 테이블
CREATE TABLE hospital_review (
    review_no number NOT NULL, --	리뷰번호
	booking_no char(10) NOT NULL, -- 예약번호
	review_con varchar2(500)	NOT NULL, --방문자한줄리뷰
	review_rank	number	NOT NULL, --	DEFAULT max:5, --방문자평점(5점만점)
	review_level number	NOT NULL, -- 리뷰레벨
	review_ref	number	NULL,	-- 댓글(null), 댓댓글(리뷰번호)
    constraint pk_review_no primary key(review_no),
    constraint fk_hosp_review_booking_no foreign key(booking_no) references booking_complete(booking_no) on delete set null
);

-- 건강 게시판
CREATE TABLE board_health (
	board_no number	NOT NULL, -- 게시글번호
    board_title	varchar2(100)	NOT NULL, -- 게시글제목
	hosp_id	varchar2(30) NOT NULL, -- DEFAULT 병원, 관리자만 / 작성자아이디
	board_content varchar2(2000) NOT NULL, -- 게시글내용
    board_original_filename	varchar2(100)	NULL, -- 첨부파일사용자등록이름
	board_renamed_filename	varchar2(100)	NULL, -- 첨부파일서버이름
  	board_date	date DEFAULT sysdate NOT NULL, --	 작성일
	board_readcount	number 	DEFAULT 0	NOT NULL, -- 게시글 조회수
    constraint pk_board_health_no primary key(board_no)
);

COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_NO" IS '게시글번호';
COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_TITLE" IS '게시글제목';
COMMENT ON COLUMN "BOARD_HEALTH"."HOSP_ID" IS '게시글작성자 아이디';
COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_CONTENT" IS '게시글내용';
COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_ORIGINAL_FILENAME" IS '첨부파일원래이름';
COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_RENAMED_FILENAME" IS '첨부파일변경이름';
COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_DATE" IS '게시글올린날짜';
COMMENT ON COLUMN "BOARD_HEALTH"."BOARD_READCOUNT" IS '조회수';

COMMENT ON TABLE board_health IS '건강상식게시판';

-- 건강게시판 댓글 테이블
create table board_health_comment (
    board_health_comment_no number,
    board_health_comment_level number default 1, --댓글(1)/대댓글(2) 여부 판단
    board_health_comment_writer varchar2(15),
    board_health_comment_content varchar2(2000),
    board_health_ref number,                    --게시글 참조 번호
    board_health_comment_ref number,           -- 대댓글인 경우, 댓글 번호 | 댓글인 경우, null
    board_health_comment_date date default sysdate,
    constraints pk_board_health_comment primary key(board_health_comment_no),
    constraints fk_board_health_comment_ref foreign key(board_health_comment_ref) references board_health_comment(board_health_comment_no) on delete cascade
);

--------------------------------------------------------------------------
-------------------------------- sequence 생성 ----------------------------
--------------------------------------------------------------------------

-- 예약번호 시퀀스
create sequence seq_booking_no
start with 1005758615;

-- 병원 리뷰 No
create sequence seq_review_no;

-- 건강 게시판 번호
create sequence seq_board_no
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
CACHE 20;

-- 건강 게시판 조회수번호
create sequence seq_board_health_no;

-- 건강 게시판 댓글번호
create sequence seq_board_health_comment;

----------------------------------------------------------------------------------
-------------------------------- trigger 생성 ------------------------------------
----------------------------------------------------------------------------------

-- 상태 변경으로 인한 행 booking -> booking_complete로 이동
create or replace trigger trig_booking_log1
    after 
    update on booking 
    for each row 
begin
    if :new.booking_state = 'F' or :new.booking_state = 'C' then
        insert into booking_complete
        values(:new.booking_no, :new.user_id, :new.hosp_id, :new.doctor_no, :new.user_name, :new.booking_date, 
                :new.booking_time, :new.sysmptom, :new.booking_state, :new.booking_cancle);
--     delete from booking where booking_state = 'F';
    end if;
end;
/

----------------------------------------------------------------------------
-------------insert 생성 ---------------------------------------------------
--관리자
Insert into web1.tbl_user (user_id,user_pwd,user_name,user_email,user_phone,user_gender,user_birth,user_addr,user_symptom, user_role)
values ('admin','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','관리자','admin@naver.com','01000000000','M','850613-1','서울 종로구 사직로 161 경복궁','나는 관리자', 'A');
--user1
Insert into web1.tbl_user (user_id,user_pwd,user_name,user_email,user_phone,user_gender,user_birth,user_addr,user_symptom, user_role)
values ('honggd','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','홍길동','honggd@naver.com','01030069001','M','900613-1','강원도 인제군 남면 관대리 719-1','배가 아파요', 'U');
--user2
Insert into web1.tbl_user (user_id,user_pwd,user_name,user_email,user_phone,user_gender,user_birth,user_addr,user_symptom, user_role)
values ('turtle','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','이순신','turtle@naver.com','01090006262','F','000613-4','제주특별자치도 서귀포시 중문동 산1-3','머리가 아파요', 'U');
--user3
Insert into web1.tbl_user (user_id,user_pwd,user_name,user_email,user_phone,user_gender,user_birth,user_addr,user_symptom, user_role)
values ('joseon','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','이성계','LeeSeonggye@naver.com','01070005454','M','881213-1','광주광역시 서구 화정동 12-11','다리가 아파요', 'U');
--user4
Insert into web1.tbl_user (user_id,user_pwd,user_name,user_email,user_phone,user_gender,user_birth,user_addr,user_symptom, user_role)
values ('cheonghaejin','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','장보고','jangbogo@naver.com','01060003456','F','920313-2','충청북도 충주시 소태면 복탄리 산74-9','팔이 아파요', 'U');
--user5
Insert into web1.tbl_user (user_id,user_pwd,user_name,user_email,user_phone,user_gender,user_birth,user_addr,user_symptom, user_role)
values ('Faker','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','페이커','Faker@naver.com','01040007000','M','930503-1','세종특별자치시 금남면 금천리 149-2','허리가 아파요', 'U');



--비밀번호 변경
UPDATE tbl_user SET user_pwd = '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==';


select * from booking;
select * from hospital_review;
select * 
from hospital_review,booking_complete 
where hospital_review.booking_no = booking_complete.booking_no and hosp_id='hospital1'
order by review_no desc;
select * from hospital_review where booking_no='1005758639';

----------------------------------------------------------------------------------------------------------------------------------------------------------------

commit;

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------hospital-----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital8','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','합정연세의원','서울특별시 마포구 양화로 48 (합정동)','02-326-0365','365일 진료하는 합정연세365의원입니다.

tel. 2층 02)326-0365 (내과 소아과)
     3층 02)338-0365 (통증 물리치료 건강검진)','무선인터넷,장애인 편의시설',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital9','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','다웰내과의원','서울특별시 마포구 큰우물로 76 (도화동)','02-322-5225','마포역 2번 출구에 위치한 
위/대장내시경 전문 마포 다웰내과 건강검진센터 입니다. 
현재 건국대학교병원 외래교수 소화기내과 전문의가 진행하는 
진단및 치료내시경 전문 종합건강검진센터 입니다. 
세브란스 병원 출신 여성 전문의 초빙으로 편안한 여성암 검진
더욱 원활한 진료와 검진을 하고있습니다. ','무선인터넷',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hos2','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','홍익한사랑의원','서울특별시 마포구 독막로 63 (상수동)','02-372-4101','홍익한사랑의원입니다.','남/녀 화장실 구분',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hos3','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','방병원','서울특별시 도봉구 우이천로 308 (쌍문동)','1577-4447','한일병원은 79년의 역사와 전통을 자랑하는 도봉구 유일의 종합 병원으로서 우수한 의료진과 의료 기술, 최첨단 시설과 장비를 보유하고 있습니다. 그리고 국내 최초의 화상 진료 전문 센터를 개설하여 외과, 응급의학과, 정형외과 및 성형외과의 긴밀한 연계를 통하여 이 분야 국내 최고의 진료를 시행하고 있습니다. 이와 더불어 강북 최대 규모의 재활 센터를 개설하여 지역 주민 여러분의 재활 치료에 큰 도움을 드리고 있습니다.','무선인터넷,남/녀 화장실 구분,주차,발렛파킹',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hos4','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','중계의원','서울특별시 노원구 한글비석로 331 (중계동)','02-938-9491','*피부레이저시술 전문병원
*특설 레이저 시술
*CO2 레이저
*Q-Switched ND-YAG 레이저
*점, 주근깨, 잡티, 검버섯, 오타반점, 기미, 문신제거
*예방접종, 물리치료실 운영','무선인터넷',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hos5','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','도봉병원','서울특별시 도봉구 도봉로 720 (방학동)','02-3492-3250','항상 가족과 같은 마음으로 정성과 최선을 다하겠습니다.','남/녀 화장실 구분,주차',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital2','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','라이크치과 의원','서울특별시 마포구 신촌로 104 (노고산동)','02-6951-0011','2호선 신촌역 6번출구 바로 앞에 위치한 환자가 환자를 소개해주는 친절한 ''라이크치과''입니다.

@코로나19 바이러스 예방을 위한 의료기관 행동 수칙을 철저히 준수합니다@ 

대학병원급 규모와 최신식 시설과 장비, 자체기공소를 통한 당일 수술이 가능합니다. 

분과별 3인 의료진의 더블체크 시스템을 통한 정확한 수술과 평생 AS 보증 프로그램을 시행합니다. 

임플란트
(치주 임플란트, 앞니 임플란트, 전체 임플란트, 수면 임플란트, 틀니 임플란트, 뼈이식 임플란트, 재수술 임플란트, 보험 임플란트)
　
치아교정
(메탈교정, 세라믹교정, 클리피씨교정, 투명교정, 콤비교정, 설측교정, 엠파워교정, MTA교정, 데이몬교정, 인비절라인교정)
　
치주치료
(잇몸치료, 신경치료, 충치치료, 수면치료)
　　
심미보철
(라미네이트, 올세라믹, 크라운, 치아미백, 틀니/브릿지, 맞춤보철물) 
　　
일반진료
(충치치료, 신경치료, 사랑니 발치, 스케일링)

치아성형
(치아위치성형, 색조성형, 잇몸성형, 잇몸미백)
　　　
소아치료
(예방치료, 충치치료, 진정치료, 소아교정)','무선인터넷,남/녀 화장실 구분,주차',to_date('20/07/18','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital3','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','메디스캔 의원','서울특별시 서초구 강남대로 369 (서초동)','02-525-5775','초음파우수진료병원, MDCT(다중검출 전산화 단층촬영), 초음파, 내시경, 건강검진, 내과진료

당신의 평생 건강 파트너. 메디스캔 메디컬 헬스케어
귀하께서 세상을 만들어가시는 동안 메디스캔이 귀하의 평생 건강을 책임지겠습니다.','주차',to_date('20/07/18','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hos1','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한솔병원','서울특별시 송파구 송파대로 445 (석촌동)','02-2147-6000','1990년 개원한 한솔병원은 대장항문특화병원이자, 보건복지부 인증의료기관이다. 
대장항문외과를 중심으로 소화기내과, 순환기내과, 유방·갑상선외과, 가정의학과, 영상의학과, 마취통증의학과, 건강증진센터를 운영하고 있다. 
2001년 국내 처음으로 대장암에 대한 복강경 수술법을 도입해 국제심포지엄을 개최하고 국내외 학술대회를 통해 본원의 술기와 우수성을 인정받았다. 
또한 단순히 병을 치료하는 병원이 아닌 지역사회와 함께 호흡하며, 나눔과 사랑을 실천하고자 1990년 개원 이래 해마다 유니세프, 사랑의 열매, 대한적십자사 등에 정기적인 후원하며 이웃돕기에 앞장서고 있다.  
한솔병원은 앞으로도 환자의 안전을 먼저 생각하고 의료서비스 질 향상을 위해 의료계의 선구자로서 끊임없이 연구하고 노력할 것입니다.','무선인터넷,장애인 편의시설,남/녀 화장실 구분,주차,발렛파킹',to_date('20/07/18','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital1','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','닥터쁘띠 의원','서울특별시 광진구 아차산로 213 (화양동)','02-463-1755','닥터쁘띠 네트워크는 
보톡스,필러,리프팅,안티에이징,피부미용,비만관리,제모클리닉을 중점으로 진료하고 있는
토탈 뷰티클리닉 입니다.

1. 숙련된 의사에게 합리적인 비용으로, 보톡스, 필러 시술을 받을수 있습니다. 

2. 전 제품 정품 정량제도, 눈 앞에서 정품 개봉을 시행합니다.

3. 다양하고 많은 시술 케이스를 바탕으로 뛰어난 실력을 가지고 있는 원장님들이
고객님께 가장 어울리는 아름다움을 선사합니다. 

4. 자체 세미나를 진행하여 다양한 사례연구 및 최신 노하우를 서로 공유하고 발전시켜 고객님께
만족스러운 결과를 제공하기 위해 끊임없이 노력하고 있습니다.

5. 전문적이고 정성을 다한 상담을 통해 고객 감동 서비스를 제공하고 있습니다. ','주차',to_date('20/07/18','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital4','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하나병원','서울특별시 강남구 역삼로 245 (역삼동)','02-6925-1111','저희 하나이비인후과병원은 1995년 코수술 전문 클리닉으로 출발하여 내원한 환자가 무려 200만 명(2015년 기준)을 넘어섰습니다. 또한 매년 12만 명 정도의 환자분들이 직접 찾아주시고 있으며, 5만 명 이상(2015년 기준)의 환자분들이 성공적으로 수술을 받고 고통에서 벗어났습니다. 수술을 받은 환자분들께서 90% 이상의 높은 만족도를 느끼셨습니다.(코리아 리서치 조사 결과) 그 누구도 따라올 수 없는 치료실적, 이는 하나이비인후과병원이기 때문에 가능한 일입니다. 

누구보다 발 빠르게 움직여 온 하나이비인후과병원은 현재에 안주하지 않고 환자분들을 위해 정진하는 병원이 되겠습니다.','무선인터넷,남/녀 화장실 구분,주차,발렛파킹',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital5','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서울배내과의원','서울특별시 강남구 논현로 509 (역삼동)','02-529-3002','더 편안하게, 더 정확하게, 더 빠르게!
검진과 진료를 동시에 받으실 수 있습니다.','남/녀 화장실 구분',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital6','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','연세신경외과','서울특별시 강남구 논현로 853 (신사동)','02-6353-5000','신경외과 | 정형외과 | 통증의학과 | 내과 | 뇌신경과 | 영상의학과 | 도수재활치료센터 | 입원실

-압구정역 4번출구 바로 앞에 위치
-척추/관절 비수술치료 및 고난이도 수술, 도수치료, 뇌검진, 내과진료까지
-고혈압, 당뇨병, 성인병, 만성질환 내과진료
-연세대 세브란스 출신 의료진
-3.0T 고해상도 MRI, 디지털 X-ray 등 첨단 의료장비 보유
-입원실, 수술실 완비','무선인터넷,장애인 편의시설,남/녀 화장실 구분,주차,발렛파킹',to_date('20/07/20','RR/MM/DD'));
Insert into WEB1.HOSPITAL (HOSP_ID,HOSP_PWD,HOSP_NAME,HOSP_ADDR,HOSP_TEL,HOSP_INFO,HOSP_CONV,HOSP_ENROLL_DATE) values ('hospital7','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','비에비스병원','서울특별시 강남구 논현로 627 (논현동)','1577-7502','위/간/장 등 소화기질환 특화병원입니다. 위간장센터 / 내시경센터 / 당일내시경센터 / 단일통로복강경수술센터 / 유방갑상선센터 / 가정의학센터 / 안티에이징비만센터 / 건강검진센터 등으로 이루어져 있습니다.','주차',to_date('20/07/20','RR/MM/DD'));

Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('89898','hospital8',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital2','K-004.png','20200718_005314826_780.png','logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital2','K-005.png','20200718_005314827_316.png','thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital3','K-004.png','20200718_005833344_702.png','logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital3','15203931019.jpg','20200718_005833345_797.jpg','thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos1','K-005.png','20200718_010239442_217.png','logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos1','main_visual02_img01.jpg','20200718_010239444_904.jpg','thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital1','K-004.png','20200718_012007418_312.png','logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital1','iTIA3nlylQjDCVyTUPpJD1V_.jpg','20200718_012007419_848.jpg','thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('11111','hospital1','K-001.png','20200718_012534758_170.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('22222','hospital1','K-002.png','20200718_012629617_754.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('33333','hospital1','K-003.png','20200718_012714738_990.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('55555','hospital2','K-003.png','20200718_012834280_611.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('22345','hospital3','K-001.png','20200718_014645024_887.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('77777','hospital2','K-001.png','20200718_013149600_115.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('12345','hospital3','K-006.png','20200718_014428358_305.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('33345','hospital3','K-002.png','20200718_014743514_870.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('44445','hospital3','K-003.png','20200718_014839441_251.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('13579','hos1','leedongkeun-1.jpg','20200718_014954960_251.jpg',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('35791','hos1','jungchunsik-2.jpg','20200718_015044581_89.jpg',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('57913','hos1','Whang.jpg','20200718_015146819_181.jpg',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('66666','hospital2','K-002.png','20200718_013030271_674.png',null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital4',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital4',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital5',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital5',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital6',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital6',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital7',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital7',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital8',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital8',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital9',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hospital9',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos2',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos2',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos3',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos3',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos4',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos4',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos5',null,null,'logo');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values (null,'hos5',null,null,'thumbnail');
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('01111','hospital4',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('00111','hospital4',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('00011','hospital4',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('98765','hospital5',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('99998','hospital5',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('00000','hospital5',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('99988','hospital6',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('99888','hospital6',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('98888','hospital6',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('88889','hospital7',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('88899','hospital7',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('88999','hospital8',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('89999','hospital8',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('98989','hospital9',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('98888','hospital9',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('98887','hospital9',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('454545','hos2',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('54545','hos2',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('12321','hos3',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('12311','hos3',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('78787','hos4',null,null,null);
Insert into WEB1.HOSPITAL_FILE (DOCTOR_NO,HOSP_ID,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,USE) values ('87878','hos4',null,null,null);

Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital2','10:00','21:00','10:00','21:00','10:00','21:00','10:00','21:00','10:00','19:00','10:00','14:00',null,null,'13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital3','9:00','20:00','9:00','20:00','9:00','20:00','9:00','20:00','9:00','20:00','9:00','14:00',null,null,'12:00','13:30');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hos1','9:00','19:30','9:00','19:30','9:00','19:30','9:00','19:30','9:00','19:30','9:00','15:00',null,null,'13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital1','10:30','19:00','10:30','21:00','10:30','21:00','10:30','21:00','10:30','21:00','10:30','21:00',null,null,'13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital4','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','14:00',null,null,'12:30','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital5','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','14:00',null,null,'13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital6','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','14:00',null,null,'13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital7','9:00','19:00','9:00','19:00','9:00','19:00','9:00','19:00','9:00','19:00','9:00','14:00',null,null,'11:00','12:30');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital8','9:00','21:00','9:00','21:00','9:00','21:00','9:00','21:00','9:00','21:00','9:00','19:00','9:00','19:00','13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hospital9','9:00','19:00','9:00','18:00','9:00','19:00','9:00','18:00','9:00','19:00','9:00','14:00',null,null,null,null);
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hos2','9:00','19:00','9:00','19:00','9:00','19:00','9:00','19:00','9:00','19:00','9:00','14:00',null,null,'12:30','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hos3','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00',null,null,'12:30','13:30');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hos4','9:00','18:30','9:00','18:30','9:00','14:00','9:00','18:30','9:00','18:30','9:00','14:00',null,null,'13:00','14:00');
Insert into WEB1.HOSPITAL_TIME (HOSP_ID,MON_OPEN,MON_END,TUE_OPEN,TUE_END,WED_OPEN,WED_END,THU_OPEN,THU_END,FRI_OPEN,FRI_END,SAT_OPEN,SAT_END,SUN_OPEN,SUN_END,LUN_OPEN,LUN_END) values ('hos5','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','18:00','9:00','14:00',null,null,'11:00','12:00');

Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('89898','hospital8','구팔이','안과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('11111','hospital1','고경덕','피부과','백반증, 여드름, 미백','피부과 전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('22222','hospital1','김연진','피부과','문신제거, 백반증','피부과 전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('33333','hospital1','강주희','피부과','피부미용, 제모클리닉','피부과 전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('55555','hospital2','여인성','치과','임플란트, 사랑니발치','대표원장');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('22345','hospital3','남지은','내과','폐암, 갑상선암 클리닉','영상의학과/전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('77777','hospital2','정혜림','치과','충치, 치아형태 이상','치과보존과 전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('12345','hospital3','박준균','내과','건강검진, 내과진료','대표원장/전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('33345','hospital3','황진숙','내과','감기, 내과진료','가정의학과/전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('44445','hospital3','신하늘샘','내과','초음파, 내시경','소화기과/전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('13579','hos1','이동근','외과','치핵,치루,치열','의학박사 / 외과전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('35791','hos1','정춘식','외과','복강경수술, 일반외과','복강경수술센터장 / 외과전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('57913','hos1','황재관','외과','복강경수술, 일반외과','약제위원장 / 외과전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('66666','hospital2','김현혜','치과','디지털치아교정','교정과 전문의');
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('01111','hospital4','김의사','내과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('00111','hospital4','이의사','외과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('00011','hospital4','박의사','안과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('98765','hospital5','한의사','정신과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('99998','hospital5','구의사','피부과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('00000','hospital5','사의사','내과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('99988','hospital6','감의사','안과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('99888','hospital6','도의사','외과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('98888','hospital6','신의사','외과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('88889','hospital7','김의사','정신과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('88899','hospital7','고의사','치과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('88999','hospital8','팔의사','내과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('89999','hospital8','구사라','정신과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('98989','hospital9','팔구구','치과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('98887','hospital9','구팔사','정신과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('454545','hos2','사오삼','외과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('54545','hos2','오사삼','피부과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('12321','hos3','일이삼','피부과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('12311','hos3','눈사랑','안과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('78787','hos4','칠팔이','내과',null,null);
Insert into WEB1.HOSP_DOCTOR (DOCTOR_NO,HOSP_ID,DOCTOR_NAME,HOSP_DEPT,DOCTOR_TREAT,DOCTOR_SPEC) values ('87878','hos4','팔칠이','치과',null,null);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------booking-----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758643','Faker','hospital2','66666','페이커',to_date('2020/07/22','YYYY/MM/DD'),'14:00','주기적 교정','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758617','honggd','hospital3','12345','홍길동',to_date('2020/07/21','YYYY/MM/DD'),'18:00','건강 검진 희망합니다.','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758623','turtle','hospital3','22345','이순신',to_date('2020/07/27','YYYY/MM/DD'),'14:00',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758624','turtle','hos1','57913','이순신',to_date('2020/07/22','YYYY/MM/DD'),'15:00',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758625','turtle','hospital2','55555','이순신',to_date('2020/07/22','YYYY/MM/DD'),'14:30','사랑니 진료','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758626','turtle','hospital1','22222','이순신',to_date('2020/07/23','YYYY/MM/DD'),'11:30','문신 제거 진료','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758630','joseon','hospital2','55555','이성계',to_date('2020/07/21','YYYY/MM/DD'),'15:30',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758631','joseon','hospital1','33333','이성계',to_date('2020/07/21','YYYY/MM/DD'),'12:30','기미 제거','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758632','joseon','hos1','13579','이성계',to_date('2020/07/27','YYYY/MM/DD'),'09:30',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758633','joseon','hospital3','33345','이성계',to_date('2020/07/23','YYYY/MM/DD'),'15:30',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758634','joseon','hospital3','44445','이성계',to_date('2020/07/22','YYYY/MM/DD'),'14:00',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758635','cheonghaejin','hospital3','12345','장보고',to_date('2020/07/21','YYYY/MM/DD'),'17:00','당뇨 관련 주기 방문','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758636','cheonghaejin','hospital3','44445','장보고',to_date('2020/07/24','YYYY/MM/DD'),'14:30','위 내시경 검사','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758637','cheonghaejin','hos1','13579','장보고',to_date('2020/07/21','YYYY/MM/DD'),'14:30','엉덩이가 아파요','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758638','cheonghaejin','hospital2','55555','장보고',to_date('2020/07/22','YYYY/MM/DD'),'10:30','임플란트 문의','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758639','cheonghaejin','hospital1','33333','장보고',to_date('2020/07/21','YYYY/MM/DD'),'17:00','탈모 검사','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758640','cheonghaejin','hospital1','11111','장보고',to_date('2020/07/22','YYYY/MM/DD'),'15:00','미백','A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758642','Faker','hospital3','12345','페이커',to_date('2020/07/22','YYYY/MM/DD'),'14:30',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758645','Faker','hospital1','22222','페이커',to_date('2020/07/28','YYYY/MM/DD'),'16:30',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758646','Faker','hospital1','11111','페이커',to_date('2020/07/22','YYYY/MM/DD'),'16:00',null,'A',null);
Insert into WEB1.BOOKING (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758647','Faker','hospital2','77777','페이커',to_date('2020/07/22','YYYY/MM/DD'),'14:30','이가 시려요','A',null);

---------------------------------------------------------
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758627','turtle','hospital1','22222','이순신',to_date('2020/07/31','YYYY/MM/DD'),'14:00   ',null,'C','유선상 연락 드렸습니다.');
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758650','joseon','hospital2','66666','이성계',to_date('2020/07/20','YYYY/MM/DD'),'15:00   ','교정으로 주기 방문','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758649','turtle','hospital2','77777','이순신',to_date('2020/07/20','YYYY/MM/DD'),'15:00   ',null,'F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758648','honggd','hospital2','77777','홍길동',to_date('2020/07/20','YYYY/MM/DD'),'14:00   ',null,'F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758651','cheonghaejin','hospital2','55555','장보고',to_date('2020/07/20','YYYY/MM/DD'),'12:30   ','주기적 치아 검사','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758652','Faker','hospital2','66666','페이커',to_date('2020/07/20','YYYY/MM/DD'),'12:00   ',null,'F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758615','honggd','hos1','35791','홍길동',to_date('2020/07/21','YYYY/MM/DD'),'14:30   ',null,'F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758644','Faker','hos1','13579','페이커',to_date('2020/07/27','YYYY/MM/DD'),'14:30   ',null,'C',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758618','honggd','hospital2','66666','홍길동',to_date('2020/07/22','YYYY/MM/DD'),'17:00   ','교정 진료','C',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758620','honggd','hospital1','33333','홍길동',to_date('2020/07/20','YYYY/MM/DD'),'14:00   ','제모 희망합니다.','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758619','honggd','hospital1','11111','홍길동',to_date('2020/07/24','YYYY/MM/DD'),'20:00   ','안티 에이징 진료','C','담당 선생님 부재');
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758628','turtle','hospital2','77777','이순신',to_date('2020/07/20','YYYY/MM/DD'),'14:00   ','치아 주기 점검','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758622','honggd','hospital3','33345','홍길동',to_date('2020/07/20','YYYY/MM/DD'),'09:00   ','감기','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758629','joseon','hospital3','44445','이성계',to_date('2020/07/20','YYYY/MM/DD'),'11:30   ','초음파 검사 필요','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758641','Faker','hospital3','22345','페이커',to_date('2020/07/20','YYYY/MM/DD'),'14:00   ','금연 클리닉','F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758616','honggd','hos1','57913','홍길동',to_date('2020/07/20','YYYY/MM/DD'),'15:00   ',null,'F',null);
Insert into WEB1.BOOKING_COMPLETE (BOOKING_NO,USER_ID,HOSP_ID,DOCTOR_NO,USER_NAME,BOOKING_DATE,BOOKING_TIME,SYSMPTOM,BOOKING_STATE,BOOKING_CANCLE) values ('1005758621','honggd','hos1','13579','홍길동',to_date('2020/07/20','YYYY/MM/DD'),'09:00   ',null,'F',null);
commit;

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------review-----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (1,'1005758615','진료도 잘봐주시고 너무 친절하셔서 동구 방촌 사는데 멀리서 항상 찾아갑니다^^',5,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (2,'1005758615','멀리서 오셔서 진료를 잘받고 가셨다니 다행입니다. 다음에도 좋은 진료로 찾아뵙겠습니다.',0,2,1);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (3,'1005758616','원장님 친절하신데 병원분위기가 너무 바쁘다보니 어수선해요. 진료 후에 바로 안내를 받을수가 없었어요. 진료끝나면 앞에 간호사분들 붙잡고 일일히 어디로 가야하는지 물어봐야해요.가만히 앉아서 기다리면 그냥 두기만 하시더라구요',3,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (4,'1005758616','안녕하세요? 병원입니다. 바쁜 시간 내셔서 저희 병원을 찾아주셨는데 세심하게 응대해드리지 못한 점 사과드립니다. 앞으로 내원하시는 고객 분들이 불편한 점이 없도록 시스템을 점검해나가겠습니다. 부족한 부분 말씀해주셔서 감사드립니다.',0,2,3);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (5,'1005758621','동생이 환자입장에서 알아듣게 얘기했다고 해요. 수술이 필요하다고 전해들었는데, 제가 자세히 못들어서 유선상 여쭤보고 수술 예약 날짜 잡아보려합니다.',4,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (6,'1005758621','찾아주셔서 감사합니다. 더 좋은 서비스로 보답하는 병원이 되겠습니다. ^^',0,2,5);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (7,'1005758620','첫 제모를 닥터쁘띠의원에서 했습니다.  끝난 뒤 아프다는 이야기를 많이 들었지만 제모 후 약을 발라주셨는데 저와 맞지않아 지금 응급실 왔습니다. ',1,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (8,'1005758620','고객님과 제모약이 맞지않았던것 같습니다 빠른 시일내에 내원해주신다면 새로 약처리 해드리겠습니다. 죄송합니다.',0,2,7);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (9,'1005758628','매 반기마다 스케일링 치과를 찾아 다니지만 여기는 아닌것 같습니다.',2,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (10,'1005758628','고객님 스케일링 서비스에 어떤 점이 나쁘셨는지 다음에 내원하셔서 알려주시면 더 좋은 치과가 되도록 노력하겠습니다.',0,2,9);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (11,'1005758622','의사 선생님들은 정말 친절하게 대해주셨지만 간호사들이 너무 불친절했습니다. 특히 주사맞을 때 너무 아팠고 귀찮아하는것이 보였습니다.',3,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (12,'1005758622','어떤 간호사인지 명찰보셨다면 전화로 알려주시기 바랍니다. 바로 해고 처리하겠습니다. 정말 죄송합니다.',0,2,11);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (13,'1005758629','초음파 검사 잘받았습니다.',5,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (14,'1005758629','검사를 잘받으셨다니 정말 감사합니다. 결과도 건강하시길 바라겠습니다.',0,2,13);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (15,'1005758641','금연보조제 금연 껌을 받았는데 이제 금연 껌도 중독 담배도 중독되었습니다. 어떻게 해야되나요',2,1,0);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (16,'1005758641','최악의 상황입니다. 당장 내원하셔서 검진받으시고 치료들어가셔야 합니다.',0,2,15);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (19,'1005758650','진료는 잘받았으나 입안에 석션할 때 좀 불편했습니다. 다음에는 좀 신경써주셨으면 좋겠습니다.',3,1,null);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (20,'1005758651','저는 정말 좋았습니다. 항상 진료에 힘써주시는 여인성 의사님 감사합니다. 그리고 김미진 간호사님 제가 명찰보고 리뷰답니다. 의사가 아님에도 불구하고 의사처럼 신경써주시고 치과를 나가서도 어떻게 생활해야하는지 많이 배웠습니다.',5,1,null);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (21,'1005758649','한번 더 믿어봤지만.. 그냥 적당한 병원입니다.',3,1,null);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (22,'1005758649','어떤점이 불편하셨는지 다음에 내원해주신다면 더 성장한 병원이 되겠습니다 죄송합니다.',0,2,21);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (17,'1005758648','리뷰들과는 다르게 다들 친절하신 병원이었습니다. 리뷰확인과 반영을 병원에 되게 잘하시는 것 같아요 다음에 또 내원하겠습니다.',4,1,null);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (23,'1005758651','좋은 리뷰 정말 감사드립니다. 해당 간호사에게 전달하여 기쁨이 되게 하겠습니다. 다음에도 또 내원해주시면 더 좋은 진료로 찾아뵙겠습니다.',0,2,20);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (24,'1005758650','저희 석션이 안맞으셨군요 어제 저희가 석션을 새제품으로 바꿨으니 다음 내원시에는 그런일 없도록 하겠습니다. 죄송합니다',0,2,19);
Insert into WEB1.HOSPITAL_REVIEW (REVIEW_NO,BOOKING_NO,REVIEW_CON,REVIEW_RANK,REVIEW_LEVEL,REVIEW_REF) values (25,'1005758648','좋은 리뷰 감사드립니다. 다음에 내원하실 때 더 좋은 병원이 되겠습니다.',0,2,17);

-----------------------------------------------------------------------------------------------------------------
-------------------------------------------------health-board-----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

--게시판 글 30개 / 병원 계정 정해지면 계정 넣을것
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'질 좋은 낮잠을 자기 위해 커피를 마셔라','admin','일본에서 발표한 한 연구에 따르면 일반적인 낮잠보다 ‘커피 낮잠’을 취한 사람들이 두뇌 활동에서 더 나은 결과를 보였다고 한다. 여기서 말하는 커피 낮잠이란 200mg 정도의 카페인을 소비하고 즉시 20분 정도의 낮잠을 자는 것이다. 왜 이런 결과가 나왔을까. 뉴욕의 신경전문의학박사 엘렌 토피는 두뇌 활동의 부산물인 ‘아데노신(Adenosine)’이라는 물질에 대해 언급하며 이 결과를 설명했다. 그는 “아데노신은 사람을 깨워주고 활동적으로 만들어 준다”며 “아데노신 수치가 올라가면 우리는 쉽게 피곤해진다. 그러나 낮잠은 아데노신을 없애 주고, 카페인은 아데노신을 막는 역할을 해 피로를 쉽게 사라지게 한다”고 밝혔다.','test.txt','2020062515006_12313.txt',to_date('19/02/02','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'건강한 치아를 위해서는 식후 바로 양치를 하지 마라','hospital1','스포츠 음료나 탄산 음료, 토마토 그리고 감귤류 과일 등 산이 포함된 음식은 치아의 법랑질을 녹인다. 미국 치과의학회 전 회장이었던 하워드 갬블은 “식후 바로 양치를 하면 산이 치아에 미치는 영향이 보다 빨라진다”며 “식후 30분에서 1시간 가량 후에 양치하는 것이 가장 좋다”고 제안했다.',null,null,to_date('19/02/10','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'더 날씬해지기 위해 몸무게를 늘려라','hospital1','같은 몸무게를 가진 두 사람의 체형이 현저히 다른 경우가 있다. 이는 근육량의 문제다. 같은 무게의 지방과 근육이라도 근육의 부피가 훨씬 적게 들기 때문이다. 사코 스포츠의 헬스 트레이너 마크 너팅은 “살을 뺄 때 체중이 줄어드는 것만이 능사가 아니다”며 “운동량을 늘려 근육을 만드는 것이 가장 급선무다. 이후 살을 빼면 훨씬 빠른 시간에 탄탄한 몸을 가질 수 있다”고 말했다.',null,null,to_date('19/04/05','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'적게 먹기 위해 많이 먹어라','hos1','열량이 100kcal 정도인 과자 한 봉지를 식사 대신 먹는 건 다이어트에 도움이 되는 것처럼 보인다. 그러나 이는 오히려 다이어트에 방해가 될 수 있다. 텍사스의 건강의학 전문가 에이미 굿슨은 “소량의 탄수화물을 잠깐 섭취하면 체내 혈당을 증가시켜 더 많은 탄수화물을 원하게 만든다”며 “100kcal의 과자 한 봉지가 열량이 낮다고 한 끼로 섭취했다가 자신도 모르는 사이 폭식을 할 수 있다”고 말했다. 그는 과자 한 봉지보다는 땅콩버터나 스트링 치즈를 사과와 같이 먹을 것을 제안했다. “물론 과자보다는 열량이 높을 수 있지만, 땅콩버터나 스트링 치즈에는 단백질이 풍부하게 들어 있고 사과에는 식이섬유가 들어 있어 훨씬 오랜 시간 포만감을 줄 수 있다”며 “결과적으로 그날 하루 동안은 더 적은 열량을 섭취하게 될 것”이라고 말했다.',null,null,to_date('19/04/13','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'피곤하다고 해도 에너지 드링크를 마시지 마라','hos1','에너지 드링크는 커피의 5배에 달하는 카페인을 함유하고 있다. 이는 잠시 동안 기운을 북돋아 줄 수 있으나 곧 긴장감과 함께 극심한 피로, 비정상적인 심장박동을 불러올 수 있다.',null,null,to_date('19/07/15','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'부었을 때 물을 더 많이 마셔라','hospital1','얼굴이나 몸이 부었다고 느낄 때 물을 마시면 상황이 더 악화된다고 알려져 있지만 사실 물은 붓기 완화에 도움이 된다. 캘리포니아 오렌지 카운티의 내과의사 제임스 리는 “물은 우리가 섭취한 섬유질과 결합해 젤 형태로 변하고, 이는 소화가 잘 되도록 신체 내부에 영향을 줘 붓기를 가라앉힌다”고 밝혔다. 많은 물을 마시는 것은 항산화에도 도움이 된다. 리 박사는 이에 대해 “신체의 불필요한 독소들을 내보내주기 때문”이라고 밝혔다.',null,null,to_date('19/07/20','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'다이어트 음료를 마시지 마라','hospital3','만약 정말 건강해지고 싶다면 다이어트 음료를 포함한 모든 탄산 음료를 끊어라. 존스 홉킨스 의대에서 실행한 연구에 따르면 과체중이나 비만인 사람들은 다이어트 음료를 마실 경우 일반 탄산음료를 마시는 사람들에 비해 더 많은 열량을 섭취하게 된다. 이는 위에서 언급한 바와 같이 적은 탄수화물을 섭취하면 신체가 더 많은 탄수화물을 원하게 되기 때문이다. 굿슨은 “사실 ‘0 칼로리’가 아니라 ‘적은 칼로리’가 맞는 표현이다”며 “첨가된 감미료는 어느 정도의 칼로리를 포함하고 있다. 다만 양이 적어 기재하지 않아도 될 뿐”이라고 말했다.',null,null,to_date('19/08/10','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'덥다면 뜨거운 차를 마셔라','hos1','여름 날 오후, 몸을 시원하게 만들어주기 위해 보통 사람들은 차가운 커피를 마신다. 그러나 인도나 중동의 경우, 더운 날씨에도 사람들은 뜨거운 차를 마신다. 이유가 뭘까. 한 연구에 따르면 한 모금씩 뜨거운 차를 홀짝거리며 마실 경우 신체는 체온의 변화를 감지해 땀을 배출하기 시작한다. 때문에 차를 다 마시고 나면 자연적으로 체온이 내려간다. 뜨거운 차를 마시고 난 뒤 시원함을 느끼게 되는 것은 이런 이유다.',null,null,to_date('19/08/10','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'피곤할수록 운동을 하라','hos1','길고 지겨운 업무가 끝난 뒤라면 누구라도 운동을 망설이게 된다. 하루 종일 앉아 있었음에도 피곤함이 느껴기지 때문이다. 그러나 운동 후 흘리는 땀은 오히려 기운을 북돋아 줄 수 있다. 미국의 약학 저널 ‘메디신 사이언스(Medicine Science)’에 발표된 연구에 따르면 감정적으로 느껴지는 피로의 경우 육체적인 피로를 통해 해소가 가능하다. 너팅은 “운동을 하는 것은 신체적으로는 피로할 지 몰라도 감정적으로는 훨씬 당신을 편안하게 만들어 줄 수 있다',null,null,to_date('19/08/10','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'음식은 10번이라도 십고 삼켜라','hospital2','의사들이 말하는 것처럼 30번씩 십어 넘기려다 세 숟가락 넘기기 전에  포기하지 말고, 10번이라도 꼭꼭 십어서 삼킨다. 고기를 먹으면 10번이  모자라겠지만 라면을 먹을 때도 10번은 십어야 위에서 자연스럽게 소화시킬 수 있다.',null,null,to_date('20/02/20','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'매일 조금씩 공부를 한다','hos1','두뇌는 정밀한 기계와 같아서 쓰지 않고 내버려두면 점점 더 빨리 낡는다.  공과금 계산을 꼭 암산으로 한다든가 전화번호를 하나씩 외우는 식으로 머리 쓰는  습관을 들인다. 일상에서 끝없이 머리를 써야 머리가‘녹’이 스는 것을 막을 수있다.',null,null,to_date('20/03/11','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'아침에 일어나면 기지개를 켜라','hos1','아침에 눈을 뜨면 스트레칭을 한다. 기지개는 잠으로 느슨해진 근육과 신경을 자극해 혈액순환을 도와주고 기분을 맑게 한다. 침대에서 벌떡 일어나는 습관은 나이가 들면서 혈관이 갑자기 막히는 치명적인 결과를 낳을 수도 있다.',null,null,to_date('20/03/12','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'매일 15분 씩 낮잠을 자라','hos1','피로는 쌓인 즉시 풀어야지 조금씩 쌓아 두면 병이 된다. 눈이 감기면 그 때 몸이 피곤하다는얘기. 억지로 잠을 쫓지 말고 잠깐이라도 눈을 붙인다. 15분간의 낮잠으로도 오전 중에 쌓인 피로를 말끔히 풀고 오후를 활기차게 보낼 수 있다.',null,null,to_date('20/03/13','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'아침 식사를 하고 나서 화장실을 가라','hospital1','현대인의 불치병, 특히 주부들의 고민 거리인 변비를 고치려면 아침 식사 후 무조건 화장실에 간다. 화장실로 오라는 ‘신호’가 없더라도 잠깐 앉아서 배를 마사지 하면서 3분 정도 기다리다가 나온다. 아침에 화장실에 가서 앉아 있는 버릇을 들이면 한번 배변 습관은 자연스럽게 따라온다.',null,null,to_date('20/03/14','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'식사 3~4시간 후 간식을 먹어라','hos1','조금씩 자주 먹는 것은 장수로 가는 지름길이다.  점심 식사후 속이 출출할 즈음이면 과일이나 가벼운 간식거리로 속을 채워 준다. 속이 완전히 비면 저녁에 폭식을 해 위에 부담이 된다. 그러나 점심을 배부르게  먹고, 오후에 배가 고프지 않은데도 또 먹으라는 것이 아니다. 그것은 비만으로  가는 지름길 일 뿐. 매 끼마다 한 숟가락만 더 먹고 싶을 때 수저를 놓는 습관을  들인다.',null,null,to_date('20/03/15','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'오른쪽 옆으로 누워 무릎을 구부리고 자라','hos1','세상에서 가장 편안한 자세는 아이가 엄마 뱃속에 들어 있을 때, 그 자세다. 심장에 무리를 주지 않도록 오른쪽으로 돌아누워 무릎을 약간 구부리는 자세로 있으면 가장 빨리 숙면에 빠질 수 있고 자는 중에 혈액 순환에도 도움이 된다.','test.txt','2020062515006_12313.txt',to_date('20/04/10','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'"괄약근 조이기" 체조를 한다','hos1','"괄약근 조이기"는 수많은 사람들이 있는 곳에서도 아무도 모르게 할 수 있는 건강 체조다. 출산 후 몸조리를 할 때나 갱년기 이후 요실금이 걱정될 때 이보다  더 좋은 운동은 없다. 바르게 서서 괄약근을 힘껏 조였다가 3초를 쉬고 풀어주는 동작을 반복한다.',null,null,to_date('20/04/11','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'하루에 10분 씩 노래를 부른다','hos1','스트레스를 많이 받거나 머리가 복잡할 때는 좋아하는 노래를 부른다.  듣지만 말고 큰소리로든 작은 흥얼거림이든 꼭 따라 부른다. 노래 부르기는 기분을 상쾌하게 하고 대인 기피나 우울증 치료에도 효과가 있어  정신과 치료에도 쓰이는 방법이다. 평소 설거지를 하거나 빨래를 개면서 노래를  흥얼거리는 습관은 마음을 젊고 건강하게 한다.',null,null,to_date('20/04/13','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'샤워를 하고 나서 물기를 닦지 말아라','hos1','피부도 숨을 쉴 시간이 필요하다. 샤워를 하고 나면 수건으로 보송보송하게 닦지 말고 저절로 마를 때까지 내버려 둔다. 샤워 가운을 입고 기다리는 것도 좋은 방법이다. 이 시간에 피부는 물기를 빨아들이고 탄력을 되찾는다.',null,null,to_date('20/04/14','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'차조기잎이 좋은 이유','hospital1','위장이 약해 설사를 자주할때는 차조기잎을 끓여마시면 좋다',null,null,to_date('20/04/15','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'양배추가 좋은 이유','hospital2','위염.위궤양에 양배추를 날것으로 보름정도 먹으면 효과가있다',null,null,to_date('20/07/01','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'적포도주가 좋은 이유','hospital1','적포도주는 물론 포도주스도 심장병예방에 효과가 있다',null,null,to_date('19/07/02','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'육류 먹는법','hospital3','육류는 냉장실.생선.조개류는 물에담가 해동을 시킨다',null,null,to_date('20/07/03','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'술이 안좋은 이유','hos1','술은 고환 기능저하를 초래해 남성호르몬 수치를 떨어뜨린다',null,null,to_date('20/07/04','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'고사리 먹는법','hospital1','고사리는 브라켄톡신이라는 발암물질때문에 반드시 삶아 먹어야한다',null,null,to_date('20/07/05','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'당근이 좋은 이유','hospital2','당근을 잘게 자르거나 으깨면 유익한 성분인 카로틴이 급속히 산화된다',null,null,to_date('20/07/06','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'밤 먹는법','hos1','밤은 속껍질과 과육에 탄닌 성분이 많기 때문에 속까지 굽지않는것이 좋다',null,null,to_date('20/07/07','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'인삼 먹는법','hospital1','인삼은 꿀에 재놓으면 일종의 독소성분이 발생하므로 좋지않다',null,null,to_date('20/07/10','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'파래가 좋은 이유','hos1','파래속에 함유된 메틸 메티오닌은 위.십이지장궤양을 막아주는 효과가있다',null,null,to_date('20/07/12','RR/MM/DD'),0);
Insert into WEB1.BOARD_HEALTH (BOARD_NO,BOARD_TITLE,HOSP_ID,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'갈치를 먹을 떄 주의사항','admin','갈치는 부스럼이나 습진등 피부염이 있을땐 먹지않는게 좋다',null,null,to_date('20/07/13','RR/MM/DD'),0);

--댓글/단 게시판 번호를 보고 insert할것
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'admin', '정말로 훌륭한 정보 군요!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'admin', '정말로 훌륭한 정보 군요!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'honggd', '밤에 눈이 침침햇는데 잘됫네요!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'turtle', '왜구놈 혼낼려면 건강을 챙겨야죠!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'joseon', '내가  바로 조선의 초대 국왕이니라!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'Faker', '롤하기전에 몸풀기에 딱좋겟네요!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'Faker', '롤드컵 우승을 위해!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'cheonghaejin', '내가바로 통일신라시대의 장수이니라!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'cheonghaejin', '이순신이 날 따를려면 이 상식을 다 외워야지!', 30, null, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 1, 'joseon', '짐은 참으로 뿌듯하구나!', 30, null, default);

--대댓글/단 댓글의 번호를 확인후 insert할것 / 병원 닉넴 정해지면 넣을것
insert into board_health_comment values(seq_board_health_comment.nextval, 2, 'admin', '감사합니다!', 30, 10, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 2, 'hos1', '건강하세요!', 30, 3, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 2, 'hos1', '훌륭한 왕이 되세요!', 30, 5, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 2, 'hos1', '바다에서도 힘내세요!', 30, 4, default);
insert into board_health_comment values(seq_board_health_comment.nextval, 2, 'Faker', '이제 롤의 신이 되는거에요!', 30, 6, default);
