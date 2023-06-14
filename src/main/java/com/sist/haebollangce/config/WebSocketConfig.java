package com.sist.haebollangce.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.sist.haebollangce.messenger.controller.WebsocketEchoHandler;

@Configuration
@EnableWebSocket
@Component
public class WebSocketConfig implements WebSocketConfigurer {

    // WebsocketEchoHandler 인스턴스를 반환하는 메서드를 작성해야 합니다.
    // 해당 WebsocketEchoHandler는 실제 WebSocket 요청을 처리하는 로직을 구현해야 합니다.
    private final WebsocketEchoHandler WebSocketHandler() {
        // WebSocket 요청을 처리하는 커스텀 WebSocketHandler 인스턴스를 생성하여 반환합니다.
        return new WebsocketEchoHandler();
    }
    
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(WebSocketHandler(), "/messengerView");
    }

}