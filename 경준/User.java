package restaurant.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
@Getter @Setter
@Entity
@Table(name = "user_04")
public class User {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String tel;
	private String address;
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy/MM/dd", timezone = "Asia/Seoul")
	private Date regdate;
	private String username;
	private String nickname;
	private String password;
	private String role;
	
	@OneToMany(mappedBy = "user")
	private List<Favorites> favorites;
	
	@OneToMany(mappedBy = "user")
	private List<Reservations> reservations;
	
	@OneToMany(mappedBy = "user")
	private List<Inquiry> inquiry;
	
	@OneToMany(mappedBy = "user")
	private List<Response> response;
}
