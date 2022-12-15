package restaurant.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import restaurant.model.User;
import restaurant.repository.UserRepository;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private UserService uService;
	
	@Autowired
	private UserRepository uRepository;
	
	@GetMapping("join")
	private String join() {
		return "/user/join";
	}
	
	@PostMapping("join")
	@ResponseBody
	public String join(@RequestBody User user) {
		if(uRepository.findByUsername(user.getUsername())!=null) {
			return "fail";
		}
		uService.join(user);
		return "success";
	}
}
