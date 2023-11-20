package vn.edu.hust.volunteer_backend.controller;

import com.google.gson.JsonObject;
import org.hibernate.annotations.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.diagnostics.FailureAnalysis;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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

    @PostMapping("/create_user")
    public User createUser(@RequestBody String body) {
        User user = GsonUtil.fromGson(body, User.class);
        userRepository.save(user);
        return user;
    }

    @PostMapping("test_fanpage")
    public Fanpage getFanpage(@RequestBody String body) {
        int leaderId = GsonUtil.fromGson(body, JsonObject.class).get("leader_id").getAsInt();
        var x = fanpageRepository.findFanpageByLeaderId(leaderId);
        System.out.println(x);
        return x;
    }
}

