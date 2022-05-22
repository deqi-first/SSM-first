package com.lyx.commons.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @program:IntelliJ IDEA
 * @description: 日期格式化
 * @author: xmq
 * @create: 2022-05-22 16:00
 **/
public class DateUtils {
    public static String getDate(){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return simpleDateFormat.format(new Date());
    }
}
