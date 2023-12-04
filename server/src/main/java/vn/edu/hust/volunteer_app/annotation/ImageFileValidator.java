package vn.edu.hust.volunteer_app.annotation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;

public class ImageFileValidator implements ConstraintValidator<ValidImage, MultipartFile> {
    public static final String[] supportImage = {"image/png", "image/jpg", "image/jpeg"};

    @Override
    public void initialize(ValidImage constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(MultipartFile file, ConstraintValidatorContext context) {
        boolean result = true;
        String contentType = file.getContentType();
        assert contentType != null;
        if (!isSupportedContentType(contentType)) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("not allow")
                    .addConstraintViolation();
            result = false;
        }

        return result;
    }

    private boolean isSupportedContentType(String contentType) {
        return Arrays.asList(supportImage).contains(contentType);
    }
}
