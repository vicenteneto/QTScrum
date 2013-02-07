<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cadastre-se | QTS - Quadro de Tarefas do Scrum</title>
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
						<form class="form-horizontal" action="<c:url value='/users' />" method="post">
							<fieldset>
								<legend><i class="icon-user"></i> Cadastre-se</legend>
								<div class="control-group">
									<label class="control-label" for="name">Nome</label>
									<div class="controls">
										<input class="input-xlarge" type="text" name="user.name" id="name" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="email">E-mail</label>
									<div class="controls">
										<input class="input-xlarge" type="text" name="user.email" id="email" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="login">Login</label>
									<div class="controls">
										<input class="input-xlarge" type="text" name="user.login" id="login" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="password">Password</label>
									<div class="controls">
										<input class="input-xlarge" type="password" name="user.password" id="password" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="confirmacao">Confirme o password</label>
									<div class="controls">
										<input class="input-xlarge" type="password" id="confirmacao" />
									</div>
								</div>
								<div class="form-actions">
									<button class="btn btn-primary" type="submit"><i class="icon-ok icon-white"></i> Cadastrar</button>
									<button type="reset" class="btn btn-danger"><i class="icon-tag icon-white"></i> Limpar</button>
								</div>
							</fieldset>
						</form>
						<div>
							<a class="btn" href="<c:url value='/login' />"><i class="icon-ok-circle"></i> Login</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>