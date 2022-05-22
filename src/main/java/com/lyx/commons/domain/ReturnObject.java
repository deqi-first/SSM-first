package com.lyx.commons.domain;

/**
 * @program:IntelliJ IDEA
 * @description: 返回响应信息的类
 * @author: xmq
 * @create: 2022-05-17 16:18
 **/
public class ReturnObject {
    private String code;//处理成功或失败的标记
    private String message;//提示信息
    private Object retData;//其他数据

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getRetData() {
        return retData;
    }

    public void setRetData(Object retData) {
        this.retData = retData;
    }
}
