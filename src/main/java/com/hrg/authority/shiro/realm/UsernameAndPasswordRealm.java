package com.hrg.authority.shiro.realm;

import com.hrg.authority.redis.RedisManager;
import com.hrg.model.Worker;
import com.hrg.service.ShiroRealmService;
import com.hrg.util.JsonUtil;
//import com.hrg.api.service.CooperationService;
//import com.qpm.api.service.ShiroRealmService;
//import com.qpm.model.Cooperation;
//import com.qpm.model.Worker;
import com.hrg.util.ValidUtil;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Set;


/**
 * 类说明：ShiroRealm扩展类 本类实现了根据用户名和密码完成用户认证及授权的方法 选择本类实现的认证方法只需要作为ShiroRealm的实例向SpringContext注册即可
 */

public class UsernameAndPasswordRealm extends AuthorizingRealm {

	/**
	 * 日志记录
	 */
	private Logger logger = Logger.getLogger(UsernameAndPasswordRealm.class);

	@Override
	public void setName(String name) {
		super.setName("usernameAndPasswordRealm");
	}

	@Autowired
	private ShiroRealmService shiroRealmService;

	private RedisManager redisManager;

	/**
	 * 方法说明：用于向用户授权
	 * 
	 * @param principalCollection
	 * @return
	 */
	@Override
	public AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

		logger.info("=============shiro开始进行用户授权=============");

		/**
		 * 获取用户身份
		 */
		Object principal = principalCollection.fromRealm(getName()).iterator().next();

		/**
		 * 获取用户拥有的角色及权限 并构造SimpleAuthorizationInfo对象 ShiroRealmService接口中的getHaveRoleByUser方法需要自行实现 ShiroRealmService接口中的getPermissionStringByUser方法需要自行实现 此处获取的字符串形式的角色、权限信息可供shiro:hasRole、shiro:hasPermission标签使用
		 */
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		List<String> roleList = null;
		try {
			roleList = shiroRealmService.getHaveRoleStringByUser(principal);
			simpleAuthorizationInfo.addRoles(roleList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<String> permissionList = null;
		try {
			permissionList = shiroRealmService.getPermissionStringByUser(principal);
			logger.info("=============员工权限:"+ JsonUtil.encode(permissionList)+"=============");
			simpleAuthorizationInfo.addStringPermissions(permissionList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return simpleAuthorizationInfo;
	}

	/**
	 * 方法说明：向ShiroRealm提供用户认证方法
	 * 
	 * @param authenticationToken
	 * @return
	 * @throws Exception
	 */
	@Override
	public AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
		logger.info("=============shiro开始进行用户身份认证=============");
		/**
		 * 根据用户输入获取身份信息 比如用户名等任意形式的身份信息
		 */
		Object principal = authenticationToken.getPrincipal();
		
		/**
		 * 根据用户输入的身份信息获得完整的身份对象存入下文中的simpleAuthenticationInfo对象 shiroRealmService接口中的getLoginUser方法需要自行实现
		 */
		Object principalObject = null;
		Worker worker = null;
		try {
			principalObject = shiroRealmService.getLoginUser(principal);
			/**
			 * 未获取到用户
			 */
			if (principalObject == null) {
				throw new UnknownAccountException();
			}
			worker = (Worker)principalObject;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/**
		 * 账户被锁定 shiroRealmService接口中的isLocked方法需要自行实现
		 */
		if (shiroRealmService.isLocked(principalObject)) {
			throw new LockedAccountException();
		}


		/**
		 * SimpleAuthenticationInfo构造方法：Object principal, Object credentials, String realmName principal：身份 credentials：凭证
		 */
		SimpleAuthenticationInfo simpleAuthenticationInfo = null;
		try {
			simpleAuthenticationInfo = new SimpleAuthenticationInfo(worker, shiroRealmService.getUserCredentials(principal), this.getName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return simpleAuthenticationInfo;
	}
	/**
	 * <span style="color: red; font-weight: 900">方法说明:清除权限缓存 </span>
	 * @return: void
	 */
	public void clearCached(){
		Set<byte[]> set = redisManager.keys("shiro_redis_cache:"+"*");
		for(byte[] key:set){
			redisManager.del(key);
		}

	}
    /*public void setSessionWorker(String cooperationdataid){
        Subject sub = SecurityUtils.getSubject();
        Worker worker = (Worker) sub.getPrincipal();
        if(!ValidUtil.isNullOrEmpty(worker)&&!ValidUtil.isNullOrEmpty(cooperationdataid)){
            worker.setCooperationdataid(cooperationdataid);
        }
        sub.getSession().setAttribute("CURRENT_USER", worker);
    }*/

    public Worker getSessionWorker(){
        return  (Worker)SecurityUtils.getSubject().getSession().getAttribute("CURRENT_USER");
    }
}
