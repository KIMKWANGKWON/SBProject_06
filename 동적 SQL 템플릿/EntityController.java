package restaurant;

import java.util.HashMap;

import org.springframework.data.domain.Page;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



public class EntityController {
	private final EntityService eSerivce;
	@GetMapping("/list")
	public String list(String keywords,
			@RequestParam(defaultValue = "") String order,
			PageRequest pageRequest,
			Model model) {
		
		Page<CustomEntity> result;
	    result = rService.search(keywords,order,pageRequest.of());

		model.addAttribute("rPage",result);
		model.addAttribute("","");
		return "/restaurant/list";
	}
}
