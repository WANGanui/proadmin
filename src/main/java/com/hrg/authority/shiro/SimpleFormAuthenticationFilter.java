/**
 *
 */
package com.hrg.authority.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
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
public class SimpleFormAuthenticationFilter extends FormAuthenticationFilter {
	
	private static Logger log = LoggerFactory.getLogger(SimpleFormAuthenticationFilter.class);


	/**
	 * 主要是针对登入成功的处理方法。对于请求头是AJAX的之间返回JSON字符串。
	 */
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		if (!"XMLHttpRequest".equalsIgnoreCase(httpServletRequest.getHeader("X-Requested-With"))) {
			// 不是ajax请求
			log.info("=============非ajax请求方式=============");
			issueSuccessRedirect(request, response);
		} else {
			log.info("=============ajax请求方式=============");
			log.info("=============登录成功=============");
			httpServletResponse.setCharacterEncoding("UTF-8");
			httpServletResponse.setContentType("application/json");
			PrintWriter out = httpServletResponse.getWriter();
			out.println("{\"success\":true,\"message\":\"登入成功\"}");
			out.flush();
			out.close();
		}
		return false;
	}

	/**
	 * 主要是处理登入失败的方法
	 */
	@Override
	protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
		if (!"XMLHttpRequest".equalsIgnoreCase(((HttpServletRequest) request).getHeader("X-Requested-With"))) {// 不是ajax请求
			log.info("=============非ajax请求方式=============");
			setFailureAttribute(request, e);
			return true;
		}
		try {
			log.info("=============ajax请求方式=============");
			log.info("=============登录失败=============");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			String message = e.getClass().getSimpleName();
			if ("IncorrectCredentialsException".equals(message)) {
				log.info("=============密码错误=============");
				out.println("{\"success\":false,\"message\":\"密码错误\"}");
			} else if ("AuthenticationException".equals(message)) {
				log.info("=============账号不存在=============");
				out.println("{\"success\":false,\"message\":\"账号不存在\"}");
			}else if ("UnknownAccountException".equals(message)) {
				log.info("=============账号不存在=============");
				out.println("{\"success\":false,\"message\":\"账号不存在\"}");
			} else if ("LockedAccountException".equals(message)) {
				log.info("=============账号被锁定=============");
				out.println("{\"success\":false,\"message\":\"账号被锁定\"}");
			} else {
				log.error("=============系统异常=============");
				out.println("{\"success\":false,\"message\":\"未知错误\"}");
			}
			out.flush();
			out.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return false;
	}

	 /**
     * 表示当访问拒绝时
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {

        if(this.isLoginRequest(request, response)) {
            if(this.isLoginSubmission(request, response)) {
                if(log.isTraceEnabled()) {
                    log.trace("LoginController submission detected.  Attempting to execute login.");
                }
                return this.executeLogin(request, response);
            } else {
                if(log.isTraceEnabled()) {
                    log.trace("LoginController page view.");
                }
                return true;
            }
        } else {
            if(log.isTraceEnabled()) {
                log.trace("Attempting to access a path which requires authentication.  Forwarding to the Authentication url [" + this.getLoginUrl() + "]");
            }
            if ("XMLHttpRequest".equalsIgnoreCase(((HttpServletRequest) request).getHeader("X-Requested-With"))) {
            	response.setCharacterEncoding("UTF-8");
    			response.setContentType("application/json");
    			PrintWriter out = response.getWriter();
            	log.info("=============员工未登录=============");
				out.println("{\"success\":false,\"message\":\"员工未登录\",\"code\":\"00011\"}");
				out.flush();
				out.close();
				return false;
            }
            this.saveRequestAndRedirectToLogin(request, response);
            return false;
        }
    }
}
