package br.ufpb.esa.project.scrum.jdbc.infra;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.ComponentFactory;

@Component
@ApplicationScoped
public class SessionFactoryCreator implements ComponentFactory<SessionFactory> {
	private SessionFactory factory;
	
	@PostConstruct
	public void open() {
		this.factory = new AnnotationConfiguration().configure().buildSessionFactory();
	}
	
	@Override
	public SessionFactory getInstance() {
		return this.factory;
	}
	
	@PreDestroy
	public void close() {
		this.factory.close();
	}
}