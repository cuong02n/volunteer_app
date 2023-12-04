package vn.edu.hust.volunteer_app.annotation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.FIELD,ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = {NameValidator.class})
public @interface ValidName {
    String message() default "{NameValidator}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
