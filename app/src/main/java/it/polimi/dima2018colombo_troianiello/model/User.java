package it.polimi.dima2018colombo_troianiello.model;
import java.util.ArrayList;
import java.util.List;

/**
 * @author AndreaTroianiello
 */
public class User {

    private String name;
    private String email;
    private final List<Book> wishlist;
    private final List<Book> collection;
    private final List<Advertisement> advertisements;
    private Photo photo;

    /**
     * The constructor of User.
     * @param name The nickname of the user.
     * @param email The email address of the user.
     * @param photo The optional image of the user.
     */
    public User(String name, String email, Photo photo) {
        this.name = name;
        this.email = email;
        this.photo = photo;
        this.wishlist = new ArrayList<>();
        this.collection = new ArrayList<>();
        this.advertisements = new ArrayList<>();
    }

    /**
     * Returns the nickname of the user.
     * @return The nickname of the user.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the new nickname of the user.
     * @param name New nickmane of the user.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Returns the email of the user.
     * @return The email of the user.
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets new email of the user.
     * @param email New email of the user.
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Returns the photo of the user.
     * @return The photo of the user.
     */
    public Photo getPhoto() {
        return photo;
    }

    /**
     * Sets new photo of the user.
     * @param photo New photo of the user.
     */
    public void setPhoto(Photo photo) {
        this.photo = photo;
    }

    /**
     * Adds a new book to the wishlist of the user.
     * @param book New wished book.
     */
    public void addWishlist(Book book) {
        this.wishlist.add(book);
    }

    /**
     * Adds a new book to the collection of the user.
     * @param book New owned book.
     */
    public void addCollection(Book book) {
        this.collection.add(book);
    }

    /**
     * Adds a new advertisement, created by the user.
     * @param advertisement New advertisement
     */
    public void addAdvetisement(Advertisement advertisement) {
        this.advertisements.add(advertisement);
    }

    /**
     * It generates a string formed by the most significant informations of the user.
     * @return string.
     */
    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", email='" + email +
                '}';
    }
}
