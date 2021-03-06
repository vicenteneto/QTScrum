package br.ufpb.esa.project.scrum.model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cascade;

@Entity
public class Sprint {
	@Id
	@GeneratedValue
	private Long id;

	@Column(nullable=false, length=100)
	private String name;
	
	@Column(nullable=false)
	@Temporal(TemporalType.DATE)
	private Calendar dataCriacao;
	
	@ManyToOne
	@Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
	private Project project;
	
	@OneToMany(mappedBy="sprint")
	@Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
	private List<Task> tasks = new ArrayList<Task>();

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Calendar getDataCriacao() {
		return dataCriacao;
	}
	public void setDataCriacao(Calendar dataCriacao) {
		this.dataCriacao = dataCriacao;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public List<Task> getTasks() {
		return tasks;
	}
	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}
}