package com.kh.zipggu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.SnsReplyDto;
import com.kh.zipggu.repository.SnsReplyDao;
import com.kh.zipggu.service.SnsReplyService;
import com.kh.zipggu.vo.SnsReplyListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/snsReply")
public class SnsReplyRestController {
	
	@Autowired
	private SnsReplyDao snsReplyDao;
	
	@Autowired
	private SnsReplyService snsReplyService;
	
	//댓글 등록 기능
	@PostMapping("/insert")
	public void insert(@ModelAttribute SnsReplyDto snsReplyDto, HttpSession session, @RequestParam int snsNo) {
		
		if(snsReplyDto.getSnsReplySuperno() > 0) {
			snsReplyDto.setSnsNo(snsNo);
			snsReplyDto.setMemberNo((int)session.getAttribute("loginNo"));
			
			snsReplyDao.insert(snsReplyDto);
		}
		else {
			snsReplyDto.setSnsNo(snsNo);
			snsReplyDto.setMemberNo((int)session.getAttribute("loginNo"));
			
			//댓글 등록
			snsReplyDao.insert(snsReplyDto);
			
			
		}

		//댓글 등록을 마치고 댓글 개수 갱신
		snsReplyDao.replyCount(snsNo);
	}
	
	//댓글 목록 기능
	@GetMapping("/list")
	public List<SnsReplyListVO> list(
				@RequestParam(required = false, defaultValue = "1") int page,
				@RequestParam(required = false, defaultValue = "10") int size,
				@RequestParam int snsNo){
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		System.out.println("snsNo = " + snsNo);

		
		return snsReplyService.listByPage(startRow, endRow, snsNo);
	}
	
	//댓글 삭제 기능
	@DeleteMapping("/delete")
	public void delete(@RequestParam int snsReplyNo,@RequestParam int snsNo) {
		
		snsReplyDao.delete(snsReplyNo);
		
		//댓글 삭제 하고 댓글 개수 갱신
		snsReplyDao.replyCount(snsNo);
		
	}
	
	//댓글 수정
	@PostMapping("/edit")
	public void edit(@ModelAttribute SnsReplyDto snsReplyDto) {
		
		
		snsReplyDao.edit(snsReplyDto);
		
		
	}
	
	
	
}
