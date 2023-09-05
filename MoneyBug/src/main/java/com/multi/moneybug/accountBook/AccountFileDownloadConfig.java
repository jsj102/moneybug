package com.multi.moneybug.accountBook;

import java.util.concurrent.Executor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@Configuration
@EnableAsync
public class AccountFileDownloadConfig {
    private int CORE_POOL_SIZE = 10;
    private int MAX_POOL_SIZE = 50;
    private int QUEUE_CAPACITY = 100_000;

    @Bean(name = "pdfThreadBean")
    public Executor threadPoolTaskExecutor(){

        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();

        taskExecutor.setCorePoolSize(CORE_POOL_SIZE);
        taskExecutor.setMaxPoolSize(MAX_POOL_SIZE);
        taskExecutor.setQueueCapacity(QUEUE_CAPACITY);
        taskExecutor.setThreadNamePrefix("Executor-");

        return taskExecutor;
    }
}
