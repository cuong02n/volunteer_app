package com.dtvn.foodorderbackend.annotation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import vn.edu.hust.volunteer_app.annotation.PasswordValidator;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Constraint(validatedBy = {PasswordValidator.class})
public @interface ValidPassword {
    int max() default 1 >> 10;

    int min() default 6;

    String message() default "NameValidator";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}

