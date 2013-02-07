package br.ufpb.esa.project.scrum.controllers;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Resource;
import br.ufpb.esa.project.scrum.annotations.Limited;

@Resource
public class IndexController {
	@Get("/")
	@Limited
	public void index() { }	
}