<!-- Adicionar Tarefa TODO -->
<div id="adicionarTarefaToDo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="adicionarTarefaToDoLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="adicionarTarefaToDoLabel">Adicionar Tarefa</h3>
 		</div>
 		<form class="form-horizontal" id="formNewTask" action='<c:url value="/projects/${project.id}/tasks" />' method="post">
		<fieldset>
			<div class="modal-body">
				<label class="control-label" for="description">Descrição:</label>
				<div class="controls">
					<textarea class="span3" id="description" name="task.description" maxlength="255">${task.description}</textarea>
				</div>
			</div>
			
			<div class="modal-footer">
				<input type="hidden" name="status" value="todo" />
				<button class="btn btn-primary" type="submit"><i class="icon-ok icon-white"></i> Adicionar</button>
				<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true"><i class="icon-remove icon-white"></i> Fechar</button>
			</div>
		</fieldset>
	</form>
</div>

<!-- Adicionar Tarefa DOING -->
<div id="adicionarTarefaDoing" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="adicionarTarefaDoingLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="adicionarTarefaDoingLabel">Adicionar Tarefa</h3>
 		</div>
 		<form class="form-horizontal" id="formNewTask" action='<c:url value="/projects/${project.id}/tasks" />' method="post">
		<fieldset>
			<div class="modal-body">
				<label class="control-label" for="description">Descrição:</label>
				<div class="controls">
					<textarea class="span3" id="description" name="task.description" maxlength="255">${task.description}</textarea>
				</div>
			</div>
			
			<div class="modal-footer">
				<input type="hidden" name="status" value="doing" />
				<button class="btn" data-dismiss="modal" aria-hidden="true">Fechar</button>
				<button class="btn btn-primary" type="submit">Adicionar</button>
			</div>
		</fieldset>
	</form>
</div>

<!-- Adicionar Tarefa DONE -->
<div id="adicionarTarefaDone" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="adicionarTarefaDoneLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="adicionarTarefaDoneLabel">Adicionar Tarefa</h3>
 		</div>
 		<form class="form-horizontal" id="formNewTask" action='<c:url value="/projects/${project.id}/tasks" />' method="post">
		<fieldset>
			<div class="modal-body">
				<label class="control-label" for="description">Descrição:</label>
				<div class="controls">
					<textarea class="span3" id="description" name="task.description" maxlength="255">${task.description}</textarea>
				</div>
			</div>
			
			<div class="modal-footer">
				<input type="hidden" name="status" value="done" />
				<button class="btn" data-dismiss="modal" aria-hidden="true">Fechar</button>
				<button class="btn btn-primary" type="submit">Adicionar</button>
			</div>
		</fieldset>
	</form>
</div>