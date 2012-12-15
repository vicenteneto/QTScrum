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

import br.ufpb.esa.project.scrum.model.Status;
import br.ufpb.esa.project.scrum.model.Tarefa;

public class TarefaController {
	public void createTarefa(String descricao, Calendar vencimento) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		manager.getTransaction().begin();

		Tarefa tarefa = new Tarefa();
		tarefa.setDescricao(descricao);
		tarefa.setVencimento(vencimento);
		manager.persist(tarefa);

		manager.getTransaction().commit();

		manager.close();
		factory.close();
	}
	
	public Tarefa readTarefaById(Long id) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Tarefa> cq = cb.createQuery(Tarefa.class);
		Root<Tarefa> t = cq.from(Tarefa.class);
		cq.select(t);

		Predicate predicate = cb.equal(t.get("id"), id);
		cq.where(predicate);

		TypedQuery<Tarefa> query = manager.createQuery(cq);
		Tarefa tarefa = query.getSingleResult();

		manager.close();
		factory.close();

		return tarefa;
	}
	
	public Collection<Tarefa> readTarefasByStatus(Status status) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Tarefa> cq = cb.createQuery(Tarefa.class);
		Root<Tarefa> t = cq.from(Tarefa.class);
		cq.select(t);

		Predicate predicate = cb.equal(t.get("status"), status);
		cq.where(predicate);

		TypedQuery<Tarefa> query = manager.createQuery(cq);
		Collection<Tarefa> tarefas = query.getResultList();

		manager.close();
		factory.close();

		return tarefas;
	}
	
	public Collection<Tarefa> getTarefas() {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Tarefa> cq = cb.createQuery(Tarefa.class);
		Root<Tarefa> t = cq.from(Tarefa.class);
		cq.select(t);
		
		TypedQuery<Tarefa> query = manager.createQuery(cq);
		Collection<Tarefa> tarefas = query.getResultList();
		
		manager.close();
		factory.close();
		
		return tarefas;
	}
	
	public void deleteTarefaById(Long id) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("esa_project_scrum_pu");
		EntityManager manager = factory.createEntityManager();

		manager.getTransaction().begin();
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Tarefa> cq = cb.createQuery(Tarefa.class);
		Root<Tarefa> t = cq.from(Tarefa.class);
		cq.select(t);

		Predicate predicate = cb.equal(t.get("id"), id);
		cq.where(predicate);

		TypedQuery<Tarefa> query = manager.createQuery(cq);
		Tarefa tarefa = query.getSingleResult();

		manager.remove(tarefa);
		manager.getTransaction().commit();
		
		manager.close();
		factory.close();
	}
}