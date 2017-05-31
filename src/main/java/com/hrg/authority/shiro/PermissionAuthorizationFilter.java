/**
 *
 */
package com.hrg.authority.shiro;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 */
public class PermissionAuthorizationFilter extends PermissionsAuthorizationFilter {

	private static Logger log = LoggerFactory.getLogger(PermissionAuthorizationFilter.class);
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		log.info("==============员工权限过滤器===============");
		Subject subject = getSubject(request, response);
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		HttpServletRequest httpServletRequest = (HttpServletRequest)request;
		httpServletResponse.setCharacterEncoding("UTF-8");
		httpServletResponse.setContentType("application/json");
		PrintWriter out = httpServletResponse.getWriter();
		// If the subject isn't identified, redirect to login URL
		if (subject.getPrincipal() == null) {  
			if ("XMLHttpRequest".equalsIgnoreCase(httpServletRequest.getHeader("X-Requested-With"))) { 
				log.info("================员工身份过期，需重新登录==============");
				out.println("{\"success\":false,\"message\":\"请重新登录\",\"code\":\"00010\"}");
				out.flush();
				out.close();
            } else {  
                saveRequestAndRedirectToLogin(request, response);  
            }  
        } else {  
            if ("XMLHttpRequest".equalsIgnoreCase(httpServletRequest.getHeader("X-Requested-With"))) { 
            	log.info("================员工没有此权限====================");
            	out.println("{\"success\":false,\"message\":\"你没有权限\",\"code\":\"00013\"}");
				out.flush();
				out.close();  
            } else {  
                String unauthorizedUrl = getUnauthorizedUrl();
                if (StringUtils.hasText(unauthorizedUrl)) {  
                	log.info("================员工没有此权限====================");
                	out.println("{\"success\":false,\"message\":\"你没有权限\",\"code\":\"00013\"}");
    				out.flush();
    				out.close();  
                } else {  
                    WebUtils.toHttp(response).sendError(401);  
                } 
            }
        }
		return false;
	}

	@Override
	 public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws IOException {
	        Subject subject = getSubject(request, response);
	        String[] perms = (String[]) mappedValue;
	        boolean isPermitted = true;
	        if (perms != null && perms.length > 0) {
	            if (perms.length == 1) {
	                if (!subject.isPermitted(perms[0])) {
	                    isPermitted = false;
	                }
	            } else {
	                if (!subject.isPermittedAll(perms)) {
	                    isPermitted = false;
	                }
	            }
	        }
	        return isPermitted;
	    }
}
