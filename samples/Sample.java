package com.example.shop;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Java sample: class, interface, generics, annotation.
 */
public class Sample {

    private static final int MAX_ITEMS = 100;
    private final List<String> names = new ArrayList<>();

    interface Greeter {
        String greet(String name);
    }

    @Override
    public String toString() {
        return "Sample{names=" + names + "}";
    }

    public void add(String name) throws IllegalArgumentException {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name is empty");
        }
        names.add(name);
    }

    public Optional<String> first() {
        return names.isEmpty() ? Optional.empty() : Optional.of(names.get(0));
    }

    public static void main(String[] args) {
        Sample sample = new Sample();
        sample.add("Alex");
        Greeter greeter = n -> String.format("Hello, %s!", n);
        double ratio = 3.14;
        long big = 1_000_000L;
        char letter = 'A';
        boolean ok = true;
        for (int i = 0; i < MAX_ITEMS && ok; i++) {
            System.out.println(greeter.greet(sample.first().orElse("?")) + i);
        }
    }
}
