package com.kh.zipggu.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.entity.ReviewFileDto;
import com.kh.zipggu.repository.ReviewDao;
import com.kh.zipggu.repository.ReviewFileDao;
import com.kh.zipggu.service.ReviewService;
import com.kh.zipggu.vo.ReviewInsertVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ReviewFileDao reviewFileDao;
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/insert")
	public String insert() {
		
		return "review/insert";
	}
	
	//등록 기능
	@PostMapping("/insert")
	public String insert(@ModelAttribute ReviewInsertVO reviewInsertVO, HttpSession session) throws IllegalStateException, IOException {
		
		
		
		reviewService.insert(reviewInsertVO);
		
		return "redirect:/store/detail/"+reviewInsertVO.getItemNo();
		
	}	
	
	@GetMapping("/edit")
	public String edit() {
		
		return "review/edit";
	}
	
	//수정 기능
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewInsertVO reviewInsertVO) throws IllegalStateException, IOException {
//		log.debug("=================================={}", reviewInsertVO);
		reviewService.edit(reviewInsertVO);
		
		return "redirect:/store/detail/"+reviewInsertVO.getItemNo();
		
	}
	
	//리뷰 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int reviewNo, @RequestParam int itemNo) {
		
		reviewService.delete(reviewNo);
		
		return "redirect:/store/detail/"+itemNo;
	}
	
	//파일 출력 기능
	@GetMapping("/file")
	@ResponseBody // 이 메소드만큼은 뷰 리졸버를 쓰지 않겠다
	public ResponseEntity<ByteArrayResource> file(@RequestParam int reviewNo) throws IOException {

		//리뷰번호(reviewNo)로 리뷰 이미지 파일정보를 구한다.
		ReviewFileDto reviewFileDto = reviewFileDao.get(reviewNo);
//		log.debug("==================================11111111111111111111111111111111{}", reviewFileDto);
		//리뷰파일 번호(reviewFileNo)로 실제 파일 정보를 불러온다
		byte[] data = reviewFileDao.load(reviewFileDto.getReviewFileNo());
//		log.debug("==================================22222222222222222222222222222222{}", data);
		ByteArrayResource resource = new ByteArrayResource(data);

		String encodeName = URLEncoder.encode(reviewFileDto.getReviewFileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8").contentLength(reviewFileDto.getReviewFileSize())
				.body(resource);
	}
}
