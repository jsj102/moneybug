<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script></script>
<%@ include file="/layout/header.jsp"%>
<%@ include file="/layout/accountNav.jsp"%>

<style>
html, body{
	height: 100%;
	
}

body {
	background: #F9F5E7;
	display:flex;
	flex-direction:column;
	height:100%;
	flex:1;
	margin: 0;
}


.report {
padding-left: 250px;
margin: 100px 0 50px 0px;
}

.MonthlyDiv{display: flex; width:1200px; height:755px; background-color: #ffffff;  text-align: center; border: 1px solid #E1ECC8;}
.MonthlyDiv2{display: flex; width:1200px; height:340px; background-color: #ffffff;  text-align: center; border: 1px solid #E1ECC8;}
.MonthlyDiv3{display: flex; width:1200px; height:340px; background-color: #ffffff;  text-align: left; position: relative; 	color: black;
	font-weight: bold; padding: 5px;  }
.RecentTable {
    width: 600px;
    height: 340px;
    background-color: rgba(255, 255, 255, 0.472);
    text-align: center;
    border-collapse: collapse;
}

.RecentTable th,
.RecentTable td {
	color: black;
	font-weight: bold;
    padding: 8px; /* 셀 내용과 테두리 사이의 간격 */
}

.RecentTable th {
	font-weight: bold;
    background-color: rgba(200, 200, 200, 0.472); /* 테이블 헤더 배경색 */
}
.MonthlyTable{width:500px; height:755px; background-color: rgba(255, 255, 255, 0.472);  text-align: center; }
.MonthlyTable th,
.MonthlyTable td {
	color: black;
	font-weight: bold;
    padding: 8px; /* 셀 내용과 테두리 사이의 간격 */
}

.MonthlyTable th {
	font-weight: bold;
    background-color: rgba(200, 200, 200, 0.472); /* 테이블 헤더 배경색 */

}

</style>

<div align="center" id="section">
	<!-- 날짜로 월간 넘어가게 설정가능해야함 -->
	<!--  ajax로 div에 gpt에서 받아온 결과 넣어줘야함. -->
	<!-- 차트 - 내역 -->
	<!-- 일별그래프 - 내역 -->
	<!-- GPT -->
	<!-- 선언만 먼저 해두고 ajax후에 success의 result로 chart생성 -->
	<div align="right">
		<label for="year">년 : </label> <select id="year" name="year">
		</select> <label for="month">월 : </label> <select id="month" name="month">
		</select>
		<button id="moveReport" class="btn btn-success">이동</button>
		<button id="reportDownloadPDF" class="btn btn-success">다운로드(pdf)</button>
		<button id="reportDownloadExcel" class="btn btn-success">다운로드(excel)</button>
		<button id="snedToEmailReport" class="btn btn-success">이메일로 보내기</button>
	</div>
<div class="report">
	<h1>월간 지출(카테고리별)</h1><br>
	<div id="monthlyDivPart1" class="MonthlyDiv">
		<div style="flex: 1;" id="chartdiv">
			<div id="myChartPart1"
				style="width: 600px; height: 655px; ">
				<canvas id="myChart" style="width: 600px; height: 655px;"></canvas>
			</div>
		</div>
		<div id="MonthlyTable"></div>
	</div>
	<br>
	<h3>최근 사용 내역(5회)</h3>
	<div id="monthlyDivPart2" class="MonthlyDiv2">
		<div id="myChartPart2" style="flex: 1;">
			<canvas id="myChart2"
				style="width: 600px; height: 340px;"></canvas>
		</div>
		<div style="flex: 1;">
			<div style="width: 600px; height: 340px;"
				id="RecentTable"></div>
		</div>
	</div>
	<br>
	<h3>보고서</h3>
	<div id="resultGPT" class="MonthlyDiv3">
		GPT : 분석중!
		<!-- DB에서 GPT답변 받아오는 div -->
	</div>	
</div>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script type="text/javascript">
	$(function() {
	    let ctx = document.getElementById('myChart');
	    let ctx2 = document.getElementById('myChart2');
	    let chart1;
	    let chart2;

	    let userNickname = "";
	    let config;
	    let config2;
	    let accountBookId = -1;

	    // 년도 옵션 추가
	    let yearSelect = document.getElementById("year");
	    let currentYear = new Date().getFullYear();
	    for (let year = currentYear; year >= currentYear - 10; year--) {
		let option = document.createElement("option");
		option.value = year;
		option.textContent = year;
		yearSelect.appendChild(option);
	    }
	    // 월 옵션 추가
	    let monthSelect = document.getElementById("month");
	    for (let month = 1; month <= 12; month++) {
		let option = document.createElement("option");
		option.value = month;
		option.textContent = month;
		monthSelect.appendChild(option);
	    }
	    monthSelect.selectedIndex = new Date().getMonth();
	    //사전 설정부  

	    $.ajax({
		url : "getUserNickname",
		success : function(nickname) {
		    userNickname = nickname;
		}

	    })

	    $.ajax({
			url : "seq",
			success : function(acountSeq) {//accountBookId seq ajax start
			    accountBookId = acountSeq;

			    $
				    .ajax({
					url : "monthlyReportRequestJSON",
					dataType : "json",
					method : "POST",
					data : {
					    accountBookId : accountBookId,
					    year : $('#year').val(),
					    month : $('#month').val()
					},
					success : function(json) {
					    let list = json.list;
					    let map = json.map;
					    let detailSomeDataPlusList = [];
					    let detailSomeLabelList = [];
					    let detailSomeDataMinusList = [];
					    listTableFunc(list,
						    detailSomeDataPlusList,
						    detailSomeDataMinusList,
						    detailSomeLabelList);

					    $
						    .ajax({
							url : "monthlyReportRequestBudgetAndExpenses",
							method : "POST",
							data : {
							    accountBookId : accountBookId,
							    year : $('#year')
								    .val(),
							    month : $('#month')
								    .val()
							},
							success : function(
								budgetMap) {
							    let labelList = [];
							    let detailTotalDataList = [];
							    let budgetDataList = [];
							    for ( var budgetKey in budgetMap) {
								labelList
									.push(budgetKey);
								budgetDataList
									.push(budgetMap[budgetKey]);
							    }

							    mapTableFunc(
								    map,
								    detailTotalDataList,
								    budgetDataList); //상단 테이블

							    let chart1DataFromFunc = setChart1Data(
								    labelList,
								    detailTotalDataList,
								    budgetDataList);

							    chart1 = new Chart(
								    ctx,
								    setChart1Config(chart1DataFromFunc));

							    let chart2DataFromFunc = setChart2Data(
								    detailSomeLabelList,
								    detailSomeDataMinusList,
								    detailSomeDataPlusList);

							    chart2 = new Chart(
								    ctx2,
								    setChart2Config(chart2DataFromFunc));
							},//2차 success
							error : function(xhr,
								status, error) {
							    let errorMessage = "2차 오류 상태 코드: "
								    + xhr.status
								    + "\n"
								    + "오류 메시지: "
								    + error
								    + "\n"
								    + "오류 타입: "
								    + status;
							    alert(errorMessage);
							}
						    }); // ajax2차
					},
					error : function(xhr, status, error) {
					    let errorMessage = "오류 상태 코드: "
						    + xhr.status + "\n"
						    + "오류 메시지: " + error + "\n"
						    + "오류 타입: " + status;
					    alert(errorMessage);
					}
				    }); // ajax1차 - 페이지 호출시 자동

			    $.ajax({
				url : "monthlyGPT",
				method : "POST",
				data : {
				    accountBookId : accountBookId,
				    year : $('#year').val(),
				    month : $('#month').val()
				},
				success : function(answer) {
				    $('#resultGPT').html(answer);
				},
				error : function() {
				    $('#resultGPT').html("아직 분석되지 않은 레포트입니다.");
				}
			    });//gpt ajax

			},
			error : function() {

			}
		    }) //accountBookId ajax end

	    $('#moveReport')
		    .click(
			    function() {
				$
					.ajax({
					    url : "monthlyReportRequestJSON",
					    dataType : "json",
					    method : "POST",
					    data : {
						accountBookId : accountBookId,
						year : $('#year').val(),
						month : $('#month').val()
					    },
					    success : function(json) {
						let list = json.list;
						let map = json.map;
						let detailSomeDataPlusList = [];
						let detailSomeLabelList = [];
						let detailSomeDataMinusList = [];
						listTableFunc(
							list,
							detailSomeDataPlusList,
							detailSomeDataMinusList,
							detailSomeLabelList);
						//
						$
							.ajax({
							    url : "monthlyReportRequestBudgetAndExpenses",
							    method : "POST",
							    data : {
								accountBookId : accountBookId,
								year : $(
									'#year')
									.val(),
								month : $(
									'#month')
									.val()
							    },
							    success : function(
								    budgetMap) {
								let labelList = [];
								let detailTotalDataList = [];
								let budgetDataList = [];
								for ( var budgetKey in budgetMap) {
								    labelList
									    .push(budgetKey);
								    budgetDataList
									    .push(budgetMap[budgetKey]);
								}

								mapTableFunc(
									map,
									detailTotalDataList,
									budgetDataList);

								//Chart.js 에서는 getContext('2d') 를 사용하지않아도됨.

								chart1.data = setChart1Data(
									labelList,
									detailTotalDataList,
									budgetDataList);
								chart1.update();

								chart2.data = setChart2Data(
									detailSomeLabelList,
									detailSomeDataMinusList,
									detailSomeDataPlusList);
								chart2.update();
							    },//2차 success
							    error : function(
								    xhr,
								    status,
								    error) {
								let errorMessage = "2차 오류 상태 코드: "
									+ xhr.status
									+ "\n"
									+ "오류 메시지: "
									+ error
									+ "\n"
									+ "오류 타입: "
									+ status;
								alert(errorMessage);
							    }
							}); // ajax2차
						$
							.ajax({
							    url : "monthlyGPT",
							    method : "POST",
							    data : {
								accountBookId : accountBookId,
								year : $(
									'#year')
									.val(),
								month : $(
									'#month')
									.val()
							    },
							    success : function(
								    answer) {
								$('#resultGPT')
									.html(
										answer);
							    },
							    error : function() {
								$('#resultGPT')
									.html(
										"아직 분석되지 않은 레포트입니다.");
							    }
							});//gpt ajax
					    },
					    error : function(xhr, status, error) {
						let errorMessage = "오류 상태 코드: "
							+ xhr.status + "\n"
							+ "오류 메시지: " + error
							+ "\n" + "오류 타입: "
							+ status;
						alert(errorMessage);
					    }
					}); // ajax1차 - 페이지 호출시 자동
			    })

	    $('#reportDownloadPDF').click(
		    function() {
			let year = $('#year').val();
			let month = $('#month').val();
			let chartImage = ctx.toDataURL('image/png'); //base64로 변환
			$.ajax({
			    url : "downloadPDF",
			    method : "POST",
			    xhrFields : {
				responseType : "blob" //responseType을 blob으로 설정해 바이너리 데이터를 받아오도록함
			    },
			    data : {
				chartImage : chartImage,
				userNickname : userNickname,
				accountBookId : accountBookId,
				year : year,
				month : month
			    },
			    success : function(pdf) {

				// 다운로드 링크 생성
				let file = new File([ pdf ], "accountBook_"
					+ accountBookId + "_" + year + "_"
					+ month + ".pdf", {
				    type : "application/pdf"
				}); //file객체를 이용해 binary데이터(pdf)를 "~"형태의 이름으로 저장 MIME타입은 application/pdf로 pdf임을 명시
				let link = document.createElement("a");
				link.href = URL.createObjectURL(file); //window객체의 하위객체인 URL 객체를 통해 파일 접근링크 생성
				link.download = file.name; // 파일 다운로드
				document.body.appendChild(link);
				link.click();
				document.body.removeChild(link);
			    },
			    error : function() {

			    }
			});
		    }); // reportDownloadPDF
	    $('#reportDownloadExcel')
		    .click(
			    function() {
				let year = $('#year').val();
				let month = $('#month').val();
				$
					.ajax({
					    url : "downloadExcel",
					    method : "POST",
					    xhrFields : {
						responseType : "blob" //responseType을 blob으로 설정해 바이너리 데이터를 받아오도록함
					    },
					    data : {
						userNickname : userNickname,
						accountBookId : accountBookId,
						year : year,
						month : month
					    },
					    success : function(excel) {

						// 다운로드 링크 생성
						let file = new File(
							[ excel ],
							"accountBook_"
								+ accountBookId
								+ "_" + year
								+ "_" + month
								+ ".xlsx",
							{
							    type : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
							});
						let link = document
							.createElement("a");
						link.href = URL
							.createObjectURL(file); //window객체의 하위객체인 URL 객체를 통해 파일 접근링크 생성
						link.download = file.name; // 파일 다운로드
						document.body.appendChild(link);
						link.click();
						document.body.removeChild(link);
					    },
					    error : function() {

					    }
					});
			    }); // reportDownloadExcel
			    
		$('#snedToEmailReport').click(function() {
		    let tableContent = document.getElementById("MonthlyTable").innerHTML;
		    let tableContent2 = document.getElementById("RecentTable").innerHTML;
		    let gptContent = document.getElementById("resultGPT").innerHTML;
		    let chartImage = ctx.toDataURL('image/png'); 
		    let graphImage = ctx2.toDataURL('image/png'); 
		    let email;
		    $.ajax({
				url : "getEmail",
				method : "POST",
				success : function(useremail){
				    email = useremail;
					$.ajax({
					    url : "sendEmailReport",
					    method : "POST",
					    data : {
							email : email,
							tableContent : tableContent,
							tableContent2 : tableContent2,
							gptContent : gptContent,
							chartImage : chartImage,
							graphImage : graphImage
					    },
					    success : function(){
							alert("메일로 보고서가 전송 되었습니다.")
					    },
					    error : function(){
							alert("실패.")
					    }
					}); //ajax sendEmailReport
				}//ajax get Email success
		    })//ajax get Email
		}); //snedToEmailReport

	});//$
	function listTableFunc(list, detailSomeDataPlusList,
		detailSomeDataMinusList, detailSomeLabelList) {
	    let listTable = '<table border="1" class="RecentTable"><tr><th>분류</th><th>타입</th><th>사용내역</th><th>금액</th></tr>';
	    for (var i = 0; i < list.length; i++) {
		let formattedPrice = list[i].price.toLocaleString('ko-KR', {
		    style : 'currency',
		    currency : 'KRW'
		});
		listTable += '<tr><td>' + list[i].accountCategory + '</td><td>'
			+ list[i].accountType + '</td><td>'
			+ list[i].description + '</td><td>' + formattedPrice
			+ '</td></tr>';
		detailSomeLabelList.push(list[i].description);
		if (list[i].accountType == "지출") {
		    detailSomeDataPlusList.push(0);
		    detailSomeDataMinusList.push(-list[i].price);
		} else {

		    detailSomeDataPlusList.push(list[i].price);
		    detailSomeDataMinusList.push(0);
		}
	    }
	    listTable += '</table>';

	    $('#RecentTable').html(listTable);
	}//endfunction

	function mapTableFunc(map, detailTotalDataList, budgetDataList) {
	    let mapTable = '<table border="1" class="MonthlyTable"><tr><th>분류</th><th>총액(현재 지출)</th><th>(지출 계획)</th></tr>';
	    let listInt = 0;
	    for ( var key in map) {
		let formattedTotalPrice = map[key].toLocaleString('ko-KR', {
		    style : 'currency',
		    currency : 'KRW'
		});
		let formattedTotalPrice2 = " ( "
			+ (budgetDataList[listInt]).toLocaleString() + " ) ";
		mapTable += '<tr><td>' + key + '</td><td>'
			+ formattedTotalPrice + '</td><td>'
			+ formattedTotalPrice2 + '</td></tr>';
		listInt = listInt + 1;
		detailTotalDataList.push(map[key]);
	    }
	    mapTable += '</table>'; //1차 ajax로부터 데이터
	    $('#MonthlyTable').html(mapTable);//1차 ajax로부터 데이터
	}//endfunction
	function setChart1Data(labelList, detailTotalDataList, budgetDataList) {
	    //Chart.js 에서는 getContext('2d') 를 사용하지않아도됨.
	    let chart1Data = {
		labels : labelList,
		datasets : [ {
		    label : '지출',
		    data : detailTotalDataList,
		    fill : true,
		    backgroundColor : 'rgba(255, 99, 132, 0.2)',
		    borderColor : 'rgb(255, 99, 132)',
		    pointBackgroundColor : 'rgb(255, 99, 132)',
		    pointBorderColor : '#fff',
		    pointHoverBackgroundColor : '#fff',
		    pointHoverBorderColor : 'rgb(255, 99, 132)'
		}, {
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
	    return chart1Data;
	}//endfunction
	function setChart1Config(chart1Data) {
	    config = {
		type : 'radar',
		data : chart1Data,
		options : {
		    responsive : false,
		    elements : {
			line : {
			    borderWidth : 3
			}
		    },
		    plugins : {
			legend : {
			    labels : {
				font : {
				    size : 16
				}
			    }
			}
		    }
		}
	    //option  
	    };
	    return config;
	}//endfunction

	function setChart2Data(detailSomeLabelList, detailSomeDataMinusList,
		detailSomeDataPlusList) {
	    let chart2Data = {
		labels : detailSomeLabelList,
		datasets : [ {
		    label : '수입',
		    data : detailSomeDataPlusList,
		    fill : true,
		    backgroundColor : 'rgba(54, 162, 235, 0.2)',
		    borderColor : 'rgb(54, 162, 235)',
		    pointBackgroundColor : 'rgb(54, 162, 235)',
		    pointBorderColor : '#fff',
		    pointHoverBackgroundColor : '#fff',
		    pointHoverBorderColor : 'rgb(54, 162, 235)'
		}, {
		    label : '지출',
		    data : detailSomeDataMinusList,
		    fill : true,
		    backgroundColor : 'rgba(255, 99, 132, 0.2)',
		    borderColor : 'rgb(255, 99, 132)',
		    pointBackgroundColor : 'rgb(255, 99, 132)',
		    pointBorderColor : '#fff',
		    pointHoverBackgroundColor : '#fff',
		    pointHoverBorderColor : 'rgb(255, 99, 132)'
		} ]
	    };
	    return chart2Data;
	}//endfunction
	function setChart2Config(chart2Data) {
	    config2 = {
		type : 'bar',
		data : chart2Data,
		options : {
		    responsive : false,
		    indexAxis : 'y',
		    elements : {
			line : {
			    borderWidth : 3
			}
		    },
		    plugins : {
			legend : {
			    labels : {
				font : {
				    size : 16
				}
			    }
			}
		    }
		}
	    //options
	    };
	    return config2;
	}//endfunction
    </script>

</div>
<%@ include file="/layout/accountAside.jsp"%>
<%@ include file="/layout/footer.jsp"%>