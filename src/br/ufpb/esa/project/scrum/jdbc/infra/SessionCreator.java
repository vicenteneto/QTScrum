package br.ufpb.esa.project.scrum.jdbc.infra;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.ComponentFactory;

@Component
public class SessionCreator implements ComponentFactory<Session> {
	private final SessionFactory factory;
	private Session session;

	public SessionCreator(SessionFactory factory) {
		this.factory = factory;
	}
	
	@PostConstruct
	public void open() {
		this.session = factory.openSession();
	}
	
	@Override
	public Session getInstance() {
		return this.session;
	}
	
	@PreDestroy
	public void close() {
		this.session.close();
	}
}