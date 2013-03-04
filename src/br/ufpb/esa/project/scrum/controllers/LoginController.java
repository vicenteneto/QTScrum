package br.ufpb.esa.project.scrum.controllers;

import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.components.UserSession;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.Project;
import br.ufpb.esa.project.scrum.model.User;

@Resource
public class LoginController {
	private final UserDao dao;
	private final Result result;
	private final UserSession userSession;
	private final Validator validator;
	
	public LoginController(UserDao dao, Result result, UserSession userSession, Validator validator) {
		this.dao = dao;
		this.result = result;
		this.userSession = userSession;
		this.validator = validator;
	}
	
	@Get("/login")
	public void loginForm() { }

	@Post("/login")
	public void login(User user) {
		User loaded = dao.load(user);
	    if (loaded == null)
	    	validator.add(new ValidationMessage("Login e/ou senha inválidos", "user.login"));
	    
	    validator.onErrorUsePageOf(this).loginForm();

		userSession.login(loaded);
		List<Project> projects = loaded.getProjects();
		if(projects == null)
			projects = new ArrayList<Project>();
		result.redirectTo(ProjectsController.class).list(userSession.getUser().getId(), projects);
	}
	
	@Path("/logout")
	@Limited
	public void logout() {
		userSession.logout();
		result.redirectTo(this).loginForm();
	}
}