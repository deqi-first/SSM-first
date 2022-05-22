package com.lyx.settings.mapper;

import com.lyx.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(String userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User selectUserByLoginActAndPwd(Map<String,Object> map);

    List<User> selectAllUsers();
}