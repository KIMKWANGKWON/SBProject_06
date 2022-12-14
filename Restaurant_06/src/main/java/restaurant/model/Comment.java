package restaurant.model;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

//@Entity
//@Table(name = "comment_tmp")
//public class Comment {
//	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
//	private Long id;
//	private String content;
//	private Date regdate;
//	
//	@ManyToOne
//	@JoinColumn(name = "user_id")
//	private User user;
//	
//	@ManyToOne
//	@JoinColumn(name = "board_id")
//	private Board board;
//}
