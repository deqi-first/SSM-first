package com.lyx.settings.web.controller;


import com.lyx.commons.contants.Contants;
import com.lyx.commons.domain.ReturnObject;
import com.lyx.settings.domain.User;
import com.lyx.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login.do")
    public @ResponseBody Object login(String loginAct, String loginPwd, String isRemPwd, HttpServletResponse response, HttpServletRequest request) {
        //封装参数
        Map<String, Object> map = new HashMap<>();
        map.put("LoginAct", loginAct);
        map.put("LoginPwd", loginPwd);
        //调用service层方法
        User user = userService.queryUserByLoginActAndPwd(map);
        ReturnObject returnObject = new ReturnObject();
        if (user == null) {
            //登录失败，用户名或密码错误
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("用户名或密码错误");
        } else {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = simpleDateFormat.format(new Date());
            if (format.compareTo(user.getuExpireTime()) > 0) {
                //登录失败，账号已经过期了
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("账号已过期");
            } else if ("0".equals(user.getuLockState())) {
                //登录失败，状态被锁定
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("状态被锁定");
            } else if(!user.getuAllowIps().contains(request.getRemoteAddr())){
                //判断当前用户的ip地址是不是包含在数据库表里的u_allow_ips
               //不包含，登录失败，ip受限制
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("ip受限制");
            }else{
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
                //把user保存到session作用域中
                HttpSession session = request.getSession();
                session.setAttribute(Contants.SESSION_USER,user);
                //
                if("true".equals(isRemPwd)){
                    Cookie cookie = new Cookie("loginAct", loginAct);
                    cookie.setMaxAge(10*24*60*60);
                    response.addCookie(cookie);
                    Cookie cookie2 = new Cookie("loginPwd", loginPwd);
                    cookie2.setMaxAge(10*24*60*60);
                    response.addCookie(cookie2);
                }else {
                    Cookie cookie3 = new Cookie("loginAct", "1");
                    cookie3.setMaxAge(0);
                    response.addCookie(cookie3);
                    Cookie cookie4 = new Cookie("loginPwd", "0");
                    cookie4.setMaxAge(0);
                    response.addCookie(cookie4);
                }
            }
        }
        return returnObject;
    }

    @RequestMapping("/settings/qx/user/logout.do")
    public String logout(HttpServletResponse response,HttpSession session){
        //清空cookie
        Cookie cookie3 = new Cookie("loginAct", "1");
        cookie3.setMaxAge(0);
        response.addCookie(cookie3);
        Cookie cookie4 = new Cookie("loginPwd", "1");
        cookie4.setMaxAge(0);
        response.addCookie(cookie4);
        session.invalidate();//销毁所有session
        return "redirect:/";
    }
}
