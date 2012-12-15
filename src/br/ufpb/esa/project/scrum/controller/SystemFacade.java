package br.ufpb.esa.project.scrum.controller;

import java.util.Calendar;
import java.util.Collection;

import br.ufpb.esa.project.scrum.model.Status;
import br.ufpb.esa.project.scrum.model.Tarefa;
import br.ufpb.esa.project.scrum.model.Usuario;

public class SystemFacade {
	private UsuarioController uc;
	private TarefaController tc;
	
	public SystemFacade() {
		uc = new UsuarioController();
		tc = new TarefaController();
	}
	
	public void createUsuario(String nome, Calendar dtNascimento, String email, String login, String senha) {
		uc.createUsuario(nome, dtNascimento, email, login, senha);
	}
	
	public Usuario readUsuarioById(Long id) {
		return uc.readUsuarioById(id);
	}
	
	public Usuario readUsuarioByEmail(String email) {
		return uc.readUsuarioByEmail(email);
	}
	
	public Usuario readUsuarioByLogin(String login) {
		return uc.readUsuarioByLogin(login);
	}
	
	public Collection<Usuario> getUsuarios() {
		return uc.getUsuarios();
	}
	
	public void deleteUsuarioById(Long id) {
		uc.deleteUsuarioById(id);
	}
	
	public void deleteUsuarioByEmail(String email) {
		uc.deleteUsuarioByEmail(email);
	}
	
	public void deleteUsuarioByLogin(String login) {
		uc.deleteUsuarioByLogin(login);
	}
	
	public Usuario login(String login, String senha) {
		return uc.login(login, senha);
	}
	
	public void createTarefa(String descricao, Calendar vencimento, Status status) {
		tc.createTarefa(descricao, vencimento, status);
	}
	
	public Tarefa readTarefaById(Long id) {
		return tc.readTarefaById(id);
	}
	
	public Collection<Tarefa> readTarefasByStatus(Status status) {
		return tc.readTarefasByStatus(status);
	}
	
	public Collection<Tarefa> getTarefas() {
		return tc.getTarefas();
	}
	
	public void deleteTarefaById(Long id) {
		tc.deleteTarefaById(id);
	}
}