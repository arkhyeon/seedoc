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

--삭제
DELETE FROM tbl_user WHERE user_id = 'user1';
--저장
commit;
