package vn.edu.hust.volunteer_app;

import jakarta.validation.Valid;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.util.StringUtil;

@SpringBootApplication
@RestController
public class VolunteerApplication {

    public static void main(String[] args) {
        SpringApplication.run(VolunteerApplication.class, args);
    }
    @PostMapping("/test")
    public ResponseEntity<Fanpage> hello(@Valid @RequestBody Fanpage fanpage){
        System.out.println(StringUtil.isName(fanpage.getFanpageName()));
        return ResponseEntity.ok().body(fanpage);
    }
}
