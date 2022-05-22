package com.lyx.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @program:IntelliJ IDEA
 * @description: 业务主页面controller
 * @author: xmq
 * @create: 2022-05-17 22:19
 **/
@Controller
public class WorkBenchIndexController {
    @RequestMapping("/workbench/index.do")
    public String index(){
        return "workbench/index";
    }
}
