package br.ufpb.esa.project.scrum.controllers;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.User;

@Resource
public class UsersController {
	private final UserDao dao;
	private final Result result;
	
	public UsersController(UserDao dao, Result result) {
		this.dao = dao;
		this.result = result;
	}

	@Get("/users/new")
	public void newUser() { }
	
	@Post("/users")
	public void save(User user) {
		dao.save(user);
		result.redirectTo(LoginController.class).loginForm();
	}
}