package com.lyx.settings.web.controller;

import com.lyx.settings.domain.User;
import com.lyx.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @program:IntelliJ IDEA
 * @description:
 * @author: xmq
 * @create: 2022-05-21 18:13
 **/
@Controller
public class ActivityController {

    @Autowired
    private UserService userService;
    @RequestMapping("/workbench/activity/toIndex.do")
    public String toIndex(HttpServletRequest request){
        List<User> users = userService.queryAllUsers();
        request.setAttribute("users",users);
        return "workbench/activity/index";
    }
}
