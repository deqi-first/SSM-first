package com.lyx.workbench.mapper;

import com.lyx.workbench.domain.Activity;

public interface ActivityMapper {
    int deleteByPrimaryKey(String activityId);

    int insertSelective(Activity record);

    Activity selectByPrimaryKey(String activityId);

    int updateByPrimaryKeySelective(Activity record);

    int updateByPrimaryKey(Activity record);
    /*
    * 保存创建市场活动*/
    int insertActivity(Activity record);
}