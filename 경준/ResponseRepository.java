package restaurant.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Response;

public interface ResponseRepository extends JpaRepository<Response, Long>{

}
