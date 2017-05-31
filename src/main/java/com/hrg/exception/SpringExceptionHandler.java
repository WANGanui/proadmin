package com.hrg.exception;

import com.hrg.enums.ErrorCode;
import com.hrg.global.JsonResult;
import com.hrg.util.ResultUtil;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import java.util.HashMap;
import java.util.Map;

/**
 * 异常捕获统一处理类
 */
@ControllerAdvice
public class SpringExceptionHandler {


    @ExceptionHandler(value = {Exception.class})
    public ResponseEntity<Object> handleOtherExceptions(final Exception ex, final WebRequest req) {
        JsonResult jr = null;
        Map errMap = new HashMap();
        if(ex instanceof MaxUploadSizeExceededException){
            errMap.put("error","请上传小与1M的文件");
            jr = ResultUtil.returnFail(ErrorCode.UPLOAD_EXCEPTION,errMap);
        } else if(ex instanceof UnauthorizedException){
        	jr = ResultUtil.returnFail(ErrorCode.NO_PERMISSION,errMap);
        }
        else if(ex instanceof UnknownAccountException){
        	jr = ResultUtil.returnFail(ErrorCode.ACCOUNT_NON_EXISTEND,errMap);
        } else{
            jr = ResultUtil.returnFail(ErrorCode.UN_KNOWN_EXCEPTION,errMap);
            ex.printStackTrace();
        }
        return new ResponseEntity<Object>(jr, HttpStatus.OK);
    }
}
