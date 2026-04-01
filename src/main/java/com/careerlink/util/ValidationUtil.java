package com.careerlink.util;

public class ValidationUtil {

    // Check if a string is null or empty
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // Check if email format is valid
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    }

    // Check if phone number is valid (10 digits)
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^[0-9]{10}$");
    }

    // Check if name contains only letters and spaces
    public static boolean isValidName(String name) {
        return name != null && name.matches("^[a-zA-Z ]+$");
    }

    // Check if password is at least 6 characters
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }
}