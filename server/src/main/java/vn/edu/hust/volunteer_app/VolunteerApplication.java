package vn.edu.hust.volunteer_app;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import vn.edu.hust.volunteer_app.models.entity.Event;
import vn.edu.hust.volunteer_app.models.entity.Fanpage;
import vn.edu.hust.volunteer_app.util.StringUtil;

@SpringBootApplication
@RestController
public class VolunteerApplication {

    static Logger logger = LoggerFactory.getLogger(VolunteerApplication.class);
    static ApplicationContext context;
    public static void main(String[] args) {
        context = SpringApplication.run(VolunteerApplication.class, args);
    }
    @PostMapping("/test")
    public ResponseEntity<?> hello(){
        return ResponseEntity.ok().build();
    }
}
