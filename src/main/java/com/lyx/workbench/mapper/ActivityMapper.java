package com.lyx.workbench.mapper;

import com.lyx.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityMapper {
    int deleteByPrimaryKey(String activityId);

    int insertSelective(Activity record);

    Activity selectByPrimaryKey(String activityId);

    int updateByPrimaryKeySelective(Activity record);

    int updateByPrimaryKey(Activity record);

    /*
     * 保存创建市场活动*/
    int insertActivity(Activity record);
    /*
    * 条件查询市场活动的表的数据并实现分页*/
    List<Activity> selectActivityByConditionForPage(Map<String,Object> map);

    int selectCountOfActivityByCondition(Map<String,Object> map);
}