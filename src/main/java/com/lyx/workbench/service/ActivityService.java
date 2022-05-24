package com.lyx.workbench.service;

import com.lyx.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    int saveActivity(Activity activity);

    //条件查询市场活动，分页查询，
    List<Activity> queryActivityByConditionForPage(Map<String, Object> map);

    //条件查询市场活动的数量
    int queryCountOfActivityByCondition(Map<String, Object> map);
}
