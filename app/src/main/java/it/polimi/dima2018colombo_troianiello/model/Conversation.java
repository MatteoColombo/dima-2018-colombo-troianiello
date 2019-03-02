package it.polimi.dima2018colombo_troianiello.model;

import java.util.ArrayList;
import java.util.List;

/**
 * @author AndreaTroianiello
 */
public class Conversation {

    private final User users [];
    private final List<Message> messages;

    /**
     * The constructor of Conversation.
     * @param user1 First participant of the conversation.
     * @param user2 Second participant of the conversation.
     */
    public Conversation(User user1, User user2) {
        this.users = new User[2];
        this.users[0] = user1;
        this.users[1] = user2;
        this.messages = new ArrayList<>();
    }

    /**
     * Returns the list of all participants of the conversation.
     * @return Participants of the conversation.
     */
    public User[] getUsers() {
        return users;
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
