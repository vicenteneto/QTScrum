<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Projects | QTS - Quadro de Tarefas do Scrum</title>
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/style.css">
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.min.js"></script>
</head>

<body>
	<%@include file="../default/header.jsp" %>

	<div class="container-fluid" id="div1">
		<div class="thumbnail">
			<div class="well">
				<div class="row">
					<div class="span7">
						<form class="form-horizontal" id="formularioTarefa" action='<c:url value="/tasks" />' method="post">
							<fieldset>
								<legend><i class="icon-comment"></i> Adicionar Tarefa</legend>
							
								<div class="control-group">
									<label class="control-label" for="description">Descrição:</label>
									<div class="controls">
										<textarea class="span5" id="description" name="task.description">${task.description}</textarea>
									</div>
								</div>
								
								<div class="form-actions">
									<button class="btn btn-primary" type="submit"><i class="icon-ok icon-white"></i> Adicionar</button>
									<a type="button" class="btn btn-danger" href='<c:url value="/" />'>
										<i class="icon-arrow-left icon-white"></i> Voltar
									</a>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>