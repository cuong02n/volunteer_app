package vn.edu.hust.volunteer_backend.controller;

import com.google.gson.JsonObject;
import org.hibernate.annotations.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.edu.hust.volunteer_backend.model.User;
import vn.edu.hust.volunteer_backend.model.UserRepository;
import vn.edu.hust.volunteer_backend.util.GsonUtil;

import javax.sql.DataSource;
import javax.xml.crypto.Data;

@org.springframework.web.bind.annotation.RestController
@RequestMapping("/api")
public class RestController {
    @Autowired
    UserRepository userRepository;
    DataSource dataSource;
    @Autowired
    public RestController(DataSource dataSource){this.dataSource = dataSource;}

    @PostMapping("/test")
    public String test(@RequestBody String data){
        return "";
    }

    @GetMapping("/allUser")
    public String getAllUser(){
        return userRepository.findAll().toString();
    }

    @PostMapping("/create_user")
    public String createUser(@RequestBody String body){
//        System.out.println(body);
        User user = GsonUtil.fromGson(body,User.class);
        userRepository.save(user);
        System.out.println(user);
        return "";
    }
}

