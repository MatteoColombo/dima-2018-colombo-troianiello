package it.polimi.dima2018colombo_troianiello.model;

/**
 * @author AndreaTroianiello
 */
public class Review {

    private final String id;
    private int vote;
    private String comment;
    private final User user;
    private final Book book;

    /**
     * The constructor of the Review.
     * @param id Identifier of the Review.
     * @param vote Vote of the user.
     * @param comment Comment of the user.
     * @param user User who makes the Review.
     * @param book Book reviewed by the User.
     */
    public Review(String id, int vote, String comment, User user, Book book) {
        this.id = id;
        this.vote = vote;
        this.comment = comment;
        this.user = user;
        this.book = book;
    }

    /**
     * Returns the identifier of the Review.
     * @return Identifier.
     */
    public String getId() {
        return id;
    }

    /**
     * Returns the vote of the user.
     * @return The voto of the user.
     */
    public int getVote() {
        return vote;
    }

    /**
     * Sets a new vote made by the user.
     * @param vote New vote.
     */
    public void setVote(int vote) {
        this.vote = vote;
    }

    /**
     * Returns the comment made by the user.
     * @return Comment of the user.
     */
    public String getComment() {
        return comment;
    }

    /**
     * Sets the new comment of the user.
     * @param comment New comment.
     */
    public void setComment(String comment) {
        this.comment = comment;
    }

    /**
     * Returns the user of the Review.
     * @return User of the Review.
     */
    public User getUser() {
        return user;
    }

    /**
     * Returns the reviewed book.
     * @return Reviewed book.
     */
    public Book getBook() {
        return book;
    }

    /**
     * It generates a string formed by the most significant informations of the review.
     * @return string.
     */
    @Override
    public String toString() {
        return "Review{" +
                "id='" + id + '\'' +
                ", vote=" + vote +
                ", comment='" + comment + '\'' +
                ", user=" + user.getName() +
                ", book=" + book.getTitle() +
                '}';
    }
}
