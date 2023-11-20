package vn.edu.hust.volunteer_backend.util;

import com.google.gson.Gson;
import com.google.gson.JsonNull;

public class GsonUtil {
    public static final Gson gson = new Gson();

    public static <T> T fromGson(String s, Class<T> classOfT) {
        return gson.fromJson(s, classOfT);
    }

    public static String toJson(Object src) {
        return gson.toJson(src);
    }
}
