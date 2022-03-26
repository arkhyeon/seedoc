        var today = new Date();
        var date = new Date();

        // 이전 달
        function prevCalendar() {
            today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
            buildCalendar();
        }
        //다음 달
        function nextCalendar() {
            today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
            buildCalendar();
        }
        //달력
        function buildCalendar() {
            //달력의 첫째 날,
            var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
            //달력의 마지막 날
            var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            //테이블 변수
            var tbCalendar = document.getElementById("calendar");
            //날짜 찍는 변수
            var tbCalendarYM = document.getElementById("tbCalendarYM");

            tbCalendarYM.innerHTML = today.getFullYear() + "." + (today.getMonth() + 1);

            /*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
            while (tbCalendar.rows.length > 2) {
                tbCalendar.deleteRow(tbCalendar.rows.length - 1);
            }
            var row = null;
            row = tbCalendar.insertRow();
            var cnt = 0;
            for (i = 0; i < doMonth.getDay(); i++) {
                cell = row.insertCell();
                cnt = cnt + 1;
            }

            /*달력 출력*/
            for (i = 1; i <= lastDate.getDate(); i++) {
            	
            		cell = row.insertCell();
                    cell.innerHTML = i;
                    cnt = cnt + 1;
                    
                    if (cnt % 7 == 1) {
                        cell.innerHTML = "<font class='sun' color=#ff5d5d>" + i
                    }
                    if (cnt % 7 == 0) {
                        cell.innerHTML = "<font class='sat' color=#427cff>" + i
                        row = calendar.insertRow();
                    }
            	

                /*Today*/
                if (today.getFullYear() == date.getFullYear() &&
                    today.getMonth() == date.getMonth() &&
                    i == date.getDate()) {
                    cell.className = "on";
                    cell.title = "a";
                    cell.innerHTML = i+"<br/><span style='font-size:12px;'>오늘</span>";
                }
            }
            $("td").click(function () {
                cell.bgColor = "white"
                $("td").removeClass("on");
                $(this).addClass("on");
                $("font").removeClass("on");
                $(this).find("font").addClass("on");
            });
        }

        