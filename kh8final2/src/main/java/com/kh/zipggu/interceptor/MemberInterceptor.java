package com.kh.zipggu.interceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MemberInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션에서 회원아이디 꺼내기
		String loginEmail=(String)request.getSession().getAttribute("loginEmail");
	
		boolean login = loginEmail != null;
		
		if(login) {
			
			return true;
			
		}else {

			response.sendRedirect(request.getContextPath()+"/member/login");
			
			return false;
		}
	
	}
}