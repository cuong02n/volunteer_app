package vn.edu.hust.volunteer_backend;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@SpringBootApplication
public class VolunteerBackendApplication {
    public static void main(String[] args) {
        var x = SpringApplication.run(VolunteerBackendApplication.class, args);
    }
}
