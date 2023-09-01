package com.multi.moneybug.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Controller
@Slf4j
public class ChatController {
    @Autowired
    private ChatService chatService;

    @GetMapping("/chat")
    @ResponseBody
    public List<ChatMessage> showChatPage(@RequestParam(required = false) String channel) throws InterruptedException, ExecutionException {
        List<ChatMessage> messages = chatService.getAllMessages(channel);
        return messages;
    }

    @PostMapping("/send")
    public String sendMessage(@RequestParam String name, @RequestParam String text,  @RequestParam String channel) {
    	
    	if (channel.startsWith("chatbot")) {
    	    chatService.sendMessage(name, text, channel);
    	    chatBot(name, text, channel);
    	} else {
    	    chatService.sendMessage(name, text, channel);
    	}

        return "redirect:/chat"; // 채팅 페이지로 리다이렉트
    }
    
    public void chatBot(String name, String text, String channel) {
        String menu = "";
        name = "챗봇";
        
        String buttonPrefix = "<button type='button' class='btn btn-primary btn-sm' style='background-color: #F3969A;' onclick=\"setInputValueAndSubmit('%s')\">%s</button>";
        
        switch (text) {
		case "고객센터&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>고객센터>> https://pf.kakao.com/_xnCxfIG </SPAN>";
			break;
		case "가계부&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>가계부>> 가계부에서 어떤 기능이 궁금하신가요?</SPAN>"+ " " + String.format(buttonPrefix, "영수증OCR&", "영수증OCR");
			break;
		case "영수증OCR&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>영수증OCR 기능에 대해서 설명해 드리겠습니다.</SPAN>"+ " " + String.format(buttonPrefix, "영수증 OCR 자동에 대한 설명&", "영수증 OCR 자동에 대한 설명") + " " + String.format(buttonPrefix, "영수증 OCR 수동에 대한 설명&", "영수증 OCR 수동에 대한 설명");
			break;
		case "영수증 OCR 자동에 대한 설명&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>자동을 누르는 경우에 첨부된  영수증 사진의 사용한 총 금액이 결과값으로 나오게 됩니다.</SPAN>";
			break;
		case "영수증 OCR 수동에 대한 설명&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>수동의 경우에는 사진을 첨부하고, 화면 상의 사진에서 4개의 꼭짓점을 찍어서 투영변환을 하고, 숫자를 잘 읽을 수 있도록 사진을 잘라냅니다. 음영처리 이후에 영수증 사진의 총 금액이 결과 값으로 나오게 됩니다."
					+ "이 때 4개의 꼭짓점의 시작은 영수증의 정면에서 왼쪽 하단의 꼭짓점 부터 시계 방향으로 각 모서리를 찍으시면 됩니다!</SPAN>";
			break;
		case "커뮤니티&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>커뮤니티>> 커뮤니티에서 다른 유저들과 재미 있는 시간 보내세요 ^^~!</SPAN>";  
			break;
		case "살까말까&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>살까말까>> 거지방을 모티브로 해서 만들게 되었습니다~!</SPAN>";
			break;
		case "굿즈&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>긋즈>> 무엇을 도와드릴까요?</SPAN>"+ " " + String.format(buttonPrefix, "환불&", "환불") + " " + String.format(buttonPrefix, "상품문의&", "상품문의");
			break;
		case "환불&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>긋즈>> 고객센터로 문의 바랍니다~! https://pf.kakao.com/_xnCxfIG </SPAN>";
			break;	
		case "상품문의&":
			menu = "<SPAN style='color:#FFFFFF; background-color:#56CC9D;'>긋즈>> 고객센터로 문의 바랍니다~! https://pf.kakao.com/_xnCxfIG </SPAN>";
			break;
		default:
			menu = String.format(buttonPrefix, "고객센터&", "고객센터") + " " + String.format(buttonPrefix, "가계부&", "가계부") + " " + 
			       String.format(buttonPrefix, "커뮤니티&", "커뮤니티") + " " + String.format(buttonPrefix, "살까말까&", "살까말까") + " " +
			       String.format(buttonPrefix, "굿즈&", "굿즈");
			break;
		}
        
        if(menu !="") {
        	chatService.sendMessage(name, menu, channel);
        }
    }
    
    
}