package br.ufpb.esa.project.scrum.interceptors;

import br.com.caelum.vraptor.InterceptionException;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.InterceptorStack;
import br.com.caelum.vraptor.interceptor.Interceptor;
import br.com.caelum.vraptor.resource.ResourceMethod;
import br.ufpb.esa.project.scrum.annotations.Limited;
import br.ufpb.esa.project.scrum.components.UserSession;
import br.ufpb.esa.project.scrum.controllers.LoginController;

@Intercepts
public class AuthenticationInterceptor implements Interceptor {
	private final UserSession user;
	private final Result result;
	
	public AuthenticationInterceptor(UserSession user, Result result) {
		this.user = user;
		this.result = result;
	}
	
	public boolean accepts(ResourceMethod method) {
		return !this.user.isLogged() && method.containsAnnotation(Limited.class);
	}
	public void intercept(InterceptorStack stack, ResourceMethod method, Object resourceInstance) throws InterceptionException {
		result.redirectTo(LoginController.class).loginForm();
	}
}