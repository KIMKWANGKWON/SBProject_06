package restaurant.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import restaurant.service.AdminService;

@Controller
@RequestMapping("/admin/")
@RequiredArgsConstructor
@PreAuthorize("isAuthenticated()")
public class AdminController {
	
	private final AdminService aService;
	
	@GetMapping("memberList")
	public String memberList(Model model) {
		model.addAttribute("member", aService.findUser());
		model.addAttribute("count", aService.countUser());
		return "/admin/memberList";
	}
	
	@GetMapping("restaurantList")
	public String restaurantList(Model model) {
		model.addAttribute("restaurant", aService.findRestaurant());
		model.addAttribute("count", aService.countRestaurant());
		return "/admin/restaurantList";
	}
	
	@GetMapping("memberView/{id}")
	public String memberView(@PathVariable Long id, Model model) {
		model.addAttribute("member", aService.viewUser(id));
		return "/admin/memberView";
	}
	
	@DeleteMapping("memberDelete/{id}")
	@ResponseBody
	public String memberDelete(@PathVariable Long id) {
		aService.deleteUser(id);
		return "success";
	}
	
	@GetMapping("restaurantView/{id}")
	public String restaurantView(@PathVariable Long id, Model model) {
		model.addAttribute("restaurant", aService.viewRestaurant(id));
		return "/admin/restaurantView";
	}
	
	@DeleteMapping("restaurantDelete/{id}")
	@ResponseBody
	public String restaurantDelete(@PathVariable Long id) {
		aService.deleteRestaurant(id);
		return "success";
	}
}
