package br.ufpb.esa.project.scrum.controllers;

import static br.com.caelum.vraptor.view.Results.json;

import org.hibernate.exception.ConstraintViolationException;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.components.UserSession;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.TaskDao;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.User;

@Resource
public class UsersController {
	private final UserDao uDao;
	private final Result result;
	private final ProjectDao pDao;
	private final TaskDao tDao;
	private UserSession userSession;
	
	public UsersController(UserSession userSession, UserDao uDao, ProjectDao pDao, TaskDao tDao, Result result) {
		this.userSession = userSession;
		this.uDao = uDao;
		this.pDao = pDao;
		this.tDao = tDao;
		this.result = result;
	}
	
	@Post("/users")
	public void save(User user) {
		try {
			uDao.save(user);
		} catch(ConstraintViolationException e) {
			
		} finally {
			result.redirectTo(LoginController.class).loginForm();
		}
	}
	
	@Post("/users/edit/{userSessionId}")
	public void edit(String passwordAtual, Long userSessionId, User user) {
		if(passwordAtual.equals(userSession.getUser().getPassword())) {
			userSession.getUser().setName(user.getName());
			userSession.getUser().setEmail(user.getEmail());
			userSession.getUser().setLogin(user.getLogin());
			userSession.getUser().setPassword(user.getPassword());
			uDao.update(userSession.getUser());
		}
		
		result.redirectTo(ProjectsController.class).list(userSessionId, user.getProjects());
	}
	
	@Get("/users/delete/{userSessionId}")
	@Limited
	public void delete(Long userSessionId) {
		User logged = uDao.load(userSessionId);
		userSession.logout();
		
		logged.getProjects().removeAll(logged.getProjects());
		uDao.update(logged);
		
		uDao.delete(logged);
		result.redirectTo(LoginController.class).logout();
	}
	
	@Get("/users/search.json")
	public void search(String login) {
		result.use(json()).from(uDao.search(login)).exclude("id", "name", "email", "password", "projects").serialize();
	}
}