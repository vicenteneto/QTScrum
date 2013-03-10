package br.ufpb.esa.project.scrum.jdbc.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.caelum.vraptor.ioc.Component;
import br.ufpb.esa.project.scrum.model.Sprint;

@Component
public class SprintDao {
	private final Session session;
	
	public SprintDao(Session session) {
		this.session = session;
	}
	
	public void save(Sprint sprint) {
		Transaction tx = session.beginTransaction();
		session.save(sprint);
		tx.commit();
	}
	
	public void update(Sprint sprint) {
		Transaction tx = session.beginTransaction();
		session.update(sprint);
		tx.commit();
	}

	public void delete(Sprint sprint) {
		Transaction tx = session.beginTransaction();
		session.delete(sprint);
		tx.commit();
	}

	public Sprint load(Long id) {
		return (Sprint) session.load(Sprint.class, id);
	}
	
	public List<Sprint> listAll() {
		return session.createCriteria(Sprint.class).list();
	}
}