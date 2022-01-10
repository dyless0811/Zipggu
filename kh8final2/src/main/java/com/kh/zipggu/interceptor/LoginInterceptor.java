package com.kh.zipggu.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 세션에서 회원아이디 꺼내기
		String loginEmail = (String) request.getSession().getAttribute("loginEmail");

		boolean login = loginEmail != null;

		if (login) {
			
			response.sendRedirect(request.getContextPath() + "/");
			return false;

		} else {

			return true;
		}

	}
}