package com.sist.haebollangce.user.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReportDTO {

    private String reportNo;
    private String certifyNo;
    private String reportContent;
    private String certifyImg;
}
