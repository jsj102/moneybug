<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>BonVote_list</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h1 {
            margin-top: 20px;
        }

        .vote-button {
            font-size: 27px;
            padding: 20px 30px;
            margin: 10px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .vote-button[data-vote="1"] {
            background-color: #61c8ff;
            color: white;
        }
        .vote-button[data-vote="0"] {
            background-color: #ff4589;
            color: white;
        }

        .vote-button:hover {
            background-color: #555;
            color: white;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1 style='color: rgb(151, 92, 255); font-size: 30px;'>내 의견을 투표해보자!</h1>

    <button id="upButton" class="vote-button" data-vote="1">살까</button>
    <button id="downButton" class="vote-button" data-vote="0">말까</button>
   
    <div id="voteResults"></div>  

    <script>
        $(document).ready(function () {
            $("#upButton").click(function () {
                processVote("upButton");
            });

            $("#downButton").click(function () {
                processVote("downButton");
            });

            function updateVoteRatio(upVotes, downVotes) {
                var totalVotes = upVotes + downVotes;
                var upVoteRatio = (upVotes / totalVotes) * 100;
                var downVoteRatio = (downVotes / totalVotes) * 100;

                $("#voteResults").html(
                    "<h2>돈벌레들의 의견은?</h2>" +
                    "<h6>참여자 " + totalVotes + "명</h6>"+
                    "<div style='color: #3D81FF; font-size: 24px;'>살까 " + upVoteRatio.toFixed(2) + "%</div>" +
                    "<div style='color: #f934bb; font-size: 24px;'>말까 " + downVoteRatio.toFixed(2) + "%</div>"
                );
            }

            function fetchVoteCounts() {
                var upVotes = 27; // 변경된 투표 결과
                var downVotes = 44888; // 변경된 투표 결과
                updateVoteRatio(upVotes, downVotes);
            }

            fetchVoteCounts(); // 투표 비율 초기화

            function processVote(voteType) {
                $.ajax({
                    type: "POST",
                    url: "BonVote_insert", // 처리될 url 
                    data: {
                        voteType: voteType
                    },
                    success: function (response) {
                        alert(response + "라고 외치셨습니다!");
                        fetchVoteCounts(); // 투표 완료 후 비율 업데이트
                    },
                    error: function () {
                        alert("투표 처리 중 오류 발생");
                    }
                });
            }
        });
    </script>
</body>
</html>
