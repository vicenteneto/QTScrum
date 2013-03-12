package br.ufpb.esa.project.scrum.controllers;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.Project;
import br.ufpb.esa.project.scrum.model.Sprint;
import br.ufpb.esa.project.scrum.model.User;

@Resource
public class ProjectsController {
	private final Result result;
	private final ProjectDao pDao;
	private final UserDao uDao;

	public ProjectsController(ProjectDao pDao, UserDao uDao, Result result) {
		this.pDao = pDao;
		this.uDao = uDao;
		this.result = result;
	}

	@Post("/users/{userSessionId}/projects")
	@Limited
	public void save(Long userSessionId, Project project) {
		Sprint sprint = new Sprint();
		sprint.setName("Sprint 1");
		sprint.setDataCriacao(Calendar.getInstance	());
		sprint.setProject(project);
		project.getSprints().add(sprint);
		uDao.load(userSessionId).getProjects().add(project);
		pDao.save(project);
		result.redirectTo(this).list(userSessionId, uDao.load(userSessionId).getProjects());
	}
	
	@Post("/users/{userSessionId}/projects/edit")
	public void edit(Long userSessionId, Long projectId, Project project) {
		Project p = pDao.load(projectId);
		p.setName(project.getName());
		pDao.update(p);
		
		result.redirectTo(ProjectsController.class).list(userSessionId, uDao.load(userSessionId).getProjects());
	}
	
	@Get("/users/{userSessionId}/projects/delete/{projectId}")
	@Limited
	public void delete(Long userSessionId, Long projectId) {
		Project project = pDao.load(projectId);
		
		project.getSprints().removeAll(project.getSprints());
		
		project = pDao.load(projectId);
		project.getParticipants().removeAll(project.getParticipants());
		pDao.update(project);
		
		result.redirectTo(this).list(userSessionId, uDao.load(userSessionId).getProjects());
	}
	
	@Get("/users/{userSessionId}/projects/{projectId}/sprints/{index}")
	@Limited
	public void showProject(Long projectId, int index) {
		result.include("i", index);
		Calendar data = pDao.load(projectId).getSprints().get(index).getDataCriacao();
		result.include("dataCriacao", new SimpleDateFormat("MM/dd/yyyy").format(data.getTime()));
		result.include("project", pDao.load(projectId));
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
		
		result.redirectTo(this).showProject(projectId, 1);
	}
	
	@Get("/users/{userSessionId}/projects")
	@Limited
	public List<Project> list(Long userSessionId, List<Project> projects) {
		return uDao.load(userSessionId).getProjects();
	}
}