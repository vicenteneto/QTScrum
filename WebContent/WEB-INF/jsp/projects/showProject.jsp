<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project | QTS - Quadro de Tarefas do Scrum</title>
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap-responsive.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/style.css">
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery-ui-1.10.1.custom.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery.validate.js"></script>
<script type="text/javascript">
    $(function(){
    	$("ul.droptrue").sortable({
	      	connectWith: "ul.droptrue",
	      	revert: true,
	      	receive: function(event, ui) {
	      		var status = 'todo';
	      		if($(this).attr("id") == 'ulDoing') {
	      			status = 'doing';
	      		}else if($(this).attr("id") == 'ulDone') {
	      			status = 'done';
	      		}
	      		$('#changeTaskId').val(ui.item.data('id'));
	      		$('#changeTaskStatus').val(status);
	      		$('#changeTaskForm').submit();
	      	}
		});
    	$("#ulToDo, #ulToDo li, #ulDoing, #ulDoing li, #ulDone, #ulDone li").disableSelection();

        $('#formNewTask').validate({
            rules:{
                "task.description": {
                    required: true,
                    minlength: 3
                }
            }
        });
        
        $('.linkEditTask').click(function () {
        	$('#editTaskId').val($(this).data('task'));
        	$('#editDescription').val($(this).data('description'));
        });
        
        var users = [];
        
        $.getJSON("${pageContext.request.contextPath}/users/search.json", function(json){
			$.each(eval(json), function(i, item){
				var jsonItem = eval(item);
				users.push(jsonItem.login);
			});
		});
        
        $("#login").data("source", users);
	 });
</script>
</head>

<body>
	<%@include file="../header.jsp" %>

	<div id="conteudo" class="container">
		<div class="row">
			<div class="well white">
				<ul class="nav nav-tabs">
					<li class="active">
						<a href="#tab1" data-toggle="tab"><i class="icon-tasks"></i> DashBoard</a>
					</li>
					<li>
						<a href="#tab2" data-toggle="tab"><i class="icon-refresh"></i> Sprints</a>
					</li>
					<li>
						<a href="#tab3" data-toggle="tab"><i class="icon-user"></i> Colaboradores</a>
					</li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
						<legend>${project.name}</legend>
						<div class="row-fluid">
							<div class="span4 ">
								<div class="thumbnail" style="background:#F8F8F8;">
									<center><legend><h4><i class="icon-question-sign"></i> To Do</h4></legend></center>
									
									<div class="well white">
										<ul id="ulToDo" class="nav nav-pills nav-stacked droptrue">
											<c:forEach items="${project.tasks}" var="task">
												<c:if test="${task.status == 'TODO'}">
													<li class="active dropdown" data-id="${task.id}">
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															${task.description}
															<c:if test="${not empty task.responsible}">
																(${task.responsible.name})
															</c:if>
															<span class="caret"></span>
														</a>
														<ul class="dropdown-menu">
															<c:if test="${empty task.responsible}">
																<li>
																	<a href='<c:url value="/projects/${project.id}/tasks/${task.id}/responsible/${userSession.user.id}"/>'>
																		<i class="icon-user"></i> Aceitar Responsabilidade
																	</a>
																</li>
															</c:if>
															<li>
																<a class="linkEditTask" href="#alterarTarefa" role="button" data-toggle="modal" data-task="${task.id}" data-description="${task.description}">
																	<i class="icon-edit"></i> Alterar
																</a>
															</li>
															<li class="divider"></li>
															<li>
																<a href="<c:url value='/projects/${project.id}/tasks/delete/${task.id}'/>">
																	<i class="icon-trash"></i> Delete
																</a>
															</li>
														</ul>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
									<a class="linkAddTask" href="#adicionarTarefaToDo" data-toggle="modal" data-status="todo"><i class="icon-plus-sign"></i> Adicionar Tarefa...</a>
								</div>
							</div>

							<div class="span4 ">
								<div class="thumbnail" style="background:#F8F8F8;">
									<center><legend><h4><i class="icon-ok-circle"></i> Doing</h4></legend></center>
									
									<div class="well white">
										<ul id="ulDoing" class="nav nav-pills nav-stacked droptrue">
											<c:forEach items="${project.tasks}" var="task">
												<c:if test="${task.status == 'DOING'}">
													<li class="active dropdown" data-id="${task.id}">
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															${task.description}
															<c:if test="${not empty task.responsible}">
																(${task.responsible.name})
															</c:if>
															<span class="caret"></span>
														</a>
														<ul class="dropdown-menu">
															<c:if test="${empty task.responsible}">
																<li>
																	<a href='<c:url value="/projects/${project.id}/tasks/${task.id}/responsible/${userSession.user.id}"/>'>
																		<i class="icon-user"></i> Aceitar Responsabilidade
																	</a>
																</li>
															</c:if>
															<li>
																<a class="linkEditTask" href="#alterarTarefa" role="button" data-toggle="modal" data-task="${task.id}" data-description="${task.description}">
																	<i class="icon-edit"></i> Alterar
																</a>
															</li>
															<li class="divider"></li>
															<li>
																<a href="<c:url value='/projects/${project.id}/tasks/delete/${task.id}'/>">
																	<i class="icon-trash"></i> Delete
																</a>
															</li>
														</ul>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
									<a href="#adicionarTarefaDoing" role="button" data-toggle="modal" data-status="doing"><i class="icon-plus-sign"></i> Adicionar Tarefa...</a>
								</div>
							</div>

							<div class="span4 ">
								<div class="thumbnail" style="background:#F8F8F8;">
									<center><legend><h4><i class="icon-ok"></i> Done</h4></legend></center>
									
									<div class="well white">
										<ul id="ulDone" class="nav nav-pills nav-stacked droptrue">
											<c:forEach items="${project.tasks}" var="task">
												<c:if test="${task.status == 'DONE'}">
													<li class="active dropdown" data-id="${task.id}">
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															${task.description}
															<c:if test="${not empty task.responsible}">
																(${task.responsible.name})
															</c:if>
															<span class="caret"></span>
														</a>
														<ul class="dropdown-menu">
															<c:if test="${empty task.responsible}">
																<li>
																	<a href='<c:url value="/projects/${project.id}/tasks/${task.id}/responsible/${userSession.user.id}"/>'>
																		<i class="icon-user"></i> Aceitar Responsabilidade
																	</a>
																</li>
															</c:if>
															<li>
																<a class="linkEditTask" href="#alterarTarefa" role="button" data-toggle="modal" data-task="${task.id}" data-description="${task.description}">
																	<i class="icon-edit"></i> Alterar
																</a>
															</li>
															<li class="divider"></li>
															<li>
																<a href="<c:url value='/projects/${project.id}/tasks/delete/${task.id}'/>">
																	<i class="icon-trash"></i> Delete
																</a>
															</li>
														</ul>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
									<a href="#adicionarTarefaDone" role="button" data-toggle="modal" data-status="done"><i class="icon-plus-sign"></i> Adicionar Tarefa...</a>
								</div>
							</div>
						</div>
						<br/>
					</div>
					<div class="tab-pane" id="tab2">
						<p>Panel 2</p>
					</div>
					<div class="tab-pane" id="tab3">
						<legend>${project.name}</legend>
						<div class="row-fluid">
							<div class="offset2 span8">
								<div class="well">
									<table class="table">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>E-Mail</th>
												<th>Login</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${project.participants}" var="participant" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td>${participant.name}</td>
													<td>${participant.email}</td>
													<td>${participant.login}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<hr>
									<div align="center">
										<a href="#adicionarParticipante" role="button" data-toggle="modal"><i class="icon-user"></i> Adicionar Colaborador</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<br />
				<div>
					<a class="btn" href="<c:url value='/users/${userSession.user.id}/projects' />"><i class="icon-arrow-left"></i> Voltar</a>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="../addtarefa.jsp" %>
	
	<!-- Alterar Tarefa -->
	<div id="alterarTarefa" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="alterarTarefaLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="alterarTarefaLabel">Editar Tarefa</h3>
  		</div>
  		<form class="form-horizontal" id="formEditTask" action='<c:url value="/projects/${project.id}/tasks/edit" />' method="post">
			<fieldset>
				<div class="modal-body">
					<label class="control-label" for="editDescription">Descrição:</label>
					<div class="controls">
						<textarea class="span3" id="editDescription" name="task.description" maxlength="255">${task.description}</textarea>
					</div>
				</div>
				
				<div class="modal-footer">
					<input id="editTaskId" type="hidden" name="taskId" />
					<button class="btn" data-dismiss="modal" aria-hidden="true">Fechar</button>
					<button class="btn btn-primary" type="submit">Atualizar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<!-- Altera Status Form -->
	<form id="changeTaskForm" action='<c:url value="/projects/${project.id}/tasks/moveto" />' method="post">
		<input id="changeTaskId" type="hidden" name="taskId" />
		<input id="changeTaskStatus" type="hidden" name="taskStatus" />
	</form>
	
	<!-- Adicionar Participante -->
	<div id="adicionarParticipante" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="adicionarParticipanteLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="adicionarParticipanteLabel">Adicionar Colaborador</h3>
  		</div>
  		<form id="formAdicionarParticipante" class="form-horizontal" action='<c:url value="/users/${userSession.user.id}/projects/${project.id}/addparticipant" />' method="post">
			<fieldset>
				<div class="modal-body">
					<div class="control-group">
						<label class="control-label" for="login">Login</label>
						<div class="controls">
							<input class="input-xlarge" type="text" name="login" id="login" style="margin: 0 auto;" data-provide="typeahead" data-items="4" data-source='["Alabama","Alaska"]'>
							<br /><br /><br /><br /><br />
						</div>
					</div>
				</div>
				<p/>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal" aria-hidden="true">Fechar</button>
					<button class="btn btn-primary" type="submit">Adicionar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<%@include file="../minhaconta.jsp" %>
</body>
</html>