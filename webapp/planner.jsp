<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="planner.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>

<script type="text/javascript">

	function btnAdd_click() {
			// 테이블 동적 생성		
			// tr 생성
			var tr=tblMember.insertRow();
			
			// 번호
			var tblNum=tblMember.rows.length-1;
			
			var td0=tr.insertCell(0);
			td0.appendChild(document.createTextNode(tblNum));
			
			// 첫번째 열 생성 : 출발 지역
			var td1=tr.insertCell(1);
			// input text 추가
			var txt1= document.createElement("input");
			txt1.name="departurePlace";
			td1.appendChild(txt1);
			
			// 두번째 열 생성 : 도착 지역
			var td2=tr.insertCell(2);
			var txt2= document.createElement("input");
			txt2.name="arrivePlace";
			td2.appendChild(txt2);
			
			// 세번째 열 생성 : 출발 시간
			var td3=tr.insertCell(3);
			// input text 추가
			var txt3= document.createElement("input");
			txt3.name="departureTime";
			td3.appendChild(txt3);
			
			// 네번째 열 생성 : 도착 시간
			var td4=tr.insertCell(4);
			var txt4= document.createElement("input");
			txt4.name="arriveTime";
			td4.appendChild(txt4);
			
			// 다섯번째 열 생성 : 체류 시간
			var td5=tr.insertCell(5);
			var txt5= document.createElement("input");
			txt5.name="stayTime";
			td5.appendChild(txt5);
			
			// 여섯번째 열 생성 
			var td6=tr.insertCell(6);
			// checkbox 추가
			var ckb= document.createElement("input");
			ckb.type="checkbox";
			ckb.name="ckbSelect";
			td6.appendChild(ckb);
		}
	
	function isValidDateSetting(year,month,date, hour){
	
		var current, year, month, day, days, i, j; 
		
		current = new Date(); 
		year = (year) ? year : current.getFullYear(); 
		
		for (i=0, j=year-4; i < 10; i++, j++)  
		year.options[i] = new Option(j, j); 
		
		month = (month) ? month : current.getMonth()+1; 
		for (i=0; i < 12; i++) { 
			j = (i < 9) ? '0'+(i+1) : i+1; 
			month.options[i] = new Option(j, j); 
		} 

		day = (day) ? day : current.getDate(); 
		
		days = new Date(new Date(year, month, 1)-86400000).getDate(); 
		FORM.day.length = 0; 
		for (i=0, j; i < days; i++) { 
		j = (i < 9) ? '0'+(i+1) : i+1; 
		FORM.day.options[i] = new Option(j, j); 

		} 

		FORM.year.value = year; 
		FORM.month.options[month-1].selected = true; 
		FORM.day.options[day-1].selected = true; 
	}
	
</script>

</head>
<body>
	<div id="container">
		<c:import url="header.jsp" />
		<div id="section">
			<div class="koreqMap">
				<div id="map" style="width: 100%; height: 500px;"></div>
					<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=1c718cb9d23bfc8c4bb456b3b16086cd"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
							level : 3
						// 지도의 확대 레벨
						};
	
						// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
						var map = new daum.maps.Map(mapContainer, mapOption);
					</script>
			</div>
			<div class="timetable">
				<ul class="tra_box box2">
								<li class="wd20"><input type="radio" name="selGoTrainRa" value="05" title="전체" onclick="fnSelGoTrain('05','1');" checked="checked"><label>전체</label></li>
								<li><input type="radio" name="selGoTrainRa" value="00" title="KTX" onclick="fnSelGoTrain('00','2');"><label>KTX⁄KTX–산천</label></li>
								<li><input type="radio" name="selGoTrainRa" value="09" title="ITX-청춘" onclick="fnSelGoTrain('09','3');"><label>ITX-청춘</label></li>
								<li class="ml20p"><input type="radio" name="selGoTrainRa" value="08" title="ITX-새마을" onclick="fnSelGoTrain('08','9');"><label>새마을호⁄ITX-새마을</label></li>
								<li><input type="radio" name="selGoTrainRa" value="02" title="무궁화" onclick="fnSelGoTrain('02','4');"><label>무궁화호⁄누리로</label></li>
								<li class="ml20p"><input type="radio" name="selGoTrainRa" value="06" title="공항직통" onclick="fnSelGoTrain('06','7');"><label>공항직통</label></li>
								<li><input type="radio" name="selGoTrainRa" value="03" title="통근열차" onclick="fnSelGoTrain('03','8');"><label>통근열차</label></li>
							</ul>
							<div class="rbox_cont dis">
								<form name="form1">
									<dl class="pt01">
									<dt>여정경로</dt>
									<dd><input type="radio" id="route01" name="radJobId" value="1" onclick="javascript:gourl('1');" onkeypress="javascript:gourl('1');" checked="checked"><label for="route01">직통</label>&nbsp;&nbsp;&nbsp;
										
										<input type="radio" id="route02" name="radJobId" value="2" onclick="javascript:gourl('2');" onkeypress="javascript:gourl('2');"><label for="route02">환승</label>&nbsp;&nbsp;&nbsp;
										<input type="radio" id="route03" name="radJobId" value="3" onclick="javascript:gourl('3');" onkeypress="javascript:gourl('3');"><label for="route03">왕복</label>&nbsp;&nbsp;
										
									</dd>
									</dl>
									
									<dl class="pt02">
									<dt><label for="start">출발역</label></dt>
									<dd><input id="start" name="txtGoStart" type="text" class="inp250" value="서울" onchange="hideResult();" title="출발역" autocomplete="off" style="ime-mode:active">
										<a href="javascript:btnPopWin(1,'txtGoStart')"><img src="/images/btn_tra_sch.png" alt="조회"></a>
									</dd>
									</dl>
									
									<dl class="pt02">
									<dt><label for="get">도착역</label></dt>
									<dd><input id="get" name="txtGoEnd" type="text" class="inp250" value="부산" onchange="hideResult();" title="도착역" autocomplete="off" style="ime-mode:active">
										<a href="javascript:btnPopWin(1,'txtGoEnd')"><img src="/images/btn_tra_sch.png" alt="조회"></a>&nbsp;
										<a href="#" onclick="sta_chg('form1'); return false;" title="변경 버튼을 누르면 출발역과 도착역이 서로 바뀝니다"><img src="/images/btn_tra_chg.png" alt="출발/도착역 교환"></a>
										<input type="hidden" name="txtGoStartCode" value="">
										<input type="hidden" name="txtGoEndCode" value="">
									</dd>
									</dl>
									
									<dl class="pt03">
									<dt>출발일</dt>
									<dd><label for="s_year" class="blind">출발년도</label>
										<select id="s_year" name="selGoYear" onchange="isValidDateSetting(form1.selGoYear,form1.selGoMonth,form1.selGoDay,form1.selGoHour);" title="출발일시 : 년도">
											
										</select>년
										
										<label for="s_month" class="blind">출발월</label>
										<select id="s_month" name="selGoMonth" onchange="isValidDateSetting(form1.selGoYear,form1.selGoMonth,form1.selGoDay,form1.selGoHour);" title="출발일시 : 월">
											
										</select>월
										
										<label for="s_day" class="blind">출발일자</label>
										<select id="s_day" name="selGoDay" onchange="isValidDateSetting(form1.selGoYear,form1.selGoMonth,form1.selGoDay,form1.selGoHour);" title="출발일시 : 일">
											
										</select>일
										
										<label for="s_hour" class="blind">출발시</label>
										<select id="s_hour" name="selGoHour" title="출발일시 : 시" onchange="hideResult();">
										
										</select>시<input type="hidden" name="txtGoHour">
										
										<label for="s_week" class="blind">출발요일</label>
										<input id="s_week" type="text" size="2" name="txtGoYoil" value="수" readonly="readonly" title="출발일시 : 요일" class="inp20">&nbsp;<a href="javascript:btnPopWin(2,'Go')" title="달력 새창열기"><img src="/images/btn_calen02.gif" alt="달력"></a>
									</dd>
									</dl>
								</form>
							</div>
			</div>
			<div class="plantable">
					버튼 누르면 테이블 생성
					<input type="button" id="btn_click" value="버튼" onclick="btnAdd_click();">
					<input type="reset" id="btn_reset" value="지우기">
					<table id="tblMember">
						<tr>
							<th>No</th>
							<th>출발지역</th>
							<th>도착지역</th>
							<th>출발시간</th>
							<th>도착시간</th>
							<th>체류시간</th>
						</tr>
						<tr>
							<td>1</td>
							<td><input type="text"	name="departurePlace"></td>
							<td><input type="text"	name="arrivePlace"></td>
							<td><input type="text"	name="departureTime"></td>
							<td><input type="text"	name="arriveTime"></td>
							<td><input type="text"	name="stayTime"></td>
							<td><input type="checkbox" name="ckbSelect"></td>
				 		</tr>
				</table>
				</div>
		</div>
		<c:import url="footer.jsp" />
	</div>
</body>
</html>