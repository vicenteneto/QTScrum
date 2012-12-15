package br.ufpb.esa.project.scrum.tests;

import static org.junit.Assert.assertEquals;

import java.util.Collection;
import java.util.GregorianCalendar;

import org.junit.BeforeClass;
import org.junit.Test;

import br.ufpb.esa.project.scrum.controller.UsuarioController;
import br.ufpb.esa.project.scrum.model.Usuario;

public class TestUsuarioController {
	@BeforeClass
	public static void createUsuarios() {
		UsuarioController uc = new UsuarioController();
		
		uc.createUsuario("Vicente Neto", new GregorianCalendar(1991, 10, 21), "vicente.neto@dce.ufpb.br", "vnetort", "vnetort");
		uc.createUsuario("Huguinho", new GregorianCalendar(2012, 12, 15), "huguinho@gmail.com", "huguinho", "huguinho");
		uc.createUsuario("Zezinho", new GregorianCalendar(2012, 12, 15), "zezinho@gmail.com", "zezinho", "zezinho");
		uc.createUsuario("Luizinho", new GregorianCalendar(2012, 12, 15), "luizinho@gmail.com", "luizinho", "luizinho");
	}
	
	@Test
	public void testReadUsuario() {
		UsuarioController uc = new UsuarioController();

		Usuario uId = uc.readUsuarioById(1L);
		assertEquals("Vicente Neto", uId.getNome());
		
		Usuario uEmail = uc.readUsuarioByEmail("huguinho@gmail.com");
		assertEquals("Huguinho", uEmail.getNome());
		
		Usuario uLogin = uc.readUsuarioByLogin("zezinho");
		assertEquals("Zezinho", uLogin.getNome());
	}
	
	@Test
	public void testGetUsuarios() {
		UsuarioController uc = new UsuarioController();

		Collection<Usuario> usuarios = uc.getUsuarios();
		assertEquals(4, usuarios.size());
	}
	
	@Test
	public void testDeleteUsuario() {
		UsuarioController uc = new UsuarioController();

		uc.deleteUsuarioById(1L);
		uc.deleteUsuarioByEmail("huguinho@gmail.com");
		uc.deleteUsuarioByLogin("zezinho");
		
		Collection<Usuario> usuarios = uc.getUsuarios();
		assertEquals(1, usuarios.size());
	}
	
	@Test
	public void testLogin() {
		UsuarioController uc = new UsuarioController();

		Usuario u = uc.login("luizinho", "luizinho");
		assertEquals("Luizinho", u.getNome());
	}
}