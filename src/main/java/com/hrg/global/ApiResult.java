package com.hrg.global;

/**
 * 协议对象:JSON接口调用
 *
 */
public class ApiResult {
	
	public String status;

	public String msg;
	
	public Object result;


	public interface DataLoadBackCall{
		Object success();
	}

	public static ApiResult builder(DataLoadBackCall dataLoadBackCall){
		ApiResult apiResult = new ApiResult();
		try {
			apiResult.result=dataLoadBackCall.success();
			apiResult.status="200";
			apiResult.msg="请求成功";
		}
		catch (Exception ex){
			apiResult.status = "-1";
			apiResult.msg = "请求数据失败!";
		}

		return apiResult;
	}

	public static ApiResult returnSuccess(Object object){
		ApiResult apiResult = new ApiResult();
		apiResult.status="200";
		apiResult.result=object;
		apiResult.msg="请求成功";
		return apiResult;
	}

	public static ApiResult returnSuccess(){
		ApiResult apiResult = new ApiResult();
		apiResult.msg="请求成功";
		return apiResult;
	}

	public static ApiResult returnFail(String msg,String status){
		ApiResult apiResult = new ApiResult();
		apiResult.status = status;
		apiResult.msg = msg;
		return apiResult;
	}
}
