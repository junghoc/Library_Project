<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="">
<head>
<title>도서관</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/font.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/about2.css" media="all">	
</head>
<body id="top">
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<jsp:include page="../Library_Menu_Top.jsp"/>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper bgded overlay" style="background-image:url('${pageContext.request.contextPath}/resources/images/backgrounds/background.jpg');">
  <div id="breadcrumb" class="hoc clear">  
    <!-- ################################################################################################ -->
    <h6 class="heading">도서관</h6>
    <!-- ################################################################################################ -->
    <ul>
      <li><a href="main.do">Home</a></li>
    </ul>
    <!-- ################################################################################################ -->
  </div>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <div class="sidebar one_quarter first"> 
      <!-- ################################################################################################ -->
      <h6>도서관 안내</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="about_pre.do">인사말</a></li>
          <li><a href="about_come.do">오시는 길</a></li>
          <li><a href="about_organization.do">조직도</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <h1>오시는 길</h1>
	  <div id="map" style="width:1000px;height:500px;"></div>
	  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=어디민키&libraries=services"></script>
	  	<script type="text/javascript">
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(37.566343073840436, 126.9778593824424),
				level: 3
			};
			
			var map = new kakao.maps.Map(container, options);
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch('서울특별시 중구 세종대로 110', function(result, status) {

			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">도서관</div>'
			        });
			        infowindow.open(map, marker);

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});    
		</script>
		<div class="d_width clearfix">
	
        <div id="content">	
    		<section id="divContents">
				<div id="divContent">
					<div class="guide">
		<div class="guideContent">
			<h3 class="guideTitle1"><span class="point1">서울도서관 교통편</span> 서울특별시 중구 세종대로 110</h3>
			<ul class="guideList2">
				<li class="marBot18">지하철정보
					<div class="guideTable2 marTop10">
						<table>
							<caption>[서울도서관 지하철 이용노선]-노선, 출구</caption>
							<colgroup>
							<col class="wid30">
							<col class="wid70">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">노선</th>
									<th scope="col">출구</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="alignCenter">1,2호선</td>
									<td class="alignCenter">시청역 ⑤번 출구</td>
								</tr>
							</tbody>
						</table>
					</div>
				</li>
				<li>버스정보
					<div class="guideTable2">
						<div class="marTop5">
							<table>
								<caption>서울시청 본청으로 오시는 버스 이용 노선-정류장명, 버스번호</caption>
								<colgroup>
								<col>
								<col>
								</colgroup>
								<thead>
									<tr>
										<th scope="col">정류장명</th>
										<th scope="col">버스번호</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>① 시청ㆍ서울신문사(02-706)</td>
										<td>공항 6005</td>
									</tr>
									<tr>
										<td>② 프레스센터(02-507)</td>
										<td>마을 종로09, 종로11, 공항 6701</td>
									</tr>
									<tr>
										<td>③ 시청앞ㆍ덕수궁(02-286)</td>
										<td>간선 103, 150, 401, 402, 406, N16, 지선 1711, 7016, 7022</td>
									</tr>
									<tr>
										<td>④ 시청광장(02-641)</td>
										<td>간선 172, 405, 472, N62</td>
									</tr>
									<tr>
										<td>⑤ 시청역(02-503)</td>
										<td>마을 종로09, 종로11</td>
									</tr>
									<tr>
										<td>⑥ 시청덕수궁(02-662)</td>
										<td>순환 90S투어, 공항6005</td>
									</tr>
									<tr>
										<td>⑦ 롯데호텔(02-639)</td>
										<td>공항 6701</td>
									</tr>
									<tr>
										<td>⑧ 서울프라자호텔(02-699)</td>
										<td>공항 6701</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="guideContent">
			<h3 class="guideTitle1">서울시청 주차장 안내</h3>
			<ul class="guideList1">
				<li>주차공간이 많이 부족하오니 되도록 대중교통을 이용해 주시기 바랍니다.<br>주차정보안내시스템(<a title="새창" href="http://parking.seoul.go.kr/" target="_blank">http://parking.seoul.go.kr/</a>)에서 시청 주변 공영주차장을 확인하실 수 있습니다.</li>
				<li>청사 시설물을 보호하기 위해 높이 2.3m 이상 차량은 주차장으로 진입할 수 없습니다.</li>
				<li>개방시간 : 평일 08:30~21:00 주말.공휴일 09:00 ~21:00 (시민청 개방시간과 동일)<br><span style="color:red">매월 넷째 주 수요일 '대중교통 이용의 날'</span>은 서울시 및 산하기관, 자치구 부설 <span style="color:red">주차장이 폐쇄됩니다.</span>(장애인 차량, 긴급차량 등 제외)</li>
				<li>주차요금 : 10분당 1,000원 (평일 09:00~18:00만 부과)</li>
				<li>할인 및 면제대상
					<div class="guideTable2 marTop10 marBot18">
						<table>
							<caption>서울시청 주차 할인 및 면제대상-할인 및 면제, 대상</caption>
							<colgroup>
							<col>
							<col>
							<col>
							</colgroup>
							<thead>
								<tr>
									<th colspan="2" scope="col">할인 및 면제</th>
									<th scope="col">대상</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th rowspan="3" scope="row" style="text-align: center;">할인</th>
									<td class="alignCenter">80%</td>
									<td>
										<ul class="guideList1">
											<li>장애인</li>
											<li>국가유공자</li>
											<li>고엽제후유의증환자 차량</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td class="alignCenter">50%</td>
									<td>
										<ul class="guideList1">
											<li>경형승용차</li>
											<li>저공해차량</li>
											<li>「다둥이 행복카드」 소지자차량 중 3자녀 이상</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td class="alignCenter">30%</td>
									<td>
										<ul class="guideList1">
											<li>「다둥이 행복카드」 소지자차량 중 2자녀</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th colspan="2" scope="row" style="text-align: center;">면제</th>
									<td>
										<ul class="guideList1">
											<li>공무수행 로고를 부착한 관용차량</li>
											<li>언론기관 로고 부착 등 외관상 식별이 가능한 보도차량</li>
											<li>국회의원, 시·구의원 차량</li>
											<li>외국사절 등 외빈차량, 단체견학차량, 물품납품 화물차량</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</li>
			</ul>
		</div>
	</div>
				</div>
			</section>
        </div>
    </div>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<jsp:include page="../Library_Menu_Footer.jsp"/>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
<!-- JAVASCRIPTS -->
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.backtotop.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>