package restaurant.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
@Getter @Setter
@Entity
@Table(name = "user_02")
public class User {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String username;
	private String nickname;	
	private String password;
	private String role;
	
	@OneToMany(mappedBy = "user")
	private List<Favorites> favorites;
	
	@OneToMany(mappedBy = "user")
	private List<Reservations> reservations;
}
