


import Types "../types/Types";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import List "mo:base/List";
import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import ActorRepository "../common/ActorRepository";
import Builder "../common/Types";
import Option "mo:base/Option";

import User "../user/User";
import Chat "../chat/Chat";

actor Main {

 type User = User.User;
 type Chat = Chat.Chat;
 let ActorRepositoryModule = ActorRepository.ActorRepositoryModule;
 let users = ActorRepositoryModule.empty<User>();
 let chats = ActorRepositoryModule.empty<Chat>();

  // User.createUser
  public func createUser(name: Text): async User {
    let ref = await User.User(name);
    let principal = Principal.fromActor(ref);
    Debug.print("[Main][createUser]: memberPrincipal: " # Principal.toText(principal));
    return users.create(name, (principal, ref));
  };

  // User.addChat
  public func addChat(name: Text, chat: Types.Chat): async () {
    Debug.print("[Main][addChat]: " );
    switch (users.find(name)) {
      case null ();
      case (?userRef) await userRef.addChat(chat);
    };
  };

  // User.getChats
  public func getChats(name: Text): async [Types.Chat] {
    Debug.print("[Main][getChats]: " );
    return (switch (users.find(name)) {
      case null [];
      case (?userRef) await userRef.getChats();
    });
  };

  // Chat.addMember
  public func addMember(chat: Text, user: Text): async () {
    Debug.print("[Main][addMember]: " );
    switch (chats.find(chat)) {
      case null ();
      case (?chatRef) {
        switch (users.find(user)) {
          case null ();
          case (?userRef) await chatRef.addMember(user, userRef);
        };
      };
    };
  };

  // Chat.sendMessage
  public func sendMessage(chat: Text, message: Types.Message): async () {
    Debug.print("[Main][sendMessage]: " );
    switch (chats.find(chat)) {
      case null ();
      case (?chatRef) {
        chatRef.sendMessage(message);
      };
    };
  };


  // Chat.getMessages
  public func getMessages(chat: Text): async [Types.Message] {
    Debug.print("[Main][getMessages]: " );
    return (switch (chats.find(chat)) {
      case null [];
      case (?chatRef) {
        await chatRef.getMessages();
      };
    });
  };

    // Chat.getMembers
  public func getMembers(chat: Text): async [Text] {
    Debug.print("[Main][getMembers]: " );
    return (switch (chats.find(chat)) {
      case null [];
      case (?chatRef) {
        await chatRef.getMembers();
      };
    });
  };


};
