package com.multi.moneybug.chat;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

@Configuration
public class FirebaseAppConfig {

	@Value("#{key['firebase.db']}")
    private String databaseUrl;

    @Value("#{key['api.firebase']}")
    private String firebaseProperties;

    @Bean
    public FirebaseApp initializeFirebase() {
        try {
            InputStream serviceAccount = new ByteArrayInputStream(firebaseProperties.getBytes());
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl(databaseUrl)
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return FirebaseApp.getInstance();
    }
}
