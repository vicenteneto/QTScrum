package br.ufpb.esa.project.scrum.logica;

import java.util.Calendar;
import java.util.Collection;

import br.ufpb.esa.project.scrum.modelo.Tarefa;
import br.ufpb.esa.project.scrum.modelo.Usuario;

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
	
	public Usuario login(String login, String senha) {
		return uc.login(login, senha);
	}
	
	public void createTarefa(String descricao, Calendar vencimento) {
		tc.createTarefa(descricao, vencimento);
	}
	
	public Collection<Tarefa> getTarefas() {
		return tc.getTarefas();
	}
}