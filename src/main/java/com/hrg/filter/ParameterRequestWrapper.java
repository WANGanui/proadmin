package com.hrg.filter;

import org.apache.log4j.Logger;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.HashMap;
import java.util.Map;

/**
 */
public class ParameterRequestWrapper extends HttpServletRequestWrapper {
    private static Logger logger = Logger.getLogger(ParameterRequestWrapper.class);
    private Map<String , String[]> params = new HashMap<String, String[]>();


    @SuppressWarnings("unchecked")
    public ParameterRequestWrapper(HttpServletRequest request) {
        // 将request交给父类，以便于调用对应方法的时候，将其输出，其实父亲类的实现方式和第一种new的方式类似
        super(request);
        //将参数表，赋予给当前的Map以便于持有request中的参数
        this.params.putAll(request.getParameterMap());
    }
    //重载一个构造方法
    public ParameterRequestWrapper(HttpServletRequest request,Map<String, String[]> extendParams) {
        this(request);
        addAllParameters(extendParams);//这里将扩展参数写入参数表
    }

    @Override
    public String getParameter(String name) {//重写getParameter，代表参数从当前类中的map获取
        String[]values = params.get(name);
        if(values == null || values.length == 0) {
            return null;
        }
        return values[0];
    }

    public String[] getParameterValues(String name) {//同上
        return params.get(name);
    }

    public void addAllParameters(Map<String, String[]> otherParams) {//增加多个参数
        for(Map.Entry<String, String[]> entry:otherParams.entrySet()){
			String[] value = entry.getValue();
			String[] pra = new String[value.length];
			for(int x=0;x<value.length;x++){
			    String str = value[x];
			    if("".equals(str)){
			    	str=null;
			    }
			    if(str!=null){
			    	String strEscaped = HtmlUtils.htmlEscape(str);
			    	strEscaped = strEscaped.replaceAll("&quot;","\"");
			    	strEscaped = strEscaped.replaceAll("&rsquo;","'");
			    	pra[x] = strEscaped;
			    }
			}
            params.put(entry.getKey() ,pra);
		}
    }
}
