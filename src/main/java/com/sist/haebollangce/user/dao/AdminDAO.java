package com.sist.haebollangce.user.dao;

import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.user.dto.ReportDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@RequiredArgsConstructor
@Repository
public class AdminDAO implements InterAdminDAO {

    private final InterMapper mapper;


    @Override
    public List<ReportDTO> getReports() { return mapper.getReports(); }

    @Override
    public void delete(String dels) { mapper.deleteReports(dels); }
}
