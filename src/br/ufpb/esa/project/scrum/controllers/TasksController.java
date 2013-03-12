package br.ufpb.esa.project.scrum.controllers;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.SprintDao;
import br.ufpb.esa.project.scrum.jdbc.dao.TaskDao;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.Status;
import br.ufpb.esa.project.scrum.model.Task;

@Resource
public class TasksController {
	private final Result result;
	private final TaskDao tDao;
	
	private final UserDao uDao;
	private SprintDao sDao;
	private ProjectDao pDao;

	public TasksController(ProjectDao pDao, SprintDao sDao, TaskDao tDao, UserDao uDao, Result result) {
		this.pDao = pDao;
		this.sDao = sDao;
		this.tDao = tDao;
		this.uDao = uDao;
		this.result = result;
	}

	@Post("projects/{projectId}/sprints/{index}/tasks")
	@Limited
	public void save(Long projectId, int index, Task task) {
		task.setStatus(Status.TODO);
		task.setSprint(pDao.load(projectId).getSprints().get(index));
		pDao.load(projectId).getSprints().get(index).getTasks().add(task);
		sDao.update(pDao.load(projectId).getSprints().get(index));
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
	
	@Post("/projects/{projectId}/sprints/{index}/tasks/edit")
	public void edit(Long projectId, int index, Long taskId, Task task) {
		Task t = tDao.load(taskId);
		t.setDescription(task.getDescription());
		tDao.update(t);
		
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
	
	@Post("/projects/{projectId}/sprints/{index}/tasks/moveto")
	public void changeStatus(Long projectId, int index, Long taskId, String taskStatus) {
		Task t = tDao.load(taskId);
		if(taskStatus.equalsIgnoreCase("todo")) {
			t.setStatus(Status.TODO);
			t.setDone("");
		} else if(taskStatus.equalsIgnoreCase("doing")) {
			t.setStatus(Status.DOING);
			t.setDone("");
		} else if(taskStatus.equalsIgnoreCase("done")) {
			t.setStatus(Status.DONE);
			t.setDone(new SimpleDateFormat("MM/dd/yyyy").format(Calendar.getInstance().getTime()));
		}
		
		tDao.update(t);
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
	
	@Path("/projects/{projectId}/sprints/{index}/tasks/delete/{id}")
	@Limited
	public void delete(Long projectId, int index, Long id) {
		Task task = tDao.load(id);
		task.setResponsible(null);
		pDao.load(projectId).getSprints().get(index).getTasks().remove(task);
		tDao.delete(task);
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
	
	@Path("/projects/{projectId}/sprints/{index}/tasks/{taskId}/responsible/{loggedId}")
	@Limited
	public void addResponsability(Long projectId, int index, Long taskId, Long loggedId) {
		Task task = tDao.load(taskId);
		tDao.load(task.getId()).setResponsible(uDao.load(loggedId));
		tDao.update(task);
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
}