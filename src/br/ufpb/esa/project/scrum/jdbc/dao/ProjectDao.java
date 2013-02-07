package br.ufpb.esa.project.scrum.jdbc.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import br.com.caelum.vraptor.ioc.Component;
import br.ufpb.esa.project.scrum.model.Project;

@Component
public class ProjectDao {
	private final Session session;
	
	public ProjectDao(Session session) {
		this.session = session;
	}
	
	public void save(Project project) {
		Transaction tx = this.session.beginTransaction();
		this.session.save(project);
		tx.commit();
	}

	public Project load(Long id) {
		return (Project) session.createCriteria(Project.class).add(Restrictions.eq("id", id)).uniqueResult();
	}

	public void delete(Project project) {
		Transaction tx = this.session.beginTransaction();
		this.session.delete(project);
		tx.commit();
	}
	
	public List<Project> listAll() {
		return session.createCriteria(Project.class).list();
	}
}