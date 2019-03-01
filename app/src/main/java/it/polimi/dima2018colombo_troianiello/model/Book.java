package it.polimi.dima2018colombo_troianiello.model;

public class Book {

    private String isbn;
    private String title;
    private String author;
    private String publisher;
    private String description;
    private int pages;
    private double price;

    public Book(String isbn, String title, String author, String publisher, String description, int pages, double price) {
        this.isbn = isbn;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.description = description;
        this.pages = pages;
        this.price = price;
    }

    public String getIsbn() {
        return isbn;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getPublisher(){
        return publisher;
    }

    public String getDescription() {
        return description;
    }

    public int getPages() {
        return pages;
    }

    public double getPrice() {
        return price;
    }
}
