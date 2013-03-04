package br.ufpb.esa.project.scrum.jdbc.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.caelum.vraptor.ioc.Component;
import br.ufpb.esa.project.scrum.model.Task;

@Component
public class TaskDao {
	private final Session session;
	
	public TaskDao(Session session) {
		this.session = session;
	}
	
	public void save(Task task) {
		Transaction tx = session.beginTransaction();
		session.save(task);
		tx.commit();
	}

	public void update(Task task) {
		Transaction tx = session.beginTransaction();
		session.update(task);
		tx.commit();
	}
	
	public void delete(Task task) {
		Transaction tx = session.beginTransaction();
		session.delete(task);
		tx.commit();
	}

	public Task load(Long id) {
		return (Task) session.load(Task.class, id);
	}

	public List<Task> listAll() {
		return session.createCriteria(Task.class).list();
	}
}