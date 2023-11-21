package vn.edu.hust.volunteer_app.util;

import org.springframework.beans.factory.annotation.Value;

import static vn.edu.hust.volunteer_app.util.RandomUtil.random;

public class StringUtil {
    public static final String number = "0123456789";
    public static final String upperAlphabet = "ABCDEFGHIKLMNOPQRSTVXYZ";
    public static final String lowerAlphabet = upperAlphabet.toLowerCase();
    public static final String alphabet = upperAlphabet + lowerAlphabet;
    public static final String character = number + alphabet;

    public static final int otpLength = 6;

    public static String randomOTP(){
        System.out.println(otpLength);
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < otpLength; i++) {
            builder.append(number.charAt(random.nextInt(number.length())));
        }
        return builder.toString();
    }
}
