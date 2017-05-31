package com.hrg.authority.dao;

import com.hrg.authority.redis.RedisManager;
import com.hrg.authority.redis.SerializeUtils;
import com.hrg.util.ValidUtil;
import org.apache.log4j.Logger;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * 类说明：实现redisSessionDao
 *
 */
public class ShiroRedisSessionDao extends AbstractSessionDAO {
	
	/**
	 * logger日志
	 */
	private static Logger logger = Logger.getLogger(ShiroRedisSessionDao.class);
	
	private String keyPrefix = "shiro_redis_session:";
	
	/**
	 * 注入redisManager
	 */
	private RedisManager redisManager;

	/**
	 * 清除session
	 * @param session
     */
	@Override
	public void delete(Session session) {
		if(session == null || session.getId() == null){
			logger.error("session or sessionId is null");
			return;
		}
        redisManager.del(this.getByteKey(session.getId()));  
	}

	/**
	 * 获取活动的session
	 * @return
     */
	@Override
	public Collection<Session> getActiveSessions() {
		Set<Session> sessions = new HashSet<>();
        
        Set<byte[]> keys = redisManager.keys(this.keyPrefix + "*");
        if(keys != null && keys.size()>0){  
            for(byte[] key:keys){  
                Session s = (Session) SerializeUtils.deserialize(redisManager.get(key));
                sessions.add(s);  
            }  
        }  
          
        return sessions;  
	}

	/**
	 * 更新session
	 * @param session
	 * @throws UnknownSessionException
     */
	@Override
	public void update(Session session) throws UnknownSessionException {
		this.saveSession(session);
	}

	/**
	 * 创建session
	 * @param session
	 * @return
     */
	@Override
	protected Serializable doCreate(Session session) {
		Serializable sessionId = this.generateSessionId(session);
        this.assignSessionId(session, sessionId);  
        this.saveSession(session);  
        return sessionId; 
	}

	/**
	 * 获取session
	 * @param sessionId
	 * @return
     */
	@Override
	protected Session doReadSession(Serializable sessionId) {
		if(ValidUtil.isNullOrEmpty(sessionId)){
            logger.error("session id is null");  
            return null;  
        }
        Session s = (Session)SerializeUtils.deserialize(redisManager.get(this.getByteKey(sessionId )));  
        return s;
	}

	/**
	 * 保存session
	 * @param session
	 * @throws UnknownSessionException
     */
	private void saveSession(Session session) throws UnknownSessionException{
		if(session == null || session.getId() == null){
			logger.error("session or sessionId is null");
			return;
		}
        byte[] key = getByteKey(session.getId());  
        byte[] value = SerializeUtils.serialize(session);  
        session.setTimeout(redisManager.getExpire()*1000);        
        this.redisManager.set(key, value, redisManager.getExpire());  
    }
	
	 /** 
     * 获得byte[]型的key 
     * @param sessionId
     * @return 
     */  
    private byte[] getByteKey(Serializable sessionId){
        String preKey = this.keyPrefix + sessionId;
        return preKey.getBytes();  
    }  

	public String getKeyPrefix() {
		return keyPrefix;
	}

	public void setKeyPrefix(String keyPrefix) {
		this.keyPrefix = keyPrefix;
	}

	public RedisManager getRedisManager() {
		return redisManager;
	}

	public void setRedisManager(RedisManager redisManager) {
		this.redisManager = redisManager;
	}
}
