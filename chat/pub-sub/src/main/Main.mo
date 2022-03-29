import User "../user/User";
import Chat "../chat/Chat";
import Types "../types/Types";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import List "mo:base/List";
import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";

actor Main {

  var users : TrieMap.TrieMap<Text,Types.MemberRef> = TrieMap.fromEntries(Iter.fromList(List.nil()), Text.equal, Text.hash);
  var chatRooms : TrieMap.TrieMap<Text,Types.ChatRef> = TrieMap.fromEntries(Iter.fromList(List.nil()), Text.equal, Text.hash);

  public func createUser(memberId: Types.MemberId): async () {
    Debug.print("[Main][createUser]: memberId: " # memberId.id);
    let memberRef: Types.MemberRef = await User.User(memberId); 
    users.put(memberId.id, memberRef);
    let memberPrincipal: Principal = await memberRef.id();
    let memberPrincipalFromActor: Principal = Principal.fromActor(memberRef);
    Debug.print("[Main][createUser]: memberPrincipal: " # Principal.toText(memberPrincipal));
    Debug.print("[Main][createUser]: memberPrincipalFromActor: " # Principal.toText(memberPrincipalFromActor));
  };

/*

  public func createChat(chatId: Types.ChatId, owner: Types.MemberId): async () {
    Debug.print("[Main][createChat]: chatId: " # chatId.id);
    let chatRef: Types.ChatRef = await Chat.Chat(chatId, owner); // dynamically install a new Chat
    chatRooms.put(chatId.id, chatRef);
    
    let found = users.get(owner);
    switch found {
      case null { 
        return ();
      };
      case (?userRef) {
        await userRef.addChatId(chatId);
        chatRooms.put(chatId.id, chatRef);
        return ()
      };
    };

  }; */



/*
  public func addMember(memberId: Types.MemberId, memberRef: Types.MemberRef): async () {
    Debug.print("[Main][createUser]: memberId: " # memberId.id);
    let memberRef: Types.MemberRef = await User.User(memberId); // dynamically install a new User
    users.put(memberId.id, memberRef);
  }; */

  // sendMessage: Message -> async ();
  /*public func sendMessage(memberId: Types.MemberId): async () {
    Debug.print("[Main][sendMessage]: memberId: " # memberId.id);
    chatRooms
    let memberRef: Types.MemberRef = await User.User(memberId); // dynamically install a new User
    users.put(memberId.id, memberRef);
  };

  */

  public shared query func getMembers() : async [Text] { // TODO change return type to [MemberId]
    return Iter.toArray(users.keys());
  };

  // getChats: query () -> async [Types.ChatId];
  /* public shared query func getChatRooms() : async [Text] { // TODO change return type to [MemberId]
    return Iter.toArray(chatRooms.keys());
  }; */

};
