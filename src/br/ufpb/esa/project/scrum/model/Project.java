package br.ufpb.esa.project.scrum.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Cascade;

@Entity
public class Project {
	@Id
	@GeneratedValue
	private Long id;
	
	@Column(nullable=false, length=100)
	private String name;
	
	@ManyToMany
	@Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
	@JoinTable(name="User_Project",
		joinColumns={@JoinColumn(name="project_id")},
		inverseJoinColumns={@JoinColumn(name="user_id")})
	private List<User> participants = new ArrayList<User>();
	
	@OneToMany(mappedBy="project")
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
	public List<User> getParticipants() {
		return participants;
	}
	public void setParticipants(List<User> participants) {
		this.participants = participants;
	}
	public List<Task> getTasks() {
		return tasks;
	}
	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}
}