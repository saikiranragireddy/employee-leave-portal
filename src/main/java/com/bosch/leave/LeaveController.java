package com.bosch.leave;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LeaveController {

    private final LeaveService service;

    public LeaveController(LeaveService service) {
        this.service = service;
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("leaveRequest", new LeaveRequest());
        return "index";
    }

    @PostMapping("/submit")
    public String submitRequest(@ModelAttribute LeaveRequest leaveRequest) {
        service.submitRequest(leaveRequest);
        return "redirect:/requests";
    }

    @GetMapping("/requests")
    public String viewRequests(Model model) {
        model.addAttribute("requests", service.getAllRequests());
        return "requests";
    }

    @PostMapping("/approve/{id}")
    public String approve(@PathVariable Long id) {
        service.approveRequest(id);
        return "redirect:/requests";
    }

    @PostMapping("/reject/{id}")
    public String reject(@PathVariable Long id) {
        service.rejectRequest(id);
        return "redirect:/requests";
    }
}
