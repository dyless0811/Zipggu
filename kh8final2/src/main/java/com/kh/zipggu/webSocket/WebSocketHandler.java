package com.kh.zipggu.webSocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.zipggu.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {

	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();

	// 서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		int userNo = (int) session.getAttributes().get("loginNo");
		String userNick = (String) session.getAttributes().get("loginNick");

		UserVO user = new UserVO();

		user.setUserNo(userNo);
		user.setUserNick(userNick);
		user.setSession(session);

		sessions.add(session);

		log.debug("-------현재총입장-----session---------{}", session);// 현재 접속한 사람

//		userSessionsMap.put(userNo, session);
		userSessionsMap.put(userNick, session);

		log.debug("-----sessions-------{}", sessions);
		log.debug("-----user-------{}", user);
		log.debug("-----userSessionsMap-------{}", userSessionsMap);

	}

	// 소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		String msg = message.getPayload();
		log.debug("-----메시지성공-------{}", message.getPayload());

		
		if (msg != null) {
			
			String[] strs = msg.split(",");
			log.debug("-----strs-------{}", strs.toString());

			if (strs != null && strs.length == 3) {
				String me = strs[0];
				String you = strs[1];
				String resp = strs[2];
				
				// 작성자가 로그인 해서 있다면
				WebSocketSession boardWriterSession = userSessionsMap.get(you);
					
				log.debug("-----resp-----{}", resp);
			
				if (boardWriterSession != null && resp.equals("팔로우성공") ) {
					TextMessage tmpMsg = new TextMessage(me + "님이 " + you + "님을 팔로우 했습니다.");
					boardWriterSession.sendMessage(tmpMsg);
					log.debug("-----boardWriterSession-----{}", tmpMsg);
				}
				else if (boardWriterSession != null && resp.equals("언팔로우성공")) {
					TextMessage tmpMsg = new TextMessage(me + "님이 " + you + "님을 팔로우 취소했습니다.");
					boardWriterSession.sendMessage(tmpMsg);
					log.debug("-----boardWriterSession-----{}", tmpMsg);
				}
				

			}
		}
	}


	// 연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderNick = getMemberNick(session);
		if(senderNick!=null) {	// 로그인 값이 있는 경우만
			
			log.debug( "----------연결 종료됨--------{}",senderNick);

		
		userSessionsMap.remove(senderNick);

		sessions.remove(session);
	}
	}

//	 웹소켓 nick 가져오기
	private String getMemberNick(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String m_nick = (String) httpSession.get("loginNick");
		
		return m_nick==null? null: m_nick;

	}
	
}
