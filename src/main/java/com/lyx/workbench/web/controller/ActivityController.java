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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @RequestMapping("/workbench/activity/search.do")
    public @ResponseBody Object search(String name,String owner,String startDate,String endDate,
                                       Integer pageNo,Integer pageSize){
        Map<String,Object> map = new HashMap<>();
        map.put("activity_name",name);
        map.put("activity_owner",owner);
        map.put("activity_start_date",startDate);
        map.put("activity_end_date",endDate);
        map.put("pageNo",pageNo-1);
        map.put("pageSize",pageSize);
        List<Activity> activities = activityService.queryActivityByConditionForPage(map);
        int totalRows = activityService.queryCountOfActivityByCondition(map);
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("activities",activities);
        resultMap.put("totalRows",totalRows);
        return resultMap;
    }

    @RequestMapping("/workbench/activity/delete.do")
    public @ResponseBody Object delete(String[] id){
        ReturnObject object = new ReturnObject();
        try {
            int i = activityService.deleteActivityByIds(id);
            if(i>0){
                object.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                object.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                object.setMessage("系统忙，请稍后重试....");
            }
        } catch (Exception e) {
            object.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            object.setMessage("系统忙，请稍后重试....");
        }
        return object;
    }

    @RequestMapping("/workbench/activity/selectActivityById.do")
    public @ResponseBody Object selectActivityById(String id){
        Activity activity = activityService.selectActivityById(id);
        return activity;
    }
}
