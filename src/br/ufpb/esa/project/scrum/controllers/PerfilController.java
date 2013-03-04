package br.ufpb.esa.project.scrum.controllers;

import java.io.File;

import br.com.caelum.vraptor.Resource;

@Resource
public class PerfilController {
	public File foto(String login) {
		File file = new File("/br.ufpb.esa.project.scrum/img/user/" + login + ".jpg");
		if(file.exists())
			return file;
		return new File("/br.ufpb.esa.project.scrum/img/user/no-photo.png");
    }
}