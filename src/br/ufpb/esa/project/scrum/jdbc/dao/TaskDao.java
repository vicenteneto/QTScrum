package br.ufpb.esa.project.scrum.jdbc.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import br.com.caelum.vraptor.ioc.Component;
import br.ufpb.esa.project.scrum.model.Project;
import br.ufpb.esa.project.scrum.model.Task;

@Component
public class TaskDao {
private final Session session;
	
	public TaskDao(Session session) {
		this.session = session;
	}
	
	public void save(Task task) {
		Transaction tx = this.session.beginTransaction();
		this.session.save(task);
		tx.commit();
	}

	public Task load(Long id) {
		return (Task) session.createCriteria(Task.class).add(Restrictions.eq("id", id)).uniqueResult();
	}

	public void delete(Task task) {
		Transaction tx = this.session.beginTransaction();
		this.session.delete(task);
		tx.commit();
	}

	public List<Task> listAll() {
		return session.createCriteria(Task.class).list();
	}
}