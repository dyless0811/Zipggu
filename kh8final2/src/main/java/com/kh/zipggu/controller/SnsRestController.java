package com.kh.zipggu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.repository.SnsDao;
import com.kh.zipggu.repository.SnsLikeDao;
import com.kh.zipggu.service.SnsService;
import com.kh.zipggu.vo.SnsListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/sns/data")
public class SnsRestController {
	
	@Autowired
	private SnsService snsService;
	
	@Autowired
	private SnsLikeDao snsLikeDao;
	
	@Autowired
	private SnsDao snsDao;
	
	//목록 페이지
	@GetMapping("/list")
	public List<SnsListVO> snsList(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "18") int size,
			@RequestParam(required = false, defaultValue = "sns_no") String column) {
		
		
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		Map<String, Object> param = new HashMap<>();
		param.put("endRow", endRow);
		param.put("startRow", startRow);
		param.put("column", column);
		
		log.debug("------------------------------{}" + param);
				
		return snsService.listByPage(param);
	}
	
	//팔로우 한 사람들의 글
	//목록 페이지
	@GetMapping("/follower")
	public List<SnsListVO> followList(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "18") int size,
			@RequestParam int loginNo) {
		
		
		
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		Map<String, Object> param = new HashMap<>();
		param.put("endRow", endRow);
		param.put("startRow", startRow);
		param.put("loginNo", loginNo);
		
		log.debug("------------------------------{}" + param);
				
		return snsService.followerList(param);
	}
	
	//회원이 팔로우 한 사람들의 글
	//목록 페이지
	@GetMapping("/userFollow")
	public List<SnsListVO> userFollowList(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "18") int size,
			@RequestParam int memberNo) {
		
		
		
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		Map<String, Object> param = new HashMap<>();
		param.put("endRow", endRow);
		param.put("startRow", startRow);
		param.put("memberNo", memberNo);
		
		log.debug("------------------------------{}" + param);
				
		return snsService.userFollowList(param);
	}	
	
	//좋아요 등록 기능
	@GetMapping("/like")
	public void insert(@RequestParam int snsNo, HttpSession session) {
		
		int memberNo = (int)session.getAttribute("loginNo");
	
			
		snsLikeDao.insert(snsNo, memberNo);

	}
	
	//좋아요 삭제 기능
	@DeleteMapping("/delete")
	public void delete(@RequestParam int snsNo, HttpSession session) {
		
		int memberNo = (int)session.getAttribute("loginNo");
		
		snsLikeDao.delete(snsNo, memberNo);
		
	}
	
	//팔로우 한 사람들의 글
		//목록 페이지
		@GetMapping("/mylist")
		public List<SnsDto> myList(@RequestParam(required = false, defaultValue = "1") int page,
				@RequestParam(required = false, defaultValue = "10") int size,
				@RequestParam int pageMember) {
			
			
			
			int endRow = page * size;
			int startRow = endRow - (size - 1);
			
			Map<String, Object> param = new HashMap<>();
			param.put("endRow", endRow);
			param.put("startRow", startRow);
			param.put("pageMember", pageMember);
			
			log.debug("------------------------------{}" + param);
					
			return snsDao.myList(param);
		}
		
		//목록 페이지(내가 좋아요한 게시글 목록)
		@GetMapping("/myLikeList")
		public List<SnsListVO> snsList(@RequestParam(required = false, defaultValue = "1") int page,
				@RequestParam(required = false, defaultValue = "18") int size,
				@RequestParam int memberNo) {
			
			
			int endRow = page * size;
			int startRow = endRow - (size - 1);
			
			Map<String, Object> param = new HashMap<>();
			param.put("endRow", endRow);
			param.put("startRow", startRow);
			param.put("memberNo", memberNo);
			
			log.debug("------------------------------111111111111111111111111111111111111111111111111111{}" + param);
					
			return snsService.myLikeList(param);
		}
}
