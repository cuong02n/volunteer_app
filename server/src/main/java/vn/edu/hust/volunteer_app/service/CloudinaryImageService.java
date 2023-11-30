package vn.edu.hust.volunteer_app.service;

import com.cloudinary.Cloudinary;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class CloudinaryImageService {
    Logger logger = LoggerFactory.getLogger(CloudinaryImageService.class);
    final Cloudinary cloudinary;

    public Map upload(MultipartFile file) throws Exception {
        var x = this.cloudinary.uploader().upload(file.getBytes(), Map.of());
        return x;
    }
}
