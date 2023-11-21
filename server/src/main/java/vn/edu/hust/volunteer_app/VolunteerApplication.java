package vn.edu.hust.volunteer_app;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import vn.edu.hust.volunteer_app.util.RandomUtil;
import vn.edu.hust.volunteer_app.util.StringUtil;

@SpringBootApplication
public class VolunteerApplication {

	public static void main(String[] args) {
		SpringApplication.run(VolunteerApplication.class, args);
		System.out.println(StringUtil.randomOTP());
	}

}
