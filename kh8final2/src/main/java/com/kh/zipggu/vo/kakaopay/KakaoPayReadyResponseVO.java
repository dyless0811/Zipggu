package com.kh.zipggu.vo.kakaopay;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class KakaoPayReadyResponseVO {
	String tid;
	String next_redirect_pc_url;
	String created_at;
}
