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

	<div class="container-fluid" id="div2">
		<div class="thumbnail">
			<div class="well">
				<div class="row">
					<div class="span7">
						<legend><i class="icon-list-alt"></i> Meus Projetos</legend>
						<div class="well">
							<table class="table table-bordered table-striped table-hover">
								<thead>
									<tr>
										<th><a href="<c:url value='/projects/new'/>"><i class="icon-plus"></i> Add Projeto...</a></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${projectList}" var="project">
										<tr>
											<td>
												<div class="btn-group">
													<a class="btn" href="<c:url value='/projects/${project.id}'/>">${project.name}</a>
													<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
														<i class="icon-chevron-down"></i>
													</a>
													<ul class="dropdown-menu">
														<li><a href="<c:url value='/projects/delete/${project.id}'/>"><i class="icon-remove"></i> Delete</a></li>
													</ul>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="span7" align="center">
						<legend>Perfil</legend>
						<div class="well">
							<img class="img-rounded" src="<c:url value='/img/user/no-photo.png'/>" alt="no-photo" />
							<br /><br />
							<strong>${userSession.name}</strong>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>