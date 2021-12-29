package com.kh.zipggu.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.entity.SnsFileDto;
import com.kh.zipggu.repository.SnsDao;
import com.kh.zipggu.repository.SnsFileDao;
import com.kh.zipggu.service.SnsService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/sns")
public class SnsController {
	
	@Autowired
	private SnsDao snsDao;
	
	@Autowired
	private SnsFileDao snsFileDao;
	
	@Autowired
	private SnsService snsService;
	
	//게시글 목록 페이지
	@RequestMapping("")
	public String sns() {
		
		//model로 뿌려주기
//		model.addAttribute("list", snsDao.list());
		
		return "sns/main";
	}
	
	@GetMapping("/write")
	public String write() {
		
		//sns 글쓰기 페이지 이동
		return "sns/write";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute SnsDto snsDto, @RequestParam List<MultipartFile>attach, HttpSession session) throws IllegalStateException, IOException {
		

		//세션에서 회원의 번호를 받아 snsDto에 저장
		snsDto.setMemberNo((int)session.getAttribute("loginNo"));
		
		
		//서비스에서 등록이 완료되면 인트로 반환되기때문에 int에 변수저장
		//상세페이지로 가기 위해서는 service에서 int값을 반환 받아야 한다.
		int snsNo = snsService.write(snsDto, attach);
		
		//글 등록 후 sns게시글 상세페이지로 이동
		return "redirect:detail?snsNo="+snsNo;
	}
	
	//게시글 상세 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int snsNo, HttpSession session, Model model) {
		
		log.debug("snsNo = {}", snsNo);
		//파라미터로 넘어온 번호를 받아 번호에 해당하는 게시글 상세 조회
		SnsDto snsDto = snsDao.get(snsNo);
		//게시글에 들어있는 첨부파일 리스트 불러오기
		List<SnsFileDto> list = snsFileDao.list(snsNo);
		
		//model로 페이지에 넘겨준다
		model.addAttribute("snsDto", snsDto);
		model.addAttribute("memberNick", (String)session.getAttribute("loginNick"));
		model.addAttribute("fileList", list);
		
		
		return "sns/detail";
		
	}
	
	//게시글 수정 페이지
	@GetMapping("/edit")
	public String edit(@RequestParam int snsNo, Model model) {
		
		//수정 페이지에서 작성한 내용을 보여주기 위해 넘어온 게시글 번호로 단일조회
		model.addAttribute("snsDto", snsDao.get(snsNo));
				
		return "sns/edit";
		
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute SnsDto snsDto, 
					@RequestParam List<MultipartFile>attach) throws IllegalStateException, IOException {
		
		//파일이 변경될 수 있으니 같이 수정처리 해준다
		snsService.edit(snsDto, attach);
		return "redirect:detail?snsNo="+snsDto.getSnsNo();
	}
	
	//게시글 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int snsNo) {
		
		snsService.delete(snsNo);
		
		return "redirect:/sns";
	}
	
	//목록 페이지 썸네일을 위한 다운로드 기능
	@GetMapping("/thumnail")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> thumnail(@RequestParam int snsNo) throws IOException{
		
		//sns번호(SnsNo)로 파일정보 구하기
		SnsFileDto snsFileDto = snsFileDao.getThumnail(snsNo);
		
		//sns번호(SnsNo)로 실제 파일 정보를 불러온다
		byte[] data = snsFileDao.load(snsFileDto.getSnsFileNo());
		ByteArrayResource resource = new ByteArrayResource(data); 
		
		String encodeName = URLEncoder.encode(snsFileDto.getSnsFileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
						.header("content-Encoding", "UTF-8")
						.contentLength(snsFileDto.getSnsFileSize())
						.body(resource);
	}
	
	@GetMapping("/file")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@RequestParam int snsFileNo) throws IOException{
		
		//sns번호(SnsNo)로 파일정보 구하기
		SnsFileDto snsFileDto = snsFileDao.get(snsFileNo);
		
		//sns번호(SnsNo)로 실제 파일 정보를 불러온다
		byte[] data = snsFileDao.load(snsFileNo);
		ByteArrayResource resource = new ByteArrayResource(data); 
		
		String encodeName = URLEncoder.encode(snsFileDto.getSnsFileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
						.header("content-Encoding", "UTF-8")
						.contentLength(snsFileDto.getSnsFileSize())
						.body(resource);
	}
	
}
