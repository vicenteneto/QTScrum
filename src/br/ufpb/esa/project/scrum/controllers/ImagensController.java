package br.ufpb.esa.project.scrum.controllers;

import java.io.File;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.ufpb.esa.project.scrum.components.Imagens;
import br.ufpb.esa.project.scrum.jdbc.dao.UserDao;

@Resource
public class ImagensController {
	private Imagens imagens;
	private Result result;
	private Validator validator;
	private UserDao uDao;

	public ImagensController(UserDao uDao, Imagens imagens, Result result, Validator validator) {
		this.uDao = uDao;
		this.imagens = imagens;
		this.result = result;
		this.validator = validator;
	}

	@Post("/users/{userSessionId}/imagem")
	public void upload(Long userSessionId, final UploadedFile imagem) {
		imagens.salva(imagem, userSessionId);
		result.redirectTo(ProjectsController.class).list(userSessionId, uDao.load(userSessionId).getProjects());
	}

	@Get("/users/{userSessionId}/imagem")
	public File download(Long userSessionId) {
		return imagens.mostra(userSessionId);
	}
}