package it.polimi.dima2018colombo_troianiello.model;

import java.util.ArrayList;
import java.util.List;

/**
 * @author AndreaTroianiello
 */
public class Conversation {

    private List<User> users;
    private List<Message> messages;

    /**
     * The constructor of Conversation.
     */
    public Conversation() {
        this.users = new ArrayList<>();
        this.messages = new ArrayList<>();
    }

    /**
     * Returns the list of all participants of the conversation.
     * @return Participants of the conversation.
     */
    public List<User> getUsers() {
        return users;
    }

    /**
     * Add a new user to the conversation.
     * @param user New user.
     */
    public void addUser(User user) {
        this.users.add(user);
    }

    /**
     * Returns the list of all messages.
     * @return List of messages
     */
    public List<Message> getMessages() {
        return messages;
    }

    /**
     * Add a new message.
     * @param message New message.
     */
    public void addMessage(Message message) {
        this.messages.add(message);
    }
}
