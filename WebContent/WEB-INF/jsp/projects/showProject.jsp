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
<style>
.navbar-search {
    position: relative;
    width: 200px;
}
.navbar-search .search-query {
    padding-left: 29px !important;
}
.navbar-search .icon-search {
    position: absolute;
    top: 7px;
    left: 11px;
    background-image: url("http://twitter.github.com/bootstrap/assets/img/glyphicons-halflings.png");
}
</style>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery-ui-1.10.1.custom.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jquery.validate.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/plugins/jsapi.js"></script>
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
        
        $('.linkEditTask').click(function () {
        	$('#editTaskId').val($(this).data('task'));
        	$('#editDescription').val($(this).data('description'));
        });
        
        $('.linkSprint').click(function () {
        	$('#sprintIndex').val($(this).data('index'));
        	$('#sprintForm').submit();
        });
        
        var users = [];
        
        $.getJSON("${pageContext.request.contextPath}/users/search.json", function(json){
			$.each(eval(json), function(i, item){
				var jsonItem = eval(item);
				users.push(jsonItem.login);
			});
		});
        
        $("#login").data("source", users);
        
        $('#adicionarTarefa').on('shown', function () {
	        $('textarea:visible:first', this).focus();
	    });
        
        $('#alterarTarefa').on('shown', function () {
	        $('textarea:visible:first', this).focus();
	    });
        
        $('#adicionarParticipante').on('shown', function () {
	        $('input:text:visible:first', this).focus();
		});
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
						<a href="#tab2" data-toggle="tab"><i class="icon-user"></i> Colaboradores</a>
					</li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
						<legend>${project.name} - ${project.sprints[i].name}</legend>
						<div class="row-fluid">
							<div class="span7">
								<div class="btn-group">
									<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
										Sprints
										<span class="caret"></span>
									</a>
									<ul class="dropdown-menu">
										<c:forEach items="${project.sprints}" var="sprint" varStatus="status">
											<li>
												<a href="<c:url value='/users/${userSession.user.id}/projects/${project.id}/sprints/${status.count-1}'/>">
													<i class="icon-tasks"></i> ${sprint.name}
												</a>
											</li>
										</c:forEach>
									</ul>
								</div>
								<a class="btn btn-info" href='<c:url value="/projects/${project.id}/sprints/${i}" />'><i class="icon-plus icon-white"></i> Nova Sprint</a>
								<form class="navbar-search pull-right" action='javascript:buscarTarefas();'>
					                <input type="text" id="query" class="search-query" placeholder="Buscar Tarefas" />
					                <input type="hidden" id="sprintId" value="${project.sprints[i].id}" />
					                <div class="icon-search"></div>
						        </form>
						        <script type="text/javascript">
						        	function buscarTarefas() {
						        		$('#modalBuscarTarefas').modal('show');
						        		var tasks = [];
						        		$.getJSON("${pageContext.request.contextPath}/sprints/"+ $('#sprintId').val() + "/tasks/search.json", function(json){
											$.each(eval(json), function(i, item){
												var jsonItem = eval(item);
												if(jsonItem.description.contains($('#query').val())) {
													tasks.push(jsonItem);
												}
											});
										}).then(function() {
											var bodySearch = $('#bodySearch');
											bodySearch.empty();
											if(tasks.length == 0) {
												bodySearch.append($('<td colspan="3">').html('Nenhuma tarefa encontrada'));
											}
											for (var i = 0; i < tasks.length; i++) {
												var tr = $('<tr>');
												bodySearch.append(tr);
												tr.append($('<td>').html((i+1)));
												tr.append($('<td>').html(tasks[i].description));
												tr.append($('<td>').html(tasks[i].status));
											}
										});
						        	}
						        </script>
							</div>
							<div class="span5">
								<a class="visualizarBurndown btn btn-info pull-right" href="#visualizarBurndown" role="button" data-toggle="modal" data-sprintid="${project.sprints[i].id}" data-data="${dataCriacao}">
									Visualizar Burndown
								</a>
							</div>
						</div>
						<br/>
						<div class="row-fluid">
							<div class="span4 ">
								<div class="thumbnail" style="background:#F8F8F8;">
									<center><legend><h4><i class="icon-question-sign"></i> To Do</h4></legend></center>
									
									<div class="well white">
										<ul id="ulToDo" class="nav nav-pills nav-stacked droptrue">
											<c:forEach items="${project.sprints[i].tasks}" var="task">
												<c:if test="${task.status == 'TODO'}">
													<li class="active dropdown" data-id="${task.id}">
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															<span class="caret"></span>
															${task.description}
															<c:if test="${not empty task.responsible}">
																(${task.responsible.name})
															</c:if>
														</a>
														<ul class="dropdown-menu">
															<c:if test="${empty task.responsible}">
																<li>
																	<a href='<c:url value="/projects/${project.id}/sprints/${i}/tasks/${task.id}/responsible/${userSession.user.id}"/>'>
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
																<a href="<c:url value='/projects/${project.id}/sprints/${i}/tasks/delete/${task.id}'/>">
																	<i class="icon-trash"></i> Delete
																</a>
															</li>
														</ul>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
									<a class="linkAddTask" href="#adicionarTarefa" data-toggle="modal"><i class="icon-plus-sign"></i> Adicionar Tarefa...</a>
								</div>
							</div>

							<div class="span4 ">
								<div class="thumbnail" style="background:#F8F8F8;">
									<center><legend><h4><i class="icon-ok-circle"></i> Doing</h4></legend></center>
									
									<div class="well white">
										<ul id="ulDoing" class="nav nav-pills nav-stacked droptrue">
											<c:forEach items="${project.sprints[i].tasks}" var="task">
												<c:if test="${task.status == 'DOING'}">
													<li class="active dropdown" data-id="${task.id}">
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															<span class="caret"></span>
															${task.description}
															<c:if test="${not empty task.responsible}">
																(${task.responsible.name})
															</c:if>
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
								</div>
							</div>

							<div class="span4 ">
								<div class="thumbnail" style="background:#F8F8F8;">
									<center><legend><h4><i class="icon-ok"></i> Done</h4></legend></center>
									
									<div class="well white">
										<ul id="ulDone" class="nav nav-pills nav-stacked droptrue">
											<c:forEach items="${project.sprints[i].tasks}" var="task">
												<c:if test="${task.status == 'DONE'}">
													<li class="active dropdown" data-id="${task.id}">
														<a class="dropdown-toggle" data-toggle="dropdown" href="#">
															<span class="caret"></span>
															${task.description}
															<c:if test="${not empty task.responsible}">
																(${task.responsible.name})
															</c:if>
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
								</div>
							</div>
						</div>
						<br/>
						<br/>
					</div>
					<div class="tab-pane" id="tab2">
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
						<br/>
						<br/>
					</div>
				</div>
				
				<br />
				<div>
					<a class="btn" href="<c:url value='/users/${userSession.user.id}/projects' />"><i class="icon-arrow-left"></i> Voltar</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Adicionar Tarefa -->
	<div id="adicionarTarefa" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="adicionarTarefaToDoLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="adicionarTarefaToDoLabel">Adicionar Tarefa</h3>
	 		</div>
	 		<form class="form-horizontal" id="formNewTask" action='<c:url value="/projects/${project.id}/sprints/${i}/tasks" />' method="post">
			<fieldset>
				<div class="modal-body">
					<label class="control-label" for="description">Descrição:</label>
					<div class="controls">
						<textarea class="span3" id="description" name="task.description" maxlength="255">${task.description}</textarea>
					</div>
				</div>
				
				<div class="modal-footer">
					<button class="btn btn-primary" type="submit"><i class="icon-ok icon-white"></i> Adicionar</button>
					<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<!-- Alterar Tarefa -->
	<div id="alterarTarefa" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="alterarTarefaLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="alterarTarefaLabel">Editar Tarefa</h3>
  		</div>
  		<form class="form-horizontal" id="formEditTask" action='<c:url value="/projects/${project.id}/sprints/${i}/tasks/edit" />' method="post">
			<fieldset>
				<div class="modal-body">
					<label class="control-label" for="editDescription">Descrição:</label>
					<div class="controls">
						<textarea class="span3" id="editDescription" name="task.description" maxlength="255">${task.description}</textarea>
					</div>
				</div>
				
				<div class="modal-footer">
					<input id="editTaskId" type="hidden" name="taskId" />
					<button class="btn btn-primary" type="submit"><i class="icon-ok icon-white"></i> Atualizar</button>
					<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<!-- Altera Status Form -->
	<form id="changeTaskForm" action='<c:url value="/projects/${project.id}/sprints/${i}/tasks/moveto" />' method="post">
		<input id="changeTaskId" type="hidden" name="taskId" />
		<input id="changeTaskStatus" type="hidden" name="taskStatus" />
	</form>
	
	<!-- Altera Sprint Form -->
	<form id="sprintForm" action='<c:url value="/users/${userSession.user.id}/projects/${projeto.id}/sprints" />' method="get">
		<input id="sprintIndex" type="hidden" name="index" />
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
							<br /><br /><br />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="submit"><i class="icon-plus icon-white"></i> Adicionar</button>
					<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<!-- Visualizar Burndown -->
	<div id="visualizarBurndown" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="visualizarBurndownLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="visualizarBurndownLabel">Burndown - ${project.sprints[i].name}</h3>
  		</div>
		<div class="modal-body">
			<div id="chart_div">
				
			</div>
			<script type="text/javascript">
		    	google.load('visualization', '1', {packages: ['imagelinechart']});
		    	
		    	var chart = null;
		    	function drawVisualization() {
		        	// Create and draw the visualization.
					chart = new google.visualization.ImageLineChart(document.getElementById('chart_div'));
				}
		    	
		    	google.setOnLoadCallback(drawVisualization);

		    	$('.visualizarBurndown').click(function() {
		    		var dataCriacao = new Date($(this).data('data'));
		    		var tasks = [];
			    	$.getJSON("${pageContext.request.contextPath}/sprints/"+ $(this).data('sprintid') + "/tasks/search.json", function(json){
						$.each(eval(json), function(i, item){
							var jsonItem = eval(item);
							tasks.push(jsonItem);
						});
					}).then(function() {
						desenhar(dataCriacao, tasks);
					});
		    	});
		    	
		    	function desenhar(dataCriacao, tasks) {
		    		var diff = (dataCriacao.getDate() - new Date().getDate()) * -1;

		    		var dados = [['Data', 'Curva Ideal', '']];
		    		var valor2 = tasks.length;
		    		var cont = 0;
		    		for (var i = diff; i >= 0; i--) {
		    			var legenda = '';

		    			if(i%3==0)
		    				legenda = (dataCriacao.getDate()) + '/' + (dataCriacao.getMonth() + 1) + '/' + (dataCriacao.getFullYear());
		    			
		    			var valor1 = (tasks.length/diff) * i;
		    			
		    			for (var j = 0; j < tasks.length; j++) {
		    				if(new Date(tasks[j].done).getTime() == dataCriacao.getTime()) {
		    					valor2--;
		    				}
						}
		    			
		    			dados.push([legenda, valor1, valor2]);
		    			dataCriacao.setDate(dataCriacao.getDate() + 1);
					}
		    		// Create and populate the data table.
		        	var data = google.visualization.arrayToDataTable(dados);
		    		
		    		chart.draw(data, null);
		    	}
			</script>
		</div>
	</div>
	
	<div id="modalBuscarTarefas" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modalBuscarTarefasLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="modalBuscarTarefasLabel">Burndown - ${project.sprints[i].name}</h3>
  		</div>
		<div class="modal-body">
			<table class="table">
				<thead>
					<tr>
						<th>#</th>
						<th>Descrição</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody id="bodySearch">
					
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
		</div>
	</div>
	
	<%@include file="../minhaconta.jsp" %>
</body>
</html>