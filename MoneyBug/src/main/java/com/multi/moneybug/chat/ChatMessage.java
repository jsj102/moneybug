package com.multi.moneybug.chat;

import lombok.Data;

@Data
public class ChatMessage {
    private String name;
    private String text;
    private String timestamp;

    public ChatMessage(String name, String text, String timestamp) {
        this.name = name;
        this.text = text;
        this.timestamp = timestamp;
    }
}
