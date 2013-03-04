package br.ufpb.esa.project.scrum.controllers;

import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.components.UserSession;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.Project;
import br.ufpb.esa.project.scrum.model.User;

@Resource
public class ProjectsController {
	private final Result result;
	private final ProjectDao pDao;
	private final UserDao uDao;
	private UserSession userSession;

	public ProjectsController(UserSession userSession, ProjectDao pDao, UserDao uDao, Result result) {
		this.userSession = userSession;
		this.pDao = pDao;
		this.uDao = uDao;
		this.result = result;
	}

	@Post("/users/{userSessionId}/projects")
	@Limited
	public void save(Long userSessionId, Project project) {
		uDao.load(userSessionId).getProjects().add(project);
		pDao.save(project);
		result.redirectTo(this).list(userSessionId, uDao.load(userSessionId).getProjects());
	}
	
	@Get("/users/{userSessionId}/projects/delete/{projectId}")
	@Limited
	public void delete(Long userSessionId, Long projectId) {
		Project project = pDao.load(projectId);
		
		project.getTasks().removeAll(project.getTasks());
		
		project = pDao.load(projectId);
		project.getParticipants().removeAll(project.getParticipants());
		pDao.update(project);
		
		result.redirectTo(this).list(userSessionId, uDao.load(userSessionId).getProjects());
	}
	
	@Get("/users/{userSessionId}/projects/{projectId}")
	@Limited
	public Project showProject(Long projectId) {
		return pDao.load(projectId);
	}

	@Get("/users/{userSessionId}/projects/{projectId}/addparticipant")
	@Limited
	public Project formAddParticipant(Long projectId) {
		return pDao.load(projectId);
	}
	
	@Post("/users/{userSessionId}/projects/{projectId}/addparticipant")
	@Limited
	public void addParticipant(Long userSessionId, Long projectId, String login) {
		List<User> users = uDao.listAll();
		users.remove(uDao.load(userSessionId));
		Project project = pDao.load(projectId);
		
		for (User user: users)
			if(user.getLogin().equalsIgnoreCase(login)) {
				user.getProjects().add(project);
				uDao.update(user);
			}
		
		result.redirectTo(this).showProject(projectId);
	}
	
	@Get("/users/{userSessionId}/projects")
	@Limited
	public List<Project> list(Long userSessionId, List<Project> projects) {
		return uDao.load(userSessionId).getProjects();
	}
}