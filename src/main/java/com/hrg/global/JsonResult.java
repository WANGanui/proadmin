package com.hrg.global;

import com.google.common.collect.Maps;
import java.util.Map;

/**
 * 
 * 类说明：JSON返回对象，API接口统一返回值
 */
public class JsonResult {

	private boolean success = true;

	private String code = "0";

	private String message = "";

	private Map<Object, Object> data = Maps.newHashMap();

	public JsonResult() {
		super();
	}

	public JsonResult(boolean success) {
		super();
		this.success = success;
	}

	public JsonResult(String code, String message) {
		super();
		this.code = code;
		this.message = message;
		this.success = false;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

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

	public Map<Object, Object> getData() {
		return data;
	}

	public void setData(Map<Object, Object> data) {
		this.data = data;
	}

	public JsonResult appendData(Object key, Object value) {
		this.data.put(key, value);
		return this;
	}

	public JsonResult appendData(Map<?, ?> map) {
		this.data.putAll(map);
		return this;
	}

}
