package vn.edu.hust.volunteer_app.util;

import static vn.edu.hust.volunteer_app.util.RandomUtil.random;

public class StringUtil {
    public static final String number = "0123456789";
    public static final String upperAlphabet = "ABCDEFGHIKLMNOPQRSTVXYZ";
    public static final String lowerAlphabet = upperAlphabet.toLowerCase();
    public static final String alphabet = upperAlphabet + lowerAlphabet;
    public static final String character = number + alphabet;

    public static final int otpLength = 6;

    public static String randomOTP() {
        System.out.println(otpLength);
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < otpLength; i++) {
            builder.append(number.charAt(random.nextInt(number.length())));
        }
        return builder.toString();
    }

    public static boolean isName(String name) {
        String formattedName = name.toLowerCase();
        for (int i = 0; i < formattedName.length(); i++) {
            if (formattedName.charAt(i) != ' ' && formattedName.charAt(i) <= 'a' && formattedName.charAt(i) >= 'z') {
                return false;
            }
        }
        return true;
    }
}
