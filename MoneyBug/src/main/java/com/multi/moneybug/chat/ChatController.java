package com.multi.moneybug.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import java.util.List;
import java.util.concurrent.ExecutionException;

@Controller
public class ChatController {
    @Autowired
    private ChatService chatService;

    
    @GetMapping("/chat")
    @ResponseBody
    public List<ChatMessage> showChatPage() throws InterruptedException, ExecutionException {
        List<ChatMessage> messages = chatService.getAllMessages();

        return messages;
    }

    @PostMapping("/send")
    public String sendMessage(@RequestParam String name, @RequestParam String text) {
    	
        chatService.sendMessage(name, text);
        
        chatBot(name,text);
        
	
        
        
        return "redirect:/chat"; // 채팅 페이지로 리다이렉트
    }
    
    public void chatBot(String name, String text) {
    	
        String menu = "";
        name = "챗봇";
        switch (text) {
		case "챗봇 시작":
			menu = "1)자주찾는질문 2)고객센터 3)태그 게시판 4)살까말까 5)가계부";
			break;
		case "1":
			menu = "자주찾는 질문>> ";
			break;
		case "2":
			menu = "고객센터>> https://pf.kakao.com/_xnCxfIG";
			break;
		case "3":
			menu = "태그 게시판>> ";
			break;
		case "4":
			menu = "살까말까>> ";
			break;
		case "5":
			menu = "가계부>> ";
			break;
		default:
			break;
		}
        
        if(menu !="") {
        chatService.sendMessage(name, menu);
        }
    }
    
    
}