package com.multi.moneybug.chat;

import com.google.firebase.FirebaseApp;
import com.google.firebase.database.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Service
public class ChatService {

    @Autowired
    private FirebaseApp firebaseApp;

    public void sendMessage(String name, String text, String channel) {
        FirebaseDatabase database = FirebaseDatabase.getInstance(firebaseApp);
        DatabaseReference chatRef = database.getReference("Voicechat/" + channel);
        String timestamp = getCurrentTimestamp();

        ChatMessage newMessage = new ChatMessage(name, text, timestamp);

        chatRef.push().setValueAsync(newMessage);
    }

    public List<ChatMessage> getAllMessages(String channel) {
        FirebaseDatabase database = FirebaseDatabase.getInstance(firebaseApp);
        DatabaseReference chatRef = database.getReference("Voicechat/" + channel);

        CompletableFuture<List<ChatMessage>> completableFuture = new CompletableFuture<>();
        List<ChatMessage> messages = new ArrayList<>();

        chatRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot messageSnapshot : dataSnapshot.getChildren()) {
                    String name = messageSnapshot.child("name").getValue(String.class);
                    String text = messageSnapshot.child("text").getValue(String.class);
                    String timestamp = messageSnapshot.child("timestamp").getValue(String.class);

                    ChatMessage message = new ChatMessage(name, text, timestamp);
                    messages.add(message);
                }
                completableFuture.complete(messages);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                completableFuture.completeExceptionally(databaseError.toException());
            }
        });

        try {
            return completableFuture.get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    private String getCurrentTimestamp() {
    	 SimpleDateFormat dateFormat = new SimpleDateFormat("a hh시 mm분");
         return dateFormat.format(new Date());
    }
}
