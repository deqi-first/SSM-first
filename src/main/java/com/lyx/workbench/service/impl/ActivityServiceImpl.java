package com.lyx.workbench.service.impl;

import com.lyx.workbench.domain.Activity;
import com.lyx.workbench.mapper.ActivityMapper;
import com.lyx.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @program:IntelliJ IDEA
 * @description: 保存市场活动实现类
 * @author: xmq
 * @create: 2022-05-22 15:44
 **/
@Service("activityService")
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityMapper activityMapper;
    @Override
    public int saveActivity(Activity activity) {
        return activityMapper.insertActivity(activity);
    }
}
