import Types "../types/Types";
import Array "mo:base/Array";
import TrieMap "mo:base/TrieMap";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Debug "mo:base/Debug";
import Text "mo:base/Text";

actor class Chat(
  id: Types.Chat,
  owner: Types.Member
) {


  type TrieMap<K, V> = TrieMap.TrieMap<K, V>;
  type List<A> = List.List<A>;
    
  var messages : List<Types.Message> = List.nil();
  var members : TrieMap<Text,Types.MemberRef> = TrieMap.fromEntries(Iter.fromList(List.nil()), Text.equal, Text.hash);

  public func addMember(member : Text, memberRef: Types.MemberRef): async () {
    Debug.print("[Chat][addMember]: " # member);
    await memberRef.addChat(id);
    members.put(member, memberRef);
  };

  public func sendMessage(message : Types.Message) {
      Debug.print("[Chat][sendMessage]: message.from: " # message.from.name);
      Debug.print("[Chat][sendMessage]: message.content: " # message.content);
      for (member in members.keys()) {
        if (message.from.name == member) {
          Debug.print("[Chat][sendMessage].b: Member is valid: " # member);
          messages := List.push(message, messages); //RBAC
          for (receiver in members.entries()) {
            if (message.from.name != receiver.0) {
              Debug.print("[Chat][sendMessage].b: Sending message to " # receiver.0);
              await receiver.1.receiveMessage(message);
            };
          };
        };
      };  
  };

  public shared query func getMessages() : async [Types.Message] {
    return List.toArray(messages);
  };
  public shared query func getMembers() : async [Text] { // TODO change return type to [MemberId]
    return Iter.toArray(members.keys());
  };

};
