package vn.edu.hust.volunteer_app.annotation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import jakarta.validation.Valid;
import vn.edu.hust.volunteer_app.util.StringUtil;

public class NameValidator implements ConstraintValidator<ValidName,String> {
    @Override
    public void initialize(ValidName constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return StringUtil.isName(s.trim());
    }
}
