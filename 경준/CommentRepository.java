package restaurant.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Comment;

public interface CommentRepository extends JpaRepository<Comment, Long> {

}
