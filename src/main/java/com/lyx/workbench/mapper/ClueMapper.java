package com.lyx.workbench.mapper;

import com.lyx.workbench.domain.Clue;

public interface ClueMapper {
    int deleteByPrimaryKey(String clueId);

    int insert(Clue record);

    int insertSelective(Clue record);

    Clue selectByPrimaryKey(String clueId);

    int updateByPrimaryKeySelective(Clue record);

    int updateByPrimaryKey(Clue record);
}