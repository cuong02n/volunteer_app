package vn.edu.hust.volunteer_backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.sql.DataSource;
import javax.xml.crypto.Data;

@org.springframework.web.bind.annotation.RestController
@RequestMapping("/api")
public class RestController {
    DataSource dataSource;
    @Autowired
    public RestController(DataSource dataSource){this.dataSource = dataSource;}
    @GetMapping("/test")
    public String testSQL() throws Exception{
        return dataSource.getConnection().toString();
    }
}
