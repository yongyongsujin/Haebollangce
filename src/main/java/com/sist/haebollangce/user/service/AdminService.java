package com.sist.haebollangce.user.service;

import com.sist.haebollangce.user.dao.InterAdminDAO;
import com.sist.haebollangce.user.dto.ReportDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AdminService implements InterAdminService {

    private final InterAdminDAO adminDAO;
    @Override
    public List<ReportDTO> getReports() { return adminDAO.getReports(); }

    @Override
    public void delete(String dels) { adminDAO.delete(dels); }
}
