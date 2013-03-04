package br.ufpb.esa.project.scrum.controllers;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.TaskDao;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.Status;
import br.ufpb.esa.project.scrum.model.Task;

@Resource
public class TasksController {
	private final Result result;
	private final TaskDao tDao;
	
	private final ProjectDao pDao;
	private final UserDao uDao;

	public TasksController(ProjectDao pDao, TaskDao tDao, UserDao uDao, Result result) {
		this.pDao = pDao;
		this.tDao = tDao;
		this.uDao = uDao;
		this.result = result;
	}

	@Post("projects/{projectId}/tasks")
	@Limited
	public void save(Long projectId, Task task, String status) {
		System.out.println("------------- " + status + "------------");
		
		if(status.equalsIgnoreCase("todo"))
			task.setStatus(Status.TODO);
		else if(status.equalsIgnoreCase("doing"))
			task.setStatus(Status.DOING);
		else if(status.equalsIgnoreCase("done"))
			task.setStatus(Status.DONE);
		
		task.setProject(pDao.load(projectId));
		pDao.load(projectId).getTasks().add(task);
		pDao.update(pDao.load(projectId));
		result.redirectTo(ProjectsController.class).showProject(projectId);
	}
	
	@Post("/projects/{projectId}/tasks/edit")
	public void edit(Long projectId, Long taskId, Task task) {
		Task t = tDao.load(taskId);
		t.setDescription(task.getDescription());
		tDao.update(t);
		
		result.redirectTo(ProjectsController.class).showProject(projectId);
	}
	
	@Post("/projects/{projectId}/tasks/moveto")
	public void changeStatus(Long projectId, Long taskId, String taskStatus) {
		Task t = tDao.load(taskId);
		if(taskStatus.equalsIgnoreCase("todo"))
			t.setStatus(Status.TODO);
		else if(taskStatus.equalsIgnoreCase("doing"))
			t.setStatus(Status.DOING);
		else if(taskStatus.equalsIgnoreCase("done"))
			t.setStatus(Status.DONE);
		
		tDao.update(t);
		result.redirectTo(ProjectsController.class).showProject(projectId);
	}
	
	@Path("/projects/{projectId}/tasks/delete/{id}")
	@Limited
	public void delete(Long projectId, Long id) {
		Task task = tDao.load(id);
		task.setResponsible(null);
		pDao.load(projectId).getTasks().remove(task);
		tDao.delete(task);
		result.redirectTo(ProjectsController.class).showProject(projectId);
	}
	
	@Path("/projects/{projectId}/tasks/{taskId}/responsible/{loggedId}")
	@Limited
	public void addResponsability(Long projectId, Long taskId, Long loggedId) {
		Task task = tDao.load(taskId);
		tDao.load(task.getId()).setResponsible(uDao.load(loggedId));
		tDao.update(task);
		result.redirectTo(ProjectsController.class).showProject(projectId);
	}
}