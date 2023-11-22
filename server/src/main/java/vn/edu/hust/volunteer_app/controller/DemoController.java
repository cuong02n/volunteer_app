package vn.edu.hust.volunteer_app.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/demo-controller")
@RequiredArgsConstructor
public class DemoController {
  private final HttpServletRequest request;

  @GetMapping
  @Operation(summary = "Demo secret controller", security = @SecurityRequirement(name = "bearerAuth"))
  public ResponseEntity<String> sayHello() {
    System.out.println("--------------------------");
    System.out.println(request.getAttribute("userName"));
    System.out.println("--------------------------");

    return ResponseEntity.ok("Hello user : " + request.getAttribute("userName")
        + " from 1234 secured endpoint, your id is : " + request.getAttribute("userId"));
  }

}
