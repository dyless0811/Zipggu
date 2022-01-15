package com.kh.zipggu.vo;

import org.springframework.web.socket.WebSocketSession;
import lombok.Data;

@Data
public class UserVO {
	
	private Integer userNo;
	private String userNick;
	private WebSocketSession session;

}
