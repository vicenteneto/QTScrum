package br.ufpb.esa.project.scrum.tests;

import static org.junit.Assert.assertEquals;

import java.util.Collection;
import java.util.GregorianCalendar;

import org.junit.BeforeClass;
import org.junit.Test;

import br.ufpb.esa.project.scrum.controller.TarefaController;
import br.ufpb.esa.project.scrum.model.Status;
import br.ufpb.esa.project.scrum.model.Tarefa;

public class TestTarefaController {
	@BeforeClass
	public static void createTarefas() {
		TarefaController tc = new TarefaController();
		
		tc.createTarefa("Descrição da Tarefa 1", new GregorianCalendar(2012, 12, 31), Status.DONE);
		tc.createTarefa("Descrição da Tarefa 2", new GregorianCalendar(2012, 12, 31), Status.DOING);
		tc.createTarefa("Descrição da Tarefa 3", new GregorianCalendar(2012, 12, 31), Status.TODO);
		tc.createTarefa("Descrição da Tarefa 4", new GregorianCalendar(2012, 12, 31), Status.TODO);
	}
	
	@Test
	public void testReadTarefa() {
		TarefaController tc = new TarefaController();
		
		Tarefa tId = tc.readTarefaById(1L);
		assertEquals("Descrição da Tarefa 1", tId.getDescricao());
		
		Collection<Tarefa> tarefas = tc.readTarefasByStatus(Status.TODO);
		assertEquals(2, tarefas.size());
	}
	
	@Test
	public void testGetTarefas() {
		TarefaController tc = new TarefaController();
		
		Collection<Tarefa> tarefas = tc.getTarefas();
		assertEquals(4, tarefas.size());
	}
	
	@Test
	public void testDeleteTarefa() {
		TarefaController tc = new TarefaController();
		
		tc.deleteTarefaById(1L);
		
		Collection<Tarefa> tarefas = tc.getTarefas();
		assertEquals(3, tarefas.size());
	}
}