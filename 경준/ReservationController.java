package restaurant.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Reservations;
import restaurant.repository.UserRepository;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
@PreAuthorize("isAuthenticated()")
@RequiredArgsConstructor
public class ReservationController {
	
	//주입
	private final UserService uService;
	
	private final RestaurantService rService;
	
	//예약화면
	@GetMapping("reservationForm/{rid}")
	public String reservationForm(@PathVariable Long rid, Model model) {
		model.addAttribute("restaurant", rService.view(rid));
		return "/user/reservationForm";
	}
	
	//예약진행
	@PostMapping("reservation/{rid}")
	@ResponseBody
	public String reservation(@RequestBody Reservations reservations, 
							  @PathVariable Long rid,
							  @AuthenticationPrincipal PrincipalDetails p) throws ParseException {
		String str = reservations.getRsvDate() + " " + reservations.getRsvTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		reservations.setRsvDateTime(sdf.parse(str));
		
		uService.reservation(reservations, rid, p);
		return "success";
	}
	
	//예약목록보기
	@GetMapping("reservationList/{uid}")
	public String reservationList(@PathVariable Long uid, Model model) {
		model.addAttribute("reservations", uService.findByUid(uid));
		return "/user/reservationList";
	}
	
	//예약수정
	@GetMapping("reservationUpdate/{rsvid}")
	public String reservationUpdate(@PathVariable Long rsvid, Model model) {
		model.addAttribute("rsv", uService.findRsv(rsvid));
		return "/user/reservationUpdate";
	}
	
	//예약수정진행
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
