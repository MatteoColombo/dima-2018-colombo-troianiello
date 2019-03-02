package it.polimi.dima2018colombo_troianiello.model;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

/**
 *
 *
 * @author MatteoColombo
 */
public class Book {

    private String isbn;
    private String title;
    private List<String> authors;
    private String publisher;
    private String plot;
    private int pages;
    private double price;
    private Photo photo;
    private Date releaseDate;

    /**
     * The constructor of Book.
     * @param isbn Numeric commercial identifier which is intended to be unique.
     * @param title The distinguishing name of the book.
     * @param publisher The company that prepared and issued the book.
     * @param plot The story of the book.
     * @param pages The number of pages of the book.
     * @param price The cost of the book.
     * @param photo The images of the book.
     * @param releaseDate The release date of the book.
     */
    public Book(String isbn, String title, String publisher, String plot, int pages, double price, Photo photo, Date releaseDate) {
        this.isbn = isbn;
        this.title = title;
        this.authors = new ArrayList<>();
        this.publisher = publisher;
        this.plot = plot;
        this.pages = pages;
        this.price = price;
        this.photo = photo;
        this.releaseDate = releaseDate;
    }

    /**
     * Returns the isbn of the book.
     * @return Numeric commercial book identifier.
     */
    public String getIsbn() {
        return isbn;
    }

    /**
     * Sets the new isbn of the book.
     * @param isbn New numeric commercial book identifier.
     */
    public void setIsbn(String isbn) {
        this.isbn=isbn;
    }

    /**
     * Returns the title of the book.
     * @return The title of the book.
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets new title of the book.
     * @param title New title of the book.
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Returns the authors of the book.
     * @return One or more creators of the book.
     */
    public List<String> getAuthors() {
        return authors;
    }

    /**
     * Add a new author of the book.
     * @param author New author of the book.
     */
    public void addAuthors(String author) {
        this.authors.add(author);
    }

    /**
     * Sets the authors of the book.
     * @param authors New authors of the book.
     */
    public void setAuthors(List<String> authors) {
        this.authors = authors;
    }

    /**
     * Returns the publisher of the book.
     * @return The company that prepared and issued the book.
     */
    public String getPublisher(){
        return publisher;
    }

    /**
     * Sets the new publisher of the book.
     * @param publisher New publisher of the book.
     */
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    /**
     * Returns the plot of the book.
     * @return The story of the book.
     */
    public String getPlot() {
        return plot;
    }

    /**
     * Sets the plot of the book.
     * @param plot The story of the book.
     */
    public void setPlot(String plot) {
        this.plot = plot;
    }

    /**
     * Returns the number of pages of the book.
     * @return The number of pages of the book.
     */
    public int getPages() {
        return pages;
    }

    /**
     * Sets the new numeber of pages of the book.
     * @param pages New number of pages of the book.
     */
    public void setPages(int pages) {
        this.pages = pages;
    }

    /**
     * Returns the cost of the book.
     * @return The cost of the book.
     */
    public double getPrice() {
        return price;
    }

    /**
     * Sets the new cost of the book.
     * @param price New cost of the book.
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     * Returns the photo of the book.
     * @return The image of the book.
     */
    public Photo getPhoto() {
        return photo;
    }

    /**
     * Sets the new photo of the book.
     * @param photo New image of the book.
     */
    public void setPhoto(Photo photo) {
        this.photo = photo;
    }

    /**
     * Returns the release date of the book.
     * @return The release date of the book.
     */
    public Date getReleaseDate() {
        return releaseDate;
    }

    /**
     * Sets the new release date of the book.
     * @param releaseDate New release date of the book.
     */
    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    /**
     * It generates a string formed by the most significant informations of the book.
     * @return string.
     */
    @Override
    public String toString() {
        return "Book{" +
                "isbn='" + isbn + '\'' +
                ", title='" + title + '\'' +
                ", authors='" + authors +
                ", publisher='" + publisher + '\'' +
                ", plot='" + plot + '\'' +
                ", pages=" + pages +
                ", price=" + price +
                '}';
    }
}
