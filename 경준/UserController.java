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

import lombok.RequiredArgsConstructor;
import restaurant.model.Reservations;
import restaurant.model.User;
import restaurant.repository.UserRepository;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
@RequiredArgsConstructor
public class UserController {
	@Autowired
	private UserService uService;
	@Autowired
	private UserRepository uRepository;
	private final RestaurantService rService;
	
	@GetMapping("join")
	private String join() {
		return "/user/join";
	}
	
	@PostMapping("join")
	@ResponseBody
	public String join(@RequestBody User user) {
		return uService.join(user);
	}
	@GetMapping("mypage/{id}")
	public String mypage(@PathVariable Long id,Model model) {
		model.addAttribute("user",uService.view(id));
		return "/user/mypage";
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
	
	@GetMapping("reservationForm/{rid}")
	public String reservationForm(@PathVariable Long rid, Model model) {
		model.addAttribute("restaurant", rService.view(rid));
		return "/user/reservationForm";
	}
	
	@PostMapping("reservation/{rid}")
	@ResponseBody
	public String reservation(@RequestBody Reservations reservations, @PathVariable Long rid) {
		uService.reservation(reservations, rid);
		return "success";
	}
	
	@GetMapping("reservationList/{uid}")
	public String reservationList(@PathVariable Long uid, Model model) {
		model.addAttribute("reservations", uService.findByUid(uid));
		return "/user/reservationList";
	}
	
	@GetMapping("reservationUpdate/{rsvid}")
	public String reservationUpdate(@PathVariable Long rsvid, Model model) {
		model.addAttribute("rsv", uService.findRsv(rsvid));
		return "/user/reservationUpdate";
	}
	
	@PutMapping("reservationUpdate")
	@ResponseBody
	public String reservationUpdate(@RequestBody Reservations reservations) {
		uService.updateRsv(reservations);
		return "success";
	}
	
	@DeleteMapping("reservationCancel/{rsvid}")
	@ResponseBody
	public String reservationCancel(@PathVariable Long rsvid) {
		uService.cancelRsv(rsvid);
		return "success";
	}
}