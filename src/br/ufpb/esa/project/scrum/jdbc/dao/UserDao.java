package br.ufpb.esa.project.scrum.jdbc.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import br.com.caelum.vraptor.ioc.Component;
import br.ufpb.esa.project.scrum.model.User;

@Component
public class UserDao {
	private final Session session;
	
	public UserDao(Session session) {
		this.session = session;
	}
	
	public void save(User user) {
		Transaction tx = session.beginTransaction();
		session.save(user);
		tx.commit();
	}
	
	public void update(User user) {
		Transaction tx = session.beginTransaction();
		session.update(user);
		tx.commit();
	}

	public void delete(User user) {
		Transaction tx = session.beginTransaction();
		session.delete(user);
		tx.commit();
	}

	public User load(Long id) {
		return (User) session.load(User.class, id);
	}
	
	public User load(User user) {
		return (User) session.createCriteria(User.class).add(Restrictions.eq("login", user.getLogin())).add(Restrictions.eq("password", user.getPassword())).uniqueResult();
	}
	
	public List<User> search(String login) {
		return session.createCriteria(User.class).add(Restrictions.ilike("login", login, MatchMode.ANYWHERE)).list();
	}
	
	public List<User> listAll() {
		return session.createCriteria(User.class).list();
	}
}