package com.yuyan.dog;

public class ParentDog {
    public static void fun(String arg) {
        ClassLoader dogClassLoader = ParentDog.class.getClassLoader();
        System.out.println("ParentDog ParentDog.class classloader = " + dogClassLoader);
    }

}
