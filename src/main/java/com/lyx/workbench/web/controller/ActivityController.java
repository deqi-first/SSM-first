package com.lyx.workbench.web.controller;

import com.lyx.commons.contants.Contants;
import com.lyx.commons.domain.ReturnObject;
import com.lyx.commons.utils.DateUtils;
import com.lyx.commons.utils.UUIDUtils;
import com.lyx.settings.domain.User;
import com.lyx.settings.service.UserService;
import com.lyx.workbench.domain.Activity;
import com.lyx.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
    @Autowired
    private ActivityService activityService;

    @RequestMapping("/workbench/activity/toIndex.do")
    public String toIndex(HttpServletRequest request) {
        List<User> users = userService.queryAllUsers();
        request.setAttribute("users", users);
        return "workbench/activity/index";
    }

    @RequestMapping("/workbench/activity/save.do")
    public @ResponseBody Object save(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        activity.setActivityId(UUIDUtils.getUUID());
        activity.setActivityCreateBy(user.getUserId());
        activity.setActivityCreateTime(DateUtils.getDate());
        int i = 0;
        ReturnObject returnObject = new ReturnObject();
        try {
            i = activityService.saveActivity(activity);
            if(i==1){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试...");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试...");
        }
        return returnObject;
    }
}
