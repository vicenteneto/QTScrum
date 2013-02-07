<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project | QTS - Quadro de Tarefas do Scrum</title>
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/br.ufpb.esa.project.scrum/css/style.css">
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="/br.ufpb.esa.project.scrum/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function () {
	   	$.getJSON('${pageContext.request.contextPath}/tasks/list.json', 
			function(json){
			var table = $('#tBodyToDo');
			$.each(eval(json), function(i, item){
				var jsonItem = eval(item);
				var urlValue = '';
				var btnSplit = 
					'<div class="btn-group">' +
						'<a class="btn" href="#">' + jsonItem.description + '</a>' +
						'<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">' +
							'<i class="icon-chevron-down"></i>' +
						'</a>' +
						'<ul class="dropdown-menu">' +
							'<li><a href="' + urlValue + '"><i class="icon-remove"></i> Delete</a></li>' +
						'</ul>' +
					'</div>';
				table.append('<tr><td>' + btnSplit + '</td></tr>');
			});
		});
	});
</script>
</head>

<body>
	<%@include file="../default/header.jsp" %>

	<div id="geral" class="container-fluid">
		<div class="row-fluid">
			<div id="conteudo" class="well">
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
							<div class="span4 span4Style ">
								<table class="table">
									<thead>
										<tr>
											<th><i class="icon-question-sign"></i> To Do</th>
										</tr>
									</thead>

									<tbody id="tBodyToDo">
										
									</tbody>

									<tfoot>
										<tr>
											<td>
												<a href='<c:url value="/tasks/new" />'><i class="icon-plus-sign"></i> Add Tarefa...</a>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>

							<div class="span4 span4Style ">
								<table class="table">
									<thead>
										<tr>
											<th><i class="icon-time"></i> Doing</th>
										</tr>
									</thead>

									<tbody>

									</tbody>

									<tfoot>
										<tr>
											<td><a href="#"><i class="icon-plus-sign"></i> Add Tarefa...</a></td>
										</tr>
									</tfoot>
								</table>
							</div>

							<div class="span4 span4Style">
								<table class="table">
									<thead>
										<tr>
											<th><i class="icon-ok"></i> Done</th>
										</tr>
									</thead>

									<tbody>

									</tbody>

									<tfoot>
										<tr>
											<td><a href="#"><i class="icon-plus-sign"></i> Add Tarefa...</a></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
					<div class="tab-pane" id="tab2">
						<p>Panel 2</p>
					</div>
					<div class="tab-pane" id="tab3">
						<p>Panel 3</p>
					</div>
				</div>
				<br />
				<div>
					<a class="btn" href="<c:url value='/projects' />"><i class="icon-arrow-left"></i> Voltar</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>