package org.example.ss0022.Baitap.Bai3;

import java.util.Date;

public class Order {
    private String id;
    private String name;
    private double price;
    private Date date;

    public Order(String id, String name, double price, Date date) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.date = date;
    }

    // getter
    public String getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public Date getDate() { return date; }
}
