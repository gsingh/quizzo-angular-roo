// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.chariot.quizzo.model;

import com.chariot.quizzo.model.Player;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Player_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Player.entityManager;
    
    public static final EntityManager Player.entityManager() {
        EntityManager em = new Player().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Player.countPlayers() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Player o", Long.class).getSingleResult();
    }
    
    public static List<Player> Player.findAllPlayers() {
        return entityManager().createQuery("SELECT o FROM Player o", Player.class).getResultList();
    }
    
    public static Player Player.findPlayer(Long id) {
        if (id == null) return null;
        return entityManager().find(Player.class, id);
    }
    
    public static List<Player> Player.findPlayerEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Player o", Player.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Player.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Player.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Player attached = Player.findPlayer(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Player.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Player.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Player Player.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Player merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}