package com.careerlink.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    // Encrypt password using SHA-256
    public static String encrypt(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Encryption error: " + e.getMessage());
            return null;
        }
    }

    // Check if entered password matches stored encrypted password
    public static boolean verify(String enteredPassword, String storedPassword) {
        return encrypt(enteredPassword).equals(storedPassword);
    }
}