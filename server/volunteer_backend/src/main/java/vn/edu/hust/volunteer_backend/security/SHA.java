package vn.edu.hust.volunteer_backend.security;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class SHA {
    public static String sha256(String text) {
        try {
            MessageDigest sha256algorithm = MessageDigest.getInstance("SHA-256");
            byte[] hash = sha256algorithm.digest(text.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error initializing SHA-256 algorithm.", e);
        }
    }

    public static void main(String[] args) {
        System.out.println(sha256("12345678"));
    }
}
