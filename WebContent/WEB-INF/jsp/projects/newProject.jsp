<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New Project | QTS - Quadro de Tarefas do Scrum</title>
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/style.css">
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery.validate.min.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/messages.js"></script>
</head>

<body>
	<%@include file="../default/header.jsp" %>
	<div class="container-fluid" id="div1">
		<div class="thumbnail">
			<div class="well">
				<div class="row">
					<div class="span7">
						<form class="form-horizontal" action="<c:url value='/projects' />" method="post">
							<fieldset>
								<legend><i class="icon-plus"></i> Criar Projeto</legend>
								<div class="control-group">
									<label class="control-label" for="name">Name</label>
									<div class="controls">
										<input class="input-xlarge" type="text" name="project.name" id="name" />
									</div>
								</div>
								<div class="form-actions">
									<input type="hidden" value="${userSession.id}" />
									<button type="submit" class="btn btn-primary"><i class="icon-plus icon-white"></i> Criar</button>
									<button type="reset" class="btn btn-danger"><i class="icon-tag icon-white"></i> Limpar</button>
								</div>
							</fieldset>
						</form>
						<div>
							<a class="btn" href="<c:url value='/projects' />"><i class="icon-arrow-left"></i> Voltar</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>