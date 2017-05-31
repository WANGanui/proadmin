/**
 *
 */
package com.hrg.util;

import com.hrg.exception.ValidatorException;
//import com.hrg.model.Worker;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

/**
 * 类说明:获取员工信息工具类
 */
public class SubjectUtil {
	

	/*public static String getAccout() throws Exception {
		Subject subject = SecurityUtils.getSubject();
		 if(subject==null){
			throw new ValidatorException("未登录"); 
		 }
		 Worker worker = (Worker)subject.getPrincipal();
		 return worker.getAccount();
	}
	public static String getName() throws Exception {
		Subject subject = SecurityUtils.getSubject();
		 if(subject==null){
			throw new ValidatorException("未登录"); 
		 }
		 Worker worker = (Worker)subject.getPrincipal();
		 return worker.getName();
	}
	public static String getId() throws Exception {
		Subject subject = SecurityUtils.getSubject();
		 Worker worker = (Worker)subject.getPrincipal();
		 if(worker==null){
			 throw new ValidatorException("未登录"); 
			 }
		 return worker.getDataid();
	}
	public static String getDepartmentid() throws Exception {
		Subject subject = SecurityUtils.getSubject();
		 Worker worker = (Worker)subject.getPrincipal();
		 if(worker==null){
			 throw new ValidatorException("未登录"); 
			 }
		 return worker.getDepartmentdataid();
	}
	public static String getDepartment() throws Exception {
		Subject subject = SecurityUtils.getSubject();
		 Worker worker = (Worker)subject.getPrincipal();
		 if(worker==null){
			 throw new ValidatorException("未登录"); 
			 }
		 return worker.getDepartment();
	}*/
}
