package com.kh.zipggu;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.naver.NaverLoginBO;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.vo.CategoryVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
		})
@WebAppConfiguration
@Slf4j
public class Test01 {
	
	@Autowired
	private SqlSession sqlSession;
	
	//@Test
	public void test() {
		List<CategoryDto> list = sqlSession.selectList("category.list");
		for(CategoryDto categoryDto : list) {
			System.out.println(categoryDto);
		}
	}
	
	//@Test
	public void test2() {
		List<CategoryVO> list = sqlSession.selectList("category.listSuper");
		for(CategoryVO categoryVO : list) {
			categoryVO.setList(sqlSession.selectList("category.listSub", categoryVO.getCategoryNo()));
		}
		System.out.println(list);
	}
	
	//@Test
	public void test3() {
		List<CategoryVO> list = sqlSession.selectList("category.listCustom");
		System.out.println(list);
	}

	
	//@Test
	public void test4() {
		List<CategoryVO> list = sqlSession.selectList("category.listCustom2");
		System.out.println(list);
	}
	@Autowired
	private CategoryService adminService;
	
	//@Test
	public void test5() {
		adminService.add("행거", 22);
	}
	
	
	//@Test
	public void testCart()	{
		System.out.println(sqlSession.selectList("cart.cartCustom", 1));
	}
	
	@Value("${kakaopay.authorization}")
	private String authorization;
	
	@Value("${kakaopay.contentType}")
	private String contentType;
	
	@Autowired
	private NaverLoginBO naverLoginBo;
	
	
	@Value("${naver.clientId}")
    private String CLIENT_ID;
	@Value("${naver.clientSecret}")
    private String CLIENT_SECRET;
	@Value("${naver.redirectURI}")
    private String REDIRECT_URI;
	@Value("${naver.sessionState}")
	private String SESSION_STATE;
	/* 프로필 조회 API URL */
	@Value("${naver.profileAPIURL}")
	private String PROFILE_API_URL;
	
	@Test
	public void testProperties() {
		System.out.println("======================================");
		System.out.println(CLIENT_ID);
		System.out.println(CLIENT_SECRET);
		System.out.println(REDIRECT_URI);
		System.out.println(SESSION_STATE);
		System.out.println(PROFILE_API_URL);
		
		System.out.println(authorization);
		System.out.println(contentType);
		
		System.out.println("======================================");
	}
	
}

