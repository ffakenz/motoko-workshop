import Types "../types/Types";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";



actor class User(
  name: Text
) {

  var chats : [Types.Chat] = [];

  public func receiveMessage(message: Types.Message): async () { // member interface
      Debug.print("[User][receiveMessage]: message.from: " # message.from.name);
      Debug.print("[User][receiveMessage]: message.content: " # message.content);
  };
  

  public func addChat(chat: Types.Chat): async () { // member interface
      Debug.print("[User][addChatRef]: " # name);
      chats := Array.append<Types.Chat>(chats, [chat]);
  };


  public shared query func getVersion() : async Text {
    return "v1"
  };

  public shared query func getChats() : async [Types.Chat] {
    return chats
  };

};
