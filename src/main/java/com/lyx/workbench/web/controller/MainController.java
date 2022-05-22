package com.lyx.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @program:IntelliJ IDEA
 * @description: 工作区
 * @author: xmq
 * @create: 2022-05-20 20:43
 **/
@Controller
public class MainController {
    @RequestMapping("/workbench/main/index.do")
    public String index(){
        return "workbench/main/index";
    }
}
