package com.lyx.commons.utils;

import java.util.UUID;

/**
 * @program:IntelliJ IDEA
 * @description: uuid
 * @author: xmq
 * @create: 2022-05-22 15:59
 **/
public class UUIDUtils {
    public static String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-","");
    }
}
