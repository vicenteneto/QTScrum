<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login | QTS - Quadro de Tarefas do SCRUM</title>
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap-responsive.css" />
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/style.css" />

<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery.validate.js"></script>
<script type="text/javascript">
	$(function() {
		$('#formLogin').validate({
	        rules: {
	            "user.login": {
	                required: true,
	                minlength: 3
	            },
	            "user.password": {
	                required: true,
	                minlength: 3
	            }
	        }
	    });
	
	    $('#formNewUser').validate({
	        rules: {
	            "user.email": {
	                required: true,
	                email: true,
	                minlength: 3
	            },
	            "user.login": {
	                required: true,
	                minlength: 3
	            },
	            "user.password": {
	                required: true,
	                minlength: 3
	            },
	            "confirmacao": {
	                required: true,
	                minlength: 3,
	                equalTo: "#userPassword"
	            }
	        }
	    });
	    
	    $('#newUser').on('shown', function () {
	        $('input:text:visible:first', this).focus();
	    });
	});
</script>
</head>
<body>
	<%@include file="../header.jsp" %>
	
	<div id="divLogin" class="container">
		<div class="row">
			<div class="span6">
				<div class="thumbnail">
					<div class="well white">
						<form id="formLogin" class="form-horizontal" action="<c:url value='/login' />" method="post">
							<fieldset>
								<legend>Login | QTS - Quadro de Tarefas do Scrum</legend>
								<div class="control-group">
									<label class="control-label" for="login">Login</label>
									<div class="controls">
										<input id="login" class="input-large" type="text" name="user.login" maxlength="10" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="password">Senha</label>
									<div class="controls">
										<input id="password" class="input-large" type="password" name="user.password" maxlength="10" />
									</div>
								</div>
								<div class="form-actions">
									<button type="submit" class="btn btn-primary"><i class="icon-ok-circle icon-white"></i> Entrar</button>
									<button type="reset" class="btn btn-danger"><i class="icon-tag icon-white"></i> Limpar</button>
								</div>
							</fieldset>
						</form>
						<div>
	   						<a href="#newUser" class="btn" data-toggle="modal"><i class="icon-user"></i> Cadastre-se</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- NewUser Modal -->
    <div id="newUser" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="newUserLabel" aria-hidden="true">
	    <div class="modal-header">
		    <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
		    <h3 id="newUserLabel">Cadastre-se</h3>
	    </div>
	    
		<form id="formNewUser" class="form-horizontal" action="<c:url value='/users' />" method="post">
			<fieldset>
				<div class="modal-body">
					<div class="control-group">
						<label class="control-label" for="userName">Nome</label>
						<div class="controls">
							<input id="userName" class="input-xlarge" type="text" name="user.name" maxlength="100" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="userEmail">E-mail</label>
						<div class="controls">
							<input id="userEmail" class="input-xlarge required" type="text" name="user.email" maxlength="100" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="userLogin">Login</label>
						<div class="controls">
							<input id="userLogin" class="input-xlarge required" type="text" name="user.login" maxlength="10" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="userPassword">Senha</label>
						<div class="controls">
							<input id="userPassword" class="input-xlarge required" type="password" name="user.password" maxlength="10" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="confirmacao">Confirmar senha</label>
						<div class="controls">
							<input id="confirmacao" class="input-xlarge required" type="password" name="confirmacao" maxlength="10" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"><i class="icon-ok icon-white"></i> Cadastrar</button>
					<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
				</div>
			</fieldset>
		</form>
    </div>
</body>
</html>