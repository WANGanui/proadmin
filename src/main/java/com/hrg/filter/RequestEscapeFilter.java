/**
 *
 */
package com.hrg.filter;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class RequestEscapeFilter implements Filter{
	private static Logger logger = Logger.getLogger(RequestEscapeFilter.class);
	/**
	 * <span style="color: red; font-weight: 900">方法说明:转义过滤器 </span>
	 * @param filterConfig
	 * @throws ServletException
	 */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	/**
	 * <span style="color: red; font-weight: 900">方法说明:请求参数转义 </span>
	 * @param request
	 * @param response
	 * @param chain
	 * @throws IOException
	 * @throws ServletException
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/**
		 * @author 
		 * @param
		*/
		logger.info("=====================开始转义=================");
		HttpServletRequest httpServletRequest=(HttpServletRequest)request;
//		Map<String, String[]> map = httpServletRequest.getParameterMap();
//		for(Map.Entry<String, String[]> entry:map.entrySet()){
//			String[] value = entry.getValue();
//			for(String str:value){
//				String strEscaped = StringEscapeUtils.escapeHtml(str);
//				logger.info(StringEscapeUtils.escapeHtml(str));
//			}
//		}
		ParameterRequestWrapper wrapRequest=new ParameterRequestWrapper(httpServletRequest,request.getParameterMap());
		chain.doFilter(wrapRequest, response);
	}

	/**
	 * <span style="color: red; font-weight: 900">方法说明: </span>
	 */
	@Override
	public void destroy() {

	}

}
