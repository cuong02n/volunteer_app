package vn.edu.hust.volunteer_app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.service.FanpageService;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class AdminController {

    private final FanpageService fanpageService;

    @GetMapping("/admin")
    public String showAuthPage(Model model) {
        // Đưa dữ liệu cần thiết đến trang dashboard.html, ví dụ:
        model.addAttribute("message", "Xin chào từ Controller!");
        // Trả về tên của view template (dashboard.html)
        return "authpage.html";
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        // Đưa dữ liệu cần thiết đến trang dashboard.html
        model.addAttribute("message", "Xin chào từ Controller!");

        // Lấy danh sách Fanpage từ service
        List<Fanpage> fanpages = fanpageService.getAllFanpages();

        // Truyền danh sách Fanpage vào template
        model.addAttribute("fanpages", fanpages);

        // Trả về tên của view template (dashboard.html)
        return "dashboard";
    }
}
