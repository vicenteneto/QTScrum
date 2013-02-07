package br.ufpb.esa.project.scrum.components;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.SessionScoped;
import br.ufpb.esa.project.scrum.model.User;

@Component
@SessionScoped
public class UserSession {
	private User logged;

	public Long getId() {
		return logged.getId();
	}
	public String getName() {
		return logged.getName();
	}
	public void login(User user) {
		this.logged = user;
	}
	public boolean isLogged() {
		return logged != null;
	}
	public void logout() {
		this.logged = null;
	}
}