package com.hrg.annotation;

import java.lang.annotation.*;

/**
 * 
 * 类说明：自定义注解
 *
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public  @interface SystemControllerLog {    
    
    String description()  default "";
    
    
} 