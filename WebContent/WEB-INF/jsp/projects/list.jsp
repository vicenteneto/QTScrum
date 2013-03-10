<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Projetos | QTS - Quadro de Tarefas do Scrum</title>
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap-responsive.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/style.css">
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery.validate.js"></script>
<script type="text/javascript">
    $(function(){
        $('#novoProjeto').on('shown', function () {
	        $('input:text:visible:first', this).focus();
	    });
        
        var foto = document.getElementById('foto');

        foto.style.cursor = 'pointer';
        foto.onclick = function() {
            $('#uploadFoto').modal('show');
        };
        
        $('.linkEditProject').click(function () {
        	$('#editProjectName').val($(this).data('name'));
        	$('#editProjectId').val($(this).data('id'));
        });
        
        $('#uploadFoto').on('shown', function () {
	        $('input:file:visible:first', this).focus();
	    });
    });
</script>
</head>

<body class="white">
	<%@include file="../header.jsp" %>

	<div id="conteudo" class="container">
		<div class="row">
			<div class="span8 thumbnail">
				<div class="well white">
					<legend><i class="icon-list-alt"></i> Meus Projetos</legend>
					<table class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<th><a href="#novoProjeto" role="button" data-toggle="modal"><i class="icon-plus"></i> Adicionar Projeto...</a></th>
							</tr>
						</thead>
						<tbody>
							<tr><td>
								<ul class="nav nav-pills nav-stacked" >
									<c:forEach items="${projectList}" var="projeto">
										<li class="active dropdown">
											<a class="dropdown-toggle" data-toggle="dropdown" href="#">
												<span class="caret"></span> ${projeto.name}
											</a>
											<ul class="dropdown-menu">
												<li><a href="<c:url value='/users/${userSession.user.id}/projects/${projeto.id}/sprints/0'/>"><i class="icon-list"></i> Ver Projeto</a></li>
												<li class="divider"></li>
												<li><a class="linkEditProject" data-id="${projeto.id}" data-name="${projeto.name}" href="#alterarProjeto" role="button" data-toggle="modal"><i class="icon-edit"></i> Editar</a></li>
												<li><a href="<c:url value='/users/${userSession.user.id}/projects/delete/${projeto.id}'/>"><i class="icon-trash"></i> Excluir</a></li>
											</ul>
										</li>
									</c:forEach>
								</ul>
							</td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="span3 thumbnail" align="center">
				<div class="well white">
					<legend>Perfil</legend>
					<img id="foto" class="img-rounded thumbnail" src="${pageContext.request.contextPath}/users/${userSession.user.id}/imagem" alt="no-photo" />
					<br />
					<strong>${userSession.user.name}</strong>
					<br /> <br />
					<div class="btn-group btn-group-vertical">
						<ul class="nav nav-pills nav-stacked">
							<li><a href="#minhaConta" role="button" class="btn" data-toggle="modal"><i class="icon-user"></i> Meus Dados</a></li>
							<li><a style="background:rgb(225, 85, 80);" href='<c:url value="/users/delete/${userSession.user.id}" />' role="button" class="btn" data-toggle="modal"><i class="icon-trash"></i> Excluir Minha Conta</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- New Project -->
	<div id="novoProjeto" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="novoProjetoLabel" aria-hidden="true">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="novoProjetoLabel">Criar Projeto</h3>
  		</div>
  		<form id="formNovoProjeto" class="form-horizontal" action="<c:url value='/users/${userSession.user.id}/projects' />" method="post">
			<fieldset>
				<div class="modal-body control-group">
					<label class="control-label" for="name">Nome</label>
					<div class="controls">
						<input id="name" class="input-xlarge required" minlength="3" maxlength="100" type="text" name="project.name" maxlength="100" />
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"><i class="icon-ok icon-white"></i> Criar</button>
					<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<!-- Alterar Projeto -->
	<div id="alterarProjeto" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="alterarProjetoLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="alterarProjetoLabel">Editar Projeto</h3>
  		</div>
  		<form class="form-horizontal" id="formEditProject" action='<c:url value="/users/${userSession.user.id}/projects/edit" />' method="post">
			<fieldset>
				<div class="modal-body">
					<label class="control-label" for="editDescription">Nome:</label>
					<div class="controls">
						<input class="input-xlarge required" type="text" id="editProjectName" name="project.name" maxlength="100" />
					</div>
				</div>
				
				<div class="modal-footer">
					<input id="editProjectId" type="hidden" name="projectId" />
					<button class="btn" data-dismiss="modal" aria-hidden="true">Fechar</button>
					<button class="btn btn-primary" type="submit">Atualizar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<!-- Upload Foto -->
	<div id="uploadFoto" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="uploadFotoLabel" aria-hidden="true">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="uploadFotoLabel">Alterar Foto</h3>
  		</div>
  		<form id="formUploadFoto" class="form-horizontal" action="${pageContext.request.contextPath}/users/${userSession.user.id}/imagem" method="post" enctype="multipart/form-data">
			<fieldset>
				<div align="center" class="modal-body">
					<input type="file" name="imagem" />
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"><i class="icon-upload icon-white"></i> Upload</button>
					<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<%@include file="../minhaconta.jsp" %>
</body>
</html>