<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<a class="brand" href="#">QTS | Quadro de Tarefas do Scrum</a>
		<div class="nav-collapse">
			<ul class="nav pull-right">
				<li class="divider-vertical"></li>
				<li>
					<div class="btn-group">
						<c:if test="${userSession.logged}">
							<a class="btn dropdown-toggle btn-danger" data-toggle="dropdown" href="#">
								Ol&aacute;, ${userSession.name} <span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
				            	<li><a href="#"><i class="icon-user"></i> Minha Conta</a></li>
				            	<li class="divider"></li>
								<li><a href='<c:url value="/logout" />'><i class="icon-off"></i> Logout</a></li>
							</ul>
						</c:if>
						<c:if test="${empty userSession or not userSession.logged}">
							<a class="btn dropdown-toggle btn-danger" data-toggle="dropdown" href="#">
								Você não está logado <span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href='<c:url value="/login" />'><i class="icon-ok-circle"></i> Login</a></li>
								<li><a href='<c:url value="/users/new" />'><i class="icon-user"></i> Cadastre-se</a></li>
							</ul>
						</c:if>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>