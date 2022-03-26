<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="../css/booking-start.css">
<section>
        <div class="bk-logo-wrap">
            <div class="hos-logo">
                <img src="../img/booking-logo.png" alt="">
                <img src="../img/booking-main.jpg" alt="">
            </div>
            <div class="opa-back"></div>
        </div>
        <h1 class="title"><span>●</span> 예약하기</h1>
        <div class="bk-main-wrap">
            <div class="doc-wrap">
                <div class="doc-img">
                    <img src="../img/booking-doctor.jpg" alt="">
                </div>
                <div class="doc-info">
                    <h1>홍석균 교수</h1>
                    <p>[진료분야]</p>
                    <p>위암, 위암수술, 위장관기질종양, 복강경수술</p>
                </div>
            </div>
            <div class="bk-info-wrap">
                <div class="bk-info">
                    <table id="calendar">
                        <tr class="cal-title">
                            <th colspan="2" style="text-align: right;">
                                <label onclick="prevCalendar()">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                        width="7px" height="11px">
                                        <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
                                            d="M2.983,5.500 L6.014,8.530 C6.372,8.889 6.372,9.471 6.014,9.830 C5.655,10.188 5.073,10.188 4.715,9.830 L1.511,6.626 C1.262,6.638 1.009,6.556 0.818,6.366 C0.583,6.130 0.517,5.801 0.591,5.500 C0.517,5.198 0.583,4.869 0.818,4.634 C1.009,4.443 1.262,4.361 1.512,4.373 L4.715,1.170 C5.073,0.811 5.655,0.811 6.014,1.170 C6.372,1.529 6.372,2.110 6.014,2.469 L2.983,5.500 Z" />
                                    </svg>
                                </label>
                            </th>
                            <th id="tbCalendarYM" colspan="3">
                                yyyy년 m월
                            </th>
                            <th colspan="2" style="text-align: left;">
                                <label onclick="nextCalendar()">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                        width="7px" height="11px">
                                        <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
                                            d="M6.026,6.397 C5.835,6.588 5.582,6.670 5.332,6.657 L2.129,9.861 C1.770,10.219 1.188,10.219 0.830,9.861 C0.471,9.502 0.471,8.920 0.830,8.562 L3.860,5.531 L0.830,2.500 C0.471,2.142 0.471,1.560 0.830,1.201 C1.188,0.843 1.770,0.843 2.129,1.201 L5.332,4.405 C5.582,4.392 5.835,4.474 6.026,4.665 C6.261,4.900 6.326,5.230 6.252,5.531 C6.326,5.833 6.261,6.161 6.026,6.397 Z" />
                                    </svg>
                                </label>
                            </th>
                        </tr>
                        <tr>
                            <th style="text-align: center; color: #ff5d5d;">
                                일
                            </th>
                            <th>월</th>
                            <th>화</th>
                            <th>수</th>
                            <th>목</th>
                            <th>금</th>
                            <th style="text-align: center; color: #427cff;">
                                토
                            </th>
                        </tr>
                    </table>
                    <script language="javascript" type="text/javascript">
                        buildCalendar(); //
                    </script>
                    <div class="time-wrap">
                        <p class="time-title">오전</p>
                        <div class="time">
                            <input type="button" value="9:00">
                            <input type="button" value="10:00">
                            <input type="button" value="10:30">
                            <input type="button" value="11:00">
                            <input type="button" value="11:30">
                        </div>
                        <p class="time-title">오후</p>
                        <div class="time">
                            <input type="button" value="2:00">
                            <input type="button" value="2:30">
                            <input type="button" value="3:00">
                            <input type="button" value="3:30">
                            <input type="button" value="4:00">
                            <input type="button" value="4:30">
                            <input type="button" value="5:00">
                            <input type="button" value="5:30">
                            <input type="button" value="6:00">
                        </div>
                    </div>
                </div>
                <div class="bk-info">
                    <div class="bk-title">추가정보<span>
                            <img src="../img/check-off.png" alt="">
                            필수입력</span>
                    </div>
                    <div class="bk-info-main">
                        <h3>&lt;예약안내 공지사항&gt;</h3>
                        <p class="notice">
                            싹이 꽃이 노래하며 거선의 만천하의 밥을 낙원을 용기가
                            그들에게 것이다. 기관과 우는 얼마나 칼이다. 품에 역사를
                            거선의 갑 같지 속잎나고, 그림자는 모래뿐일 것이다.
                            위하여 때에, 피는 관현악이며, 사막이다. 전인 원대하고,
                            뜨고, 있는가?
                        </p>
                        <p class="item-title"><img src="../img/check-on.png" alt="">생년월일</p>
                        <input type="date" class="user-input check-input" value="2020-06-26">
                        <p class="item-title" style="display: block;">
                            <img src="../img/check-on.png" alt="">불편하신 부위
                        </p>
                        <textarea name="" id="" cols="30" rows="10"></textarea>
                        <p class="item-title choice">연락처</p>
                        <input type="text" placeholder="연락처">
                        <p class="item-title choice">이메일</p>
                        <input type="text" placeholder="이메일">
                        <input type="checkbox" name="agree" id="agree">
                        <label class="agree-label" for="agree">이용자 약관 전체동의</label><span><img src="../img/w-check.png"
                                alt=""> 필수입력</span>
                        <input class="reg-btn" type="button" value="예약">
                    </div>
                </div>
            </div>
        </div>
        </div>
    </section>
    <div class="modal_back"></div>
    <div class="modal">
        <h1>예약확인</h1>
        <p>예약자 : 홍길동</p>
        <p>예약 날짜 : 2020.07.06.</p>
        <p>예약 시간 : 오후 4:30</p>
        <p>생년월일: 1995.06.09.</p>
        <p>전화번호: 010-2488-8684</p>
        <p>병원 : 동탄아이비치과</p>
        <p>담당의사 : 홍석균 교수</p>
        <a href="../index.html"><input type="button" value="확인"></a>
    </div>
    <script>
        $(".time").find("input").click(function () {
            $(".time").find("input").css({
                "background-color": "white",
                "color": "black"
            });
            $(this).css({
                "background-color": "#4286f4",
                "color": "white"
            });
        });

        $(".reg-btn").click(function () {
            $(".modal").css("display", "block");
            $(".modal_back").css("display", "block");
        });
        $(".modal_back").click(function () {
            $(".modal").css("display", "none");
            $(".modal_back").css("display", "none");
        });
    </script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>