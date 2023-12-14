package vn.edu.hust.volunteer_app.annotation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.edu.hust.volunteer_app.util.StringUtil;

public class PasswordValidator implements ConstraintValidator<com.dtvn.foodorderbackend.annotation.ValidPassword, String> {
    @Override
    public void initialize(com.dtvn.foodorderbackend.annotation.ValidPassword constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        for (int i = 0; i < s.length(); i++) {
            if (!StringUtil.CHARSET_PASSWORD.contains(s.charAt(i) + "")) {
                constraintValidatorContext.disableDefaultConstraintViolation();
                constraintValidatorContext.buildConstraintViolationWithTemplate("Password not valid").addConstraintViolation();
                return false;
            }
        }
        return true;
    }
}
