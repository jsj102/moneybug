package com.multi.moneybug;

import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.multi.moneybug.accountBook.AccountOCRService;
import com.multi.moneybug.tagBoard.TagBoardController;
import com.multi.moneybug.tagBoard.TagBoardService;
import com.multi.moneybug.tagReply.TagReplyService;

@Configuration
public class AppConfig {

    @Bean(name = "multipartResolver")
    @Profile("profile1")
    public CommonsMultipartResolver multipartResolver() {
        return new CommonsMultipartResolver();
    }

    @Bean(name = "multipartEntityBuilder")
    @Profile("multiPartBuilder")
    public MultipartEntityBuilder multipartEntityBuilder() {
        return MultipartEntityBuilder.create();
    }

    @Bean
    public AccountOCRService accountOCRService() {
        return new AccountOCRService();
    }

    @Bean
    public TagBoardController tagBoardController(TagBoardService tagBoardService, TagReplyService tagReplyService) {
        return new TagBoardController(tagBoardService, tagReplyService);
    }
}
