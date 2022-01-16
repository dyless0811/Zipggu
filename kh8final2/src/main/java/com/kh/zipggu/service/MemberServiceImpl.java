package com.kh.zipggu.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.MemberProfileDao;
import com.kh.zipggu.vo.JoinChartVO;
import com.kh.zipggu.vo.MemberJoinVO;
import com.kh.zipggu.vo.MemberListVO;
import com.kh.zipggu.vo.MemberPageVO;
import com.kh.zipggu.vo.MemberUploadVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberProfileDao memberProfileDao;

	@Autowired
	private SqlSession sqlSession;

	// 저장 폴더
	private File directory = new File("D:/upload/kh8b/member");

	@Override
	public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {

		int sequence = sqlSession.selectOne("member.seq");

		log.debug("sequence = {}", sequence);

		MemberDto memberDto = new MemberDto();
		memberDto.setMemberNo(sequence);
		memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
		memberDto.setMemberPw(memberJoinVO.getMemberPw());
		memberDto.setMemberNickname(memberJoinVO.getMemberNickname());

		memberDao.join(memberDto);

//		MultipartFile multipartFile = memberJoinVO.getAttach();
//		if (!multipartFile.isEmpty()) {// 파일이 있으면
//			MemberProfileDto memberProfileDto = new MemberProfileDto();
//			memberProfileDto.setMemberNo(sequence);
//			memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
//			memberProfileDto.setMemberProfileType(multipartFile.getContentType());
//			memberProfileDto.setMemberProfileSize(multipartFile.getSize());
//			memberProfileDao.save(memberProfileDto, multipartFile);
//		}
	}


	@Override
	public void edit(MemberDto memberDto, MultipartFile attach) throws IllegalStateException, IOException {
		//검사값 false를 변수에 담고
		boolean check = false;
		//파일이 있는지 없는 체크
		
		MultipartFile multipartFile = attach;
			//만약 파일이 비어있지 않다면
			if(!multipartFile.isEmpty()) {
				check = true;
		}
		
		//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가
				if(check) {
					//해당 번호에 파일 업로드 되어 있는지 확인한다
					
					MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberDto.getMemberNo());
					
					if(memberProfileDto != null) {
						//파일이 있다면 삭제
							File target = new File(directory, String.valueOf(memberProfileDto.getMemberProfileSavename()));
							target.delete();
							//db에서도 파일 삭제
							memberProfileDao.delete(memberDto.getMemberNo());
						}
					}

						if(!multipartFile.isEmpty()) {
							
							//등록페이지에서 넘어오는 정보만 snsFileDto 객체에 정보 담아Dao로 보내기
							//(여기서는 정보만 담아 보낸다)
								MemberProfileDto memberProfileDto = new MemberProfileDto();
								memberProfileDto.setMemberNo(memberDto.getMemberNo());
								memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
								memberProfileDto.setMemberProfileType(multipartFile.getContentType());
								memberProfileDto.setMemberProfileSize(multipartFile.getSize());
								memberProfileDao.save(memberProfileDto, multipartFile);
							}
						memberDao.edit(memberDto);
					}
		

	
	@Override
	public void upload(MemberUploadVO memberUploadVO, int memberNo) throws IllegalStateException, IOException {

		MultipartFile multipartFile = memberUploadVO.getAttach();
		if (!multipartFile.isEmpty()) {// 파일이 있으면
			MemberProfileDto memberProfileDto = new MemberProfileDto();
			memberProfileDto.setMemberNo(memberNo);
			memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
			memberProfileDto.setMemberProfileType(multipartFile.getContentType());
			memberProfileDto.setMemberProfileSize(multipartFile.getSize());
			memberProfileDao.save(memberProfileDto, multipartFile);
		}
	}

	
	@Override
	public List<MemberListVO> VOlist(MemberListVO memberListVO) throws Exception {
		return memberDao.VOlist(memberListVO);
	}


	@Override
	public MemberPageVO memberPage(MemberPageVO memberPageVO) throws Exception {
		int count = memberDao.count(memberPageVO.getColumn(),memberPageVO.getKeyword());
		memberPageVO.setCount(count);
		memberPageVO.calculate();
		List<MemberDto> list = memberDao.search(memberPageVO.getColumn(), memberPageVO.getKeyword(),memberPageVO.getBegin(),memberPageVO.getEnd());
		memberPageVO.setList(list);
		return memberPageVO;
	}

	@Override
	public int emailConfirm(String memberEmail) {
	        return memberDao.emailConfirm(memberEmail);
	}	

	@Override
	public int nickConfirm(String memberNickname) {
	        return memberDao.nickConfirm(memberNickname);
	}
	
	@Override
	public List<JoinChartVO> joinChartVO(JoinChartVO joinChartVO) {
		return memberDao.joinChartVO(joinChartVO);
	}
}
