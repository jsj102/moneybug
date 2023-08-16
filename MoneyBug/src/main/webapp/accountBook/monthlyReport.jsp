<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script></script>
<%@ include file="../resources/layout/header.jsp"%>
<%@ include file="../resources/layout/accountNav.jsp"%>

<div align="center">
	<!-- 날짜로 월간 넘어가게 설정가능해야함 -->
	<!--  ajax로 div에 gpt에서 받아온 결과 넣어줘야함. -->
	<!-- 차트 - 내역 -->
	<!-- 일별그래프 - 내역 -->
	<!-- GPT -->
	<!-- 선언만 먼저 해두고 ajax후에 success의 result로 chart생성 -->
<h3>월간 지출 차트</h3>
<div id="chartcontent" style="display: flex; width: 1100px; height: 655px; border: 1px solid #993300;">
    <div style="flex: 1;" id="chartdiv">
        <div id="mycharttest" style="width: 600px; height: 655px; border: 1px solid #993300;">
            <canvas id="myChart" style="width: 600px; height: 655px; border: 1px solid #993300;"></canvas>
        </div>
    </div>
    <div style="flex: 1; " id="MonthlyTalbe">
    </div>
</div>
<br>
<h3>최근 사용 내역(5회)</h3>
<div id="mycharttest2" style="display: flex; width: 1100px; height: 650px; border: 1px solid #993300;">
    <div style="flex: 1;">
        <canvas id="myChart2" style="width: 600px; height: 650px; border: 1px solid #993300;"></canvas>
    </div>
    <div style="flex: 1;">
        <div style=" border: 1px solid #993300; height: 340px;" id="RecentTable"></div>
	<!-- DB에서 GPT답변 받아오는 div -->
		<div id="resultGPT" style="padding: 5px;">GPT : 돈 아껴써라 마!!!
	
		</div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
    $(function() {
        $.ajax({
            url: "monthlyReportRequestJSON",
            dataType: "json",
            success: function(json) {
                let list = json.list;
                let map = json.map;
                let detailTotalDataList = [];
                let detailSomeDataPlusList = [];
                let detailSomeDataMinusList = [];
                let detailSomeLabelList = [];
                
                let listTable = '<table border="1" class="RecentTable"><tr><th>분류</th><th>사용내역</th><th>금액</th></tr>';
                for (var i = 0; i < list.length; i++) {
                    let formattedPrice = list[i].price.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
                    listTable += '<tr><td>' + list[i].accountCategory
                    + '</td><td>' + list[i].description
                    + '</td><td>' + formattedPrice + '</td></tr>';
                    detailSomeLabelList.push(list[i].description);
                    if(list[i].accountType=="지출"){
                    	detailSomeDataPlusList.push(0);
                        detailSomeDataMinusList.push(-list[i].price);
                    }else{
                    	
                    detailSomeDataPlusList.push(list[i].price);
                    detailSomeDataMinusList.push(0);
                    }
                }
                listTable += '</table>';
                


                $('#RecentTable').html(listTable);
                //
				$.ajax({
					url: "monthlyReportRequestBudgetAndExpenses",
					success : function(budgetMap) {
		        	    let labelList = [];
		        	    let budgetDataList = [];
		                for (var budgetKey in budgetMap) {
		                    labelList.push(budgetKey);
		                    budgetDataList.push(budgetMap[budgetKey]);
		                }
		                
		                let mapTable = '<table border="1" class="MonthlyTable"><tr><th>분류</th><th>총액(현재 지출)</th><th>(지출 계획)</th></tr>';
		                let listInt = 0;
		                for (var key in map) {
		                    let formattedTotalPrice = map[key].toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
		                    let formattedTotalPrice2 = " ( "+(budgetDataList[listInt]).toLocaleString()+ " ) ";
		                    mapTable += '<tr><td>' + key + '</td><td>'
		                    + formattedTotalPrice + '</td><td>'+formattedTotalPrice2+'</td></tr>';
		                    listInt=listInt+1;
		                    console.log(listInt);
		                    detailTotalDataList.push(map[key]);
		                }
		                mapTable += '</table>'; //1차 ajax로부터 데이터
		                $('#MonthlyTalbe').html(mapTable);//1차 ajax로부터 데이터
		                
						const ctx = document.getElementById('myChart');
						const ctx2 = document.getElementById('myChart2');
					//Chart.js 에서는 getContext('2d') 를 사용하지않아도됨.
						let char1Data = {
							labels : labelList,
							datasets : [
								{
									label : '지출',
									data : detailTotalDataList,
									fill : true,
									backgroundColor : 'rgba(255, 99, 132, 0.2)',
									borderColor : 'rgb(255, 99, 132)',
									pointBackgroundColor : 'rgb(255, 99, 132)',
									pointBorderColor : '#fff',
									pointHoverBackgroundColor : '#fff',
									pointHoverBorderColor : 'rgb(255, 99, 132)'
									},
								{
									label : '예산-고정지출',
									data : budgetDataList,
									fill : true,
									backgroundColor : 'rgba(54, 162, 235, 0.2)',
									borderColor : 'rgb(54, 162, 235)',
									pointBackgroundColor : 'rgb(54, 162, 235)',
									pointBorderColor : '#fff',
									pointHoverBackgroundColor : '#fff',
									pointHoverBorderColor : 'rgb(54, 162, 235)'
								} ]
					}; // graph 데이터 선입력부분
					const config = {
						type : 'radar',
						data : char1Data,
						options : {
							responsive : false,
							elements : {
								line : {
									borderWidth : 3
								}
							}
						},
					};
					new Chart(ctx, config);
					let data2 = {
						labels : detailSomeLabelList,
						datasets : [{
							label : '수입',
							data : detailSomeDataPlusList,
							fill : true,
							backgroundColor : 'rgba(54, 162, 235, 0.2)',
							borderColor : 'rgb(54, 162, 235)',
							pointBackgroundColor : 'rgb(54, 162, 235)',
							pointBorderColor : '#fff',
							pointHoverBackgroundColor : '#fff',
							pointHoverBorderColor : 'rgb(54, 162, 235)'
							},
								{
									label : '지출',
									data : detailSomeDataMinusList,
									fill : true,
									backgroundColor : 'rgba(255, 99, 132, 0.2)',
									borderColor : 'rgb(255, 99, 132)',
									pointBackgroundColor : 'rgb(255, 99, 132)',
									pointBorderColor : '#fff',
									pointHoverBackgroundColor : '#fff',
									pointHoverBorderColor : 'rgb(255, 99, 132)'
								}
								 ]
					};
					const config2 = {
						type : 'bar',
						data : data2,
						options : {
							responsive : false,
							indexAxis : 'y',
							elements : {
								line : {
									borderWidth : 3
								}
							}
						},
					};
					new Chart(ctx2, config2);

					
				},//2차 success
				error: function(xhr, status, error) {
	                var errorMessage = "2차 오류 상태 코드: " + xhr.status + "\n"
	                    + "오류 메시지: " + error + "\n" + "오류 타입: "
	                    + status;
	                alert(errorMessage);
	            }
				}); // ajax2차
            },
            error: function(xhr, status, error) {
                var errorMessage = "오류 상태 코드: " + xhr.status + "\n"
                    + "오류 메시지: " + error + "\n" + "오류 타입: "
                    + status;
                alert(errorMessage);
            }
        }); // ajax1차
    });
</script>
</div>
<%@ include file="../resources/layout/footer.jsp"%>