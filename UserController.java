package restaurant.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	@GetMapping("favorites/{user_id}")
	public String favorite(@PathVariable Long user_id, Model model) {
		model.addAttribute("favorites", uService.findByUser_id(user_id));
		return "/user/favorites";
	}
	
	@GetMapping("view/{id}")
	public String view(@PathVariable Long id, Model model) {
		System.out.println("id"+id);
		model.addAttribute("user", uService.view(id));
		return "/user/view";
	}
	
	@GetMapping("update/{id}")
	public String update(@PathVariable Long id, Model model) {
		model.addAttribute("user", uService.view(id));
		return "/user/update";
	}
	
	@PutMapping("update")
	@ResponseBody
	public String update(@RequestBody User user, HttpSession session) {
		uService.update(user);
		session.invalidate();
		return "success";
	}
	
	@DeleteMapping("delete/{id}")
	@ResponseBody
	public String delete(@PathVariable Long id, HttpSession session) {
		uService.delete(id);
		session.invalidate();
		return "success";
	}
}