package vn.edu.hust.volunteer_backend.controller;

import com.google.gson.JsonObject;
import org.hibernate.annotations.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.diagnostics.FailureAnalysis;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;
import vn.edu.hust.volunteer_backend.model.Fanpage;
import vn.edu.hust.volunteer_backend.model.FanpageRepository;
import vn.edu.hust.volunteer_backend.model.User;
import vn.edu.hust.volunteer_backend.model.UserRepository;
import vn.edu.hust.volunteer_backend.util.GsonUtil;

import javax.sql.DataSource;
import javax.xml.crypto.Data;

@org.springframework.web.bind.annotation.RestController
@RequestMapping("/api")
public class RestController {
    UserRepository userRepository;
    FanpageRepository fanpageRepository;
    DataSource dataSource;

    @Autowired
    public RestController(FanpageRepository fanpageRepository, UserRepository userRepository, DataSource dataSource) {
        this.fanpageRepository = fanpageRepository;
        this.userRepository = userRepository;
        this.dataSource = dataSource;
    }


    @GetMapping("/all_user")
    public String getAllUser() {
        return userRepository.findAll().toString();
    }

    @PostMapping("/register")
    public ResponseEntity<?> regis(@RequestBody RequestEntity<JsonObject> body) {
        JsonObject jsonObject = body.getBody();
        System.out.println(jsonObject);
        return ResponseEntity.ok("ok nha");
    }

    @PostMapping("/test_fanpage")
    public String getFanpage(@RequestBody String body) {
        var x = fanpageRepository.findTopSubscriberFanpage(2);
        System.out.println(GsonUtil.toJson(x));
        return "aaa";
    }

    @GetMapping("/top_subscriber_fanpage")
    public ResponseEntity<?> getTopSubscriberFanpage(@RequestParam int top) {
        if (top > 100) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok("ok ok ok");
    }
}

