<!-- EditUser Modal -->
<div id="minhaConta" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="minhaContaLabel" aria-hidden="true">
	<div class="modal-header">
    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h3 id="minhaContaLabel">Minha Conta</h3>
	</div>
	<form id="formMinhaConta" class="form-horizontal" action="<c:url value='/users/edit/${userSession.user.id}' />" method="post">
		<fieldset>
			<div class="modal-body">
				<div class="control-group">
					<label class="control-label" for="userName">Nome</label>
					<div class="controls">
						<input class="input-xlarge" type="text" name="user.name" id="userName" value="${userSession.user.name}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="userEmail">E-mail</label>
					<div class="controls">
						<input class="input-xlarge required" type="text" name="user.email" id="userEmail" value="${userSession.user.email}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="userLogin">Login</label>
					<div class="controls">
						<input class="input-xlarge required" type="text" name="user.login" id="userLogin" value="${userSession.user.login}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="userPassword">Senha Atual</label>
					<div class="controls">
						<input class="input-xlarge required" type="password" name="passwordAtual" id="passwordAtual" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="confirmacao">Nova Senha</label>
					<div class="controls">
						<input class="input-xlarge required" type="password" name="user.password" id="userPassword" />
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="hidden" name="user.id" value="${userSession.user.id}"/>
				<button class="btn btn-primary"><i class="icon-ok icon-white"></i> Atualizar</button>
				<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
			</div>
		</fieldset>
	</form>
</div>