package br.ufpb.esa.project.scrum.controllers;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.components.UserSession;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.User;

@Resource
public class LoginController {
	private final UserDao dao;
	private final Result result;
	private UserSession userSession;
	
	public LoginController(UserDao dao, Result result, UserSession userSession) {
		this.dao = dao;
		this.result = result;
		this.userSession = userSession;
	}
	
	@Get("/login")
	public void loginForm() { }

	@Post("/login")
	public void login(User user) {
		userSession.login(dao.load(user));
		result.redirectTo(ProjectsController.class).list();
	}
	
	@Path("/logout")
	@Limited
	public void logout() {
		userSession.logout();
		result.redirectTo(this).loginForm();
	}
}