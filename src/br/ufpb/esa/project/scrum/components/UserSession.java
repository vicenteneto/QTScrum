package br.ufpb.esa.project.scrum.components;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.SessionScoped;
import br.ufpb.esa.project.scrum.model.User;

@Component
@SessionScoped
public class UserSession {
    private User user;

    public boolean isLogged() {
        return user != null;
    }
    public void logout() {
        user = null;
    }
    public void login(User user) {
    	this.user = user;
    }
    public User getUser() {
    	return user;
    }
}