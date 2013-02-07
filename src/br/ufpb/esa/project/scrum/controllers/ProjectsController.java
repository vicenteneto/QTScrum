package br.ufpb.esa.project.scrum.controllers;

import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;
import br.ufpb.esa.project.scrum.model.Project;

@Resource
public class ProjectsController {
	private final Result result;
	private final ProjectDao pDao;

	public ProjectsController(ProjectDao pDao, UserDao uDao, Result result) {
		this.pDao = pDao;
		this.result = result;
	}

	@Get("/projects/new")
	@Limited
	public void newProject() { }

	@Post("/projects")
	@Limited
	public void save(Project project) {
		pDao.save(project);
		result.redirectTo(this).list();
	}
	
	@Get("/projects/{id}")
	@Limited
	public Project show(Long id) {
		return pDao.load(id);
	}
	
	@Get("/projects/delete/{id}")
	@Limited
	public void delete(Long id) {
		pDao.delete(pDao.load(id));
		result.redirectTo(this).list();
	}

	@Get("/projects")
	@Limited
	public List<Project> list() {
		return pDao.listAll();
	}
}