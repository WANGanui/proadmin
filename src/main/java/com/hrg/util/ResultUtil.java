package com.hrg.util;

import com.google.common.collect.Maps;
import com.hrg.enums.ErrorCode;
import com.hrg.global.JsonResult;

import java.util.Map;

/**
 * 
 * 类说明：返回值基础封装
 */
public class ResultUtil {
	
	/**
	 * 
	 * 方法说明：单个值返回
	 * @param key
	 * @param value
	 * @return
	 */
	public static JsonResult returnSuccess(Object key, Object value){
		JsonResult jr = new JsonResult();
		Map<Object, Object> data = Maps.newHashMap();
		data.put(key, value);
		jr.setData(data);
		return jr;
	}

	/**
	 * 
	 * 方法说明：多个值返回
	 * @param keys
	 * @param values
	 * @return
	 */
	public static JsonResult returnSuccess(Object[] keys, Object[] values) {
		JsonResult jr = new JsonResult();
		Map<Object, Object> data = Maps.newHashMap();
		for (int i = 0; i < keys.length; i++) {
			data.put(keys[i], values[i]);
		}
		jr.setData(data);
		return jr;
	}

	/**
	 * 方法说明：返回成功结果
	 * @return
	 */
	public static JsonResult returnSuccess() {
		JsonResult jr = new JsonResult();
		return jr;
	}

	/**
	 * 
	 * 方法说明：返回成功结果
	 * 
	 * @param message
	 *            : 返回的信息
	 * @return
	 */
	public static JsonResult returnSuccess(String message) {
		JsonResult jr = new JsonResult();
		jr.setMessage(message);
		return jr;
	}
	
	/**
	 * 
	 * 方法说明：返回成功结果
	 * @param message
	 * @param data
	 * @return
	 */
	public static JsonResult returnSuccess(String message, Map<Object, Object> data) {
		JsonResult jr = new JsonResult();
		jr.setMessage(message);
		jr.setData(data);
		return jr;
	}

	/**
	 * 方法说明：返回成功结果
	 * @param data
	 * @return
	 */
	public static JsonResult returnSuccess(Map<Object, Object> data) {
		JsonResult jr = new JsonResult();
		jr.setData(data);
		return jr;
	}

	/**
	 * 方法说明：返回失败结果
	 * @param errorCode 失败原因代码
	 * @return
	 */
	public static JsonResult returnFail(String errorCode) {
		JsonResult jr = new JsonResult();
		jr.setSuccess(false);
		jr.setCode(errorCode);
		return jr;
	}

	/**
	 * 方法说明：返回失败结果(含失败信息)
	 * @param errorCode
	 *            失败原因代码
	 * @param message
	 *            失败信息
	 * @return
	 */
	public static JsonResult returnFail(String errorCode, String message) {
		JsonResult jr = new JsonResult();
		jr.setSuccess(false);
		jr.setCode(errorCode);
		jr.setMessage(message);
		return jr;
	}
	/**
	 * 方法说明：返回失败结果(含失败信息)
	 * @param errorCode
	 *            失败代码
	 * @param data
	 *            失败信息
	 * @return
	 */
	public static JsonResult returnFail(ErrorCode errorCode, Map<Object, Object> data) {
		JsonResult jr = new JsonResult();
		jr.setSuccess(false);
		jr.setCode(errorCode.getCode());
		jr.setMessage(errorCode.getMessage());
		jr.setData(data);
		return jr;
	}
	/**
	 * 方法说明：返回失败结果(含失败信息)
	 * @param errorCode
	 *            失败代码
	 * @return
	 */
	public static JsonResult returnFail(ErrorCode errorCode) {
		JsonResult jr = new JsonResult();
		jr.setSuccess(false);
		jr.setCode(errorCode.getCode());
		jr.setMessage(errorCode.getMessage());
		return jr;
	}
}
