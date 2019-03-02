package it.polimi.dima2018colombo_troianiello.model;

import java.util.Date;

/**
 * @author AndreaTroianiello
 */
public class Message {
    private final Date date;
    private final String content;
    private final User sender;
    private final User receiver;

    /**
     * The constructor of Message.
     * @param date The date when the message is sent.
     * @param content The content of the message.
     * @param sender The user that sends the message.
     * @param receiver The user that receives the message.
     */
    public Message(Date date, String content, User sender, User receiver) {
        this.date = date;
        this.content = content;
        this.sender = sender;
        this.receiver = receiver;
    }

    /**
     * Returns the date when the message is sent.
     * @return The date when the message is sent.
     */
    public Date getDate() {
        return date;
    }

    /**
     * Returns the content of the message.
     * @return The content of the message.
     */
    public String getContent() {
        return content;
    }

    /**
     * Returns the user that sends the message.
     * @return The user that sends the message.
     */
    public User getSender() {
        return sender;
    }

    /**
     * Returns the user that receives the message.
     * @return The user that receives the message.
     */
    public User getReceiver() {
        return receiver;
    }
}
