package com.hrg.util;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.Converter;
import org.apache.commons.beanutils.PropertyUtilsBean;
import org.apache.commons.lang.StringUtils;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


public class EntityUtils {
	  
    /** 
     * 根据对象列表和对象的某个属性返回属性的List集合 
     *  
     * @param objList 
     *            对象列表 
     * @param propertyName 
     *            要操作的属性名称 
     * @return <pre> 
     *  指定属性的List集合; 
     *  如果objList为null或者size等于0抛出 IllegalArgumentException异常; 
     *  如果propertyName为null抛出 IllegalArgumentException异常 
     * </pre> 
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     */  
    public static <T> List<Object> getPropertyList(List<T> objList, String propertyName) throws IllegalAccessException,
            InvocationTargetException, NoSuchMethodException {
        if (objList == null || objList.size() == 0)  
            throw new IllegalArgumentException("No objList specified");
        if (propertyName == null || "".equals(propertyName)) {  
            throw new IllegalArgumentException("No propertyName specified for bean class '" + objList.get(0).getClass() + "'");
        }  
        PropertyUtilsBean p = new PropertyUtilsBean();  
        List<Object> propList = new LinkedList<Object>();
        for (int i = 0; i < objList.size(); i++) {  
            T obj = objList.get(i);  
            propList.add(p.getProperty(obj, propertyName));  
        }  
        return propList;  
    }  
    
    public static <T> List<String> getStringPropertyList(List<T> objList, String propertyName){
    	List<String> propList = new LinkedList<String>();
    	
		if (objList == null || objList.size() == 0){
			return propList;
		}
		      
		if (propertyName == null || "".equals(propertyName)) {  
		    throw new IllegalArgumentException("No propertyName specified for bean class '" + objList.get(0).getClass() + "'");
		}  
		PropertyUtilsBean p = new PropertyUtilsBean();  
		
		for (int i = 0; i < objList.size(); i++) {  
		    T obj = objList.get(i);  
		    try {
				propList.add(String.valueOf(p.getProperty(obj, propertyName)));
			} catch (Exception e) {
				propList.add("null");
			} 
		}  
		return propList;  
	}  
  
    /** 
     * 将List列表中的对象的某个属性封装成一个Map对象，key值是属性名，value值是对象列表中对象属性值的列表 
     *  
     * @param objList 
     *            对象列表 
     * @param propertyName 
     *            属性名称,可以是一个或者多个 
     * @return 返回封装了属性名称和属性值列表的Map对象，如果参数非法则抛出异常信息 
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     * @throws NoSuchMethodException
     */  
    public static <T> Map<String, List<Object>> getPropertiesMap(List<T> objList, String... propertyName)
            throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        if (objList == null || objList.size() == 0)  
            throw new IllegalArgumentException("No objList specified");
        if (propertyName == null || propertyName.length == 0) {  
            throw new IllegalArgumentException("No propertyName specified for bean class '" + objList.get(0).getClass() + "'");
        }  
        Map<String, List<Object>> maps = new HashMap<String, List<Object>>();
        for (int i = 0; i < propertyName.length; i++) {  
            maps.put(propertyName[i], getPropertyList(objList, propertyName[i]));  
        }  
        return maps;  
    }  
    
    /**
     * Object List to Map<String, Object> List
     * 
     * @param <T>
     * @param objList
     * @param propertyNames
     * @return List<Map<String, Object>>
     */
    public static <T> List<Map<String, Object>> objectListToListMap(List<T> objList, String... propertyNames){
        if (objList == null || objList.size() == 0)  
            throw new IllegalArgumentException("No objList specified");
        if (propertyNames == null || "".equals(propertyNames)) {  
            throw new IllegalArgumentException("No propertyName specified for bean class '" + objList.get(0).getClass() + "'");
        }  
        PropertyUtilsBean p = new PropertyUtilsBean();  
        List<Map<String, Object>> rslist = new LinkedList<Map<String, Object>>();
        for(T obj: objList){
        	Map<String, Object> row = new HashMap<String, Object>();
        	for(String name : propertyNames){
        		try {
					row.put(name, p.getProperty(obj, name));
				} catch (Exception e) {
					row.put(name, null);
				} 
        	}
        	rslist.add(row);
        }
        
        return rslist;
    }
    
    
    public static Object mapToObject(Map<String, Object> map, Class<?> beanClass){
        if (map == null)  
            return null;  
        Object obj = null;
		try{
			obj = beanClass.newInstance();  
			registerDateConvertUtils();
			org.apache.commons.beanutils.BeanUtils.populate(obj, map);  
		  }catch (Exception e) {
			throw new RuntimeException("mapToObject ", e);
		}
  
        return obj;  
    }    
    
    public static <T> List<T> mapListToObjectList(List<Map<String,Object>> maplist, Class<T> beanClass){
    	List<T> relist = new LinkedList<T>();
    	for(Map<String,Object> map : maplist){
    		try{
	    		T obj = beanClass.newInstance();
	    		registerDateConvertUtils();
	    		org.apache.commons.beanutils.BeanUtils.populate(obj, map);  
	    		relist.add(obj);
    		}catch (Exception e) {
    			relist.add(null);
			}
    	}
		return relist;
    	
    }
    
    public static void registerDateConvertUtils(){
    	ConvertUtils.register(new Converter()    
        {    
                 
      
            @Override
            public Object convert(Class clazz, Object obj)
            {    
                if(obj == null)    
                {    
                    return null;    
                }    
                if(obj instanceof Long)
                {    
                    return new Date((Long)obj);
                }  
                if(obj instanceof String){
	                String str = String.valueOf(obj);
	                if(StringUtils.isEmpty(str))    
	                {    
	                    return null;    
	                }    
	                     
	                SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	                     
	                try{    
	                    return sd.parse(str);    
	                }    
	                catch(ParseException e)
	                {    
	                	e.printStackTrace();
	                	return null;    
	                }    
                }
                if(obj instanceof java.util.Date){
                	return obj;
                }

                return  null;
            }

        }, java.util.Date.class);
    }

    public static Map<String,Object> convertBean(Object bean)
            throws IntrospectionException, IllegalAccessException, InvocationTargetException {
        Class type = bean.getClass();
        Map returnMap = new HashMap();
        BeanInfo beanInfo = Introspector.getBeanInfo(type);
        PropertyDescriptor[] propertyDescriptors =  beanInfo.getPropertyDescriptors();
        for (int i = 0; i< propertyDescriptors.length; i++) {
            PropertyDescriptor descriptor = propertyDescriptors[i];
            String propertyName = descriptor.getName();
            if (!propertyName.equals("class")) {
                Method readMethod = descriptor.getReadMethod();
                Object result = readMethod.invoke(bean, new Object[0]);
                if (result != null) {
                    returnMap.put(propertyName, result);
                } else {
                    returnMap.put(propertyName, "");
                }
            }
        }
        return returnMap;
    }
}  
