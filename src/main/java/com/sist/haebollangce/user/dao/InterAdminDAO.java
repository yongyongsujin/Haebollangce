package com.sist.haebollangce.user.dao;

import com.sist.haebollangce.user.dto.ReportDTO;

import java.util.List;

public interface InterAdminDAO {

    public List<ReportDTO> getReports();

    void delete(String dels);
}
