package com.sist.haebollangce.user.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.sist.haebollangce.user.dto.ReportDTO;
import com.sist.haebollangce.user.service.InterAdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final InterAdminService adminService;

    @GetMapping("/report")
    public String getReports() {
        return "admin.tiles1";
    }

    @RequestMapping(value="/report-load", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String deleteReports(@RequestBody String dels) {
//        System.out.println(dels);
//        String temp = dels.substring(4);
//        temp = temp.replaceAll("%2C", ",");
//        System.out.println(temp);
//        adminService.delete(temp);

        JsonObject json = new JsonObject();
        json.addProperty("result", "success");

        return new Gson().toJson(json);
    }

    @GetMapping("/report-load")
    @ResponseBody
    public String loadReports() throws JsonProcessingException {

        List<ReportDTO> reports = adminService.getReports();

        ObjectMapper mapper = new ObjectMapper();

        return mapper.writeValueAsString(reports);
    }
}
