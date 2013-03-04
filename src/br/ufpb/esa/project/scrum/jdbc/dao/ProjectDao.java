package br.ufpb.esa.project.scrum.jdbc.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.caelum.vraptor.ioc.Component;
import br.ufpb.esa.project.scrum.model.Project;

@Component
public class ProjectDao {
	private final Session session;
	
	public ProjectDao(Session session) {
		this.session = session;
	}
	
	public void save(Project project) {
		Transaction tx = session.beginTransaction();
		session.save(project);
		tx.commit();
	}
	
	public void update(Project project) {
		Transaction tx = session.beginTransaction();
		session.update(project);
		tx.commit();
	}

	public void delete(Project project) {
		Transaction tx = session.beginTransaction();
		session.delete(project);
		tx.commit();
	}

	public Project load(Long id) {
		return (Project) session.load(Project.class, id);
	}
	
	public List<Project> listAll() {
		return session.createCriteria(Project.class).list();
	}
}