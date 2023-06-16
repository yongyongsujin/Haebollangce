package com.sist.haebollangce.user.service;

import com.sist.haebollangce.user.dto.ReportDTO;
import com.sist.haebollangce.user.dto.TokenDTO;
import com.sist.haebollangce.user.dto.UserDTO;

import java.util.List;

public interface InterAdminService {

    public List<ReportDTO> getReports();

    void delete(String dels);
}
