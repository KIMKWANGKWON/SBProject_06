package restaurant.model;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
@Getter @Setter
@Entity
@Table(name = "restaurant01")
public class Restaurant {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id; //기본키
	private String name; //식당명
	private String address; //주소
	private String tel; //전화번호
	private String hours; //운영시간
	private String description; //설명
	private String thumImage; //썸네일 이미지 주소
	private String url; //사이트 홈페이지
	
	@OneToMany(mappedBy = "restaurant")
	private List<Review> reviewList;
	
	@ManyToOne
	@JoinColumn(name = "owner_id")
	private User owner;
}
