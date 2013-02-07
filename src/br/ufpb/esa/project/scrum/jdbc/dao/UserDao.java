package br.ufpb.esa.project.scrum.jdbc.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
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

	public User load(User user) {
		return (User) session.createCriteria(User.class).add(Restrictions.eq("login", user.getLogin())).add(Restrictions.eq("password", user.getPassword())).uniqueResult();
	}

	public User load(Long id) {
		return (User) session.createCriteria(User.class).add(Restrictions.eq("id", id)).uniqueResult();
	}
}