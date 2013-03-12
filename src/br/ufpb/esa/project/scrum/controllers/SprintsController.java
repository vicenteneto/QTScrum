package br.ufpb.esa.project.scrum.controllers;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.jdbc.dao.ProjectDao;
import br.ufpb.esa.project.scrum.jdbc.dao.SprintDao;
import br.ufpb.esa.project.scrum.model.Sprint;

@Resource
public class SprintsController {
	private final ProjectDao pDao;
	private final SprintDao sDao;
	private final Result result;

	public SprintsController(ProjectDao pDao, SprintDao sDao, Result result) {
		this.pDao = pDao;
		this.sDao = sDao;
		this.result = result;
	}

	@Get("/projects/{projectId}/sprints/{index}")
	@Limited
	public void save(Long projectId, int index) {
		Sprint sprint = new Sprint();
		sprint.setName("Sprint " + (pDao.load(projectId).getSprints().size() + 1));
		sprint.setProject(pDao.load(projectId));
		pDao.load(projectId).getSprints().add(sprint);
		sDao.save(sprint);
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
	
	@Get("/users/{userSessionId}/projects/{projectId}/sprints")
	@Limited
	public void alteraSprint(Long userSessionId, Long projectId, int index) {
		result.redirectTo(ProjectsController.class).showProject(projectId, index);
	}
	
	@Get("/sprints/{sprintId}/tasks/search.json")
	@Limited
	public void search(Long sprintId) {
		result.use(Results.json()).withoutRoot().from(sDao.load(sprintId).getTasks()).serialize();
	}
}