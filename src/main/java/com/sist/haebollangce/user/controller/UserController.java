package com.sist.haebollangce.user.controller;

import com.sist.haebollangce.user.service.InterUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private InterUserService service;

    @GetMapping("/register")
    public String user(HttpServletRequest request) {
        String ctx = request.getContextPath();
        System.out.println("ctxpath => "+ctx);
        return "test";

    }
    @PostMapping("/register")
    public String submit(HttpServletRequest request) {
        String userid = request.getParameter("userid");
        System.out.println("Controller : "+userid);
        int n = service.submit(userid);
        return "test";
    }

//    @GetMapping("/detail")
//    public String findById(@PathVariable("id") String id, HttpServletRequest request) {
//        String pw = service.findById(id);
//        request.setAttribute("pw", pw);
//        return "detail";
//    }


    @GetMapping("/tiles-test")
    public ModelAndView tiles(ModelAndView mav) {

        mav.setViewName("tiles_test_1.tiles1");
        return mav;
    }
}
