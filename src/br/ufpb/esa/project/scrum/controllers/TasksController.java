package br.ufpb.esa.project.scrum.controllers;

import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.jdbc.dao.TaskDao;
import br.ufpb.esa.project.scrum.model.Task;

@Resource
public class TasksController {
	private final Result result;
	private final TaskDao tDao;

	public TasksController(TaskDao tDao, Result result) {
		this.tDao = tDao;
		this.result = result;
	}
	
	@Get("/tasks/new")
	@Limited
	public void newTask() { }
	
	@Post("/tasks")
	@Limited
	public void save(Task task) {
		tDao.save(task);
		result.redirectTo(ProjectsController.class).list();
	}
	
	@Get("/tasks/delete/{id}")
	@Limited
	public void delete(Long id) {
		tDao.delete(tDao.load(id));
		result.redirectTo(this).list();
	}

	@Get("/tasks")
	@Limited
	public List<Task> list() {
		return tDao.listAll();
	}
	
	@Get("tasks/list.json")
    public void lista() {
        List<Task> tarefas = tDao.listAll();
        result.use(Results.json()).withoutRoot().from(tarefas).serialize();
    }
}