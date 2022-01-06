package com.kh.zipggu.vo.kakaopay;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SelectedCardInfo {
	private String card_bin;
	private int install_month;
	private String card_corp_name;
	private String interest_free_install;
}
