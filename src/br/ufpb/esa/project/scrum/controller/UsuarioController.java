package br.ufpb.esa.project.scrum.controller;

import java.util.Calendar;
import java.util.Collection;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import br.ufpb.esa.project.scrum.model.Usuario;

public class UsuarioController {
	public void createUsuario(String nome, Calendar dtNascimento, String email, String login, String senha) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		manager.getTransaction().begin();

		Usuario usuario = new Usuario();
		usuario.setNome(nome);
		usuario.setDtNascimento(dtNascimento);
		usuario.setEmail(email);
		usuario.setLogin(login);
		usuario.setSenha(senha);
		manager.persist(usuario);

		manager.getTransaction().commit();

		manager.close();
		factory.close();
	}
	
	public Usuario readUsuarioById(Long id) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.equal(u.get("id"), id);
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();

		manager.close();
		factory.close();

		return usuario;
	}
	
	public Usuario readUsuarioByEmail(String email) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.equal(u.get("email"), email);
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();

		manager.close();
		factory.close();

		return usuario;
	}
	
	public Usuario readUsuarioByLogin(String login) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.equal(u.get("login"), login);
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();

		manager.close();
		factory.close();

		return usuario;
	}

	public Collection<Usuario> getUsuarios() {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Collection<Usuario> usuarios = query.getResultList();

		manager.close();
		factory.close();

		return usuarios;
	}
	
	public void deleteUsuarioById(Long id) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		manager.getTransaction().begin();
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.equal(u.get("id"), id);
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();
		
		manager.remove(usuario);
		manager.getTransaction().commit();

		manager.close();
		factory.close();
	}
	
	public void deleteUsuarioByEmail(String email) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		manager.getTransaction().begin();
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.equal(u.get("email"), email);
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();
		
		manager.remove(usuario);
		manager.getTransaction().commit();

		manager.close();
		factory.close();
	}
	
	public void deleteUsuarioByLogin(String login) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		manager.getTransaction().begin();
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.equal(u.get("login"), login);
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();
		
		manager.remove(usuario);
		manager.getTransaction().commit();

		manager.close();
		factory.close();
	}
	
	public Usuario login(String login, String senha) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Usuario> cq = cb.createQuery(Usuario.class);
		Root<Usuario> u = cq.from(Usuario.class);
		cq.select(u);

		Predicate predicate = cb.and(cb.equal(u.get("login"), login), cb.equal(u.get("senha"), senha));
		cq.where(predicate);

		TypedQuery<Usuario> query = manager.createQuery(cq);
		Usuario usuario = query.getSingleResult();

		manager.close();
		factory.close();

		return usuario;
	}
}