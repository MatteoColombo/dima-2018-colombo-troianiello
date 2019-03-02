package it.polimi.dima2018colombo_troianiello.model;
import java.util.ArrayList;
import java.util.List;

/**
 * @author AndreaTroianiello
 */
public class User {

    private String name;
    private String password;
    private String email;
    private List<User> friends;
    private List<Book> wishlist;
    private List<Book> collection;
    private List<Review> reviews;
    private List<Conversation> conversations;
    private List<Advertisement> advertisements;
    private Photo photo;

    /**
     * The constructor of User.
     * @param name The nickname of the user.
     * @param password The password of the user.
     * @param email The email address of the user.
     * @param photo The optional image of the user.
     */
    public User(String name, String password, String email, Photo photo) {
        this.name = name;
        this.password = password;
        this.email = email;
        this.photo = photo;
        this.friends = new ArrayList<>();
        this.wishlist = new ArrayList<>();
        this.collection = new ArrayList<>();
        this.reviews = new ArrayList<>();
        this.conversations = new ArrayList<>();
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
     * Returns the password of the user.
     * @return The password of the user.
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets new password of the user
     * @param password New password of the user.
     */
    public void setPassword(String password) {
        this.password = password;
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
     * It generates a string formed by the most significant informations of the user.
     * @return string.
     */
    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email +
                '}';
    }
}
