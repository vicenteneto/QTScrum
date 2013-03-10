package br.ufpb.esa.project.scrum.components;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.apache.commons.io.IOUtils;

import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.Component;

@Component
public class Imagens {
	private File pastaImagens;

	public Imagens(ServletContext context) {
		String caminhoImagens = context.getRealPath("/img/user");
		pastaImagens = new File(caminhoImagens);
		pastaImagens.mkdir();
	}

	public void salva(UploadedFile imagem, Long id) {
		File destino = new File(pastaImagens, id + ".imagem");
		try {
			IOUtils.copy(imagem.getFile(), new FileOutputStream(destino));
		} catch (IOException e) {
			throw new RuntimeException("Erro ao copiar imagem", e);
		}
	}

	public File mostra(Long id) {
		return new File(pastaImagens, id + ".imagem");
	}
}