package restaurant.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Inquiry;
import restaurant.model.Response;
import restaurant.model.User;
import restaurant.service.InquiryService;

@Controller
@RequestMapping("/inquiry/*")
@PreAuthorize("isAuthenticated()")
@RequiredArgsConstructor
public class InquiryController {
	
	private final InquiryService iService;
	
	@GetMapping("writeQna")
	public String writeQna() {
		return "/inquiry/writeQna";
	}
	
	@PostMapping("writeQna")
	public String writeQna(Inquiry inquiry, @AuthenticationPrincipal PrincipalDetails p) {
		iService.writeQna(inquiry, p.getUser());
		return "redirect:/";
	}
	
	@GetMapping("qnaList")
	public String qnaList(Model model) {
		model.addAttribute("qna", iService.findAll());
		model.addAttribute("count", iService.countQna());
		return "/admin/qnaList";
	}
	
	@GetMapping("myQna/{id}")
	public String myQna(Model model, @PathVariable Long id) {
		model.addAttribute("qna", iService.findByUser_id(id));
		return "/inquiry/myQna";
	}
	
	@GetMapping("qnaView/{id}")
	public String qnaView(@PathVariable Long id, Model model) {
		model.addAttribute("qna", iService.findById(id));
		return "/inquiry/qnaView";
	}
	
	@PostMapping("responseInsert/{id}")
	@ResponseBody
	@Transactional
	public String responseInsert(@PathVariable Long id,
								 @RequestBody Response response,
								 @AuthenticationPrincipal PrincipalDetails p) {
		Inquiry i = new Inquiry();
		i.setId(id);
		response.setInquiry(i);
		response.setUser(p.getUser());
		iService.responseInsert(response);
		iService.updateReply(id);
		
		return "success";
		
	}
	
	@DeleteMapping("deleteQna/{id}")
	@ResponseBody
	public String deleteQna(@PathVariable Long id) {
		iService.deleteQna(id);
		return "success";
	}
}