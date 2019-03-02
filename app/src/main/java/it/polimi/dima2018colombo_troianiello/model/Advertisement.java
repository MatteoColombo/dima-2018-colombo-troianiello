package it.polimi.dima2018colombo_troianiello.model;

import java.util.Date;

/**
 * @author AndreaTroinaiello
 */
public class Advertisement {

    private double price;
    private String description;
    private final Date publicationDate;
    private final User user;
    private final Book book;

    /**
     * The constructor of Advertisement
     * @param price
     * @param description
     * @param publicationDate
     * @param user
     * @param book
     */
    public Advertisement(double price, String description, Date publicationDate, User user, Book book) {
        this.price = price;
        this.description = description;
        this.publicationDate = publicationDate;
        this.user = user;
        this.book = book;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public User getUser() {
        return user;
    }

    public Book getBook() {
        return book;
    }
}
