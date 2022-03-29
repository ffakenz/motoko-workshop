import Types "../types/Types";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";



actor class User(
  id : Types.MemberId
) {

  var chats : [Types.ChatId] = [];

  public func receiveMessage(message: Types.Message): async () { // member interface
      Debug.print("[User][receiveMessage]: message.from: " # Principal.toText(message.from));
      Debug.print("[User][receiveMessage]: message.content: " # message.content);
  };
  

  public func addChatId(chatId: Types.ChatId): async () { // member interface
      Debug.print("[User][addChatRef]: " # Principal.toText(chatId.id));
      chats := Array.append<Types.ChatId>(chats, [chatId]);
  };

  public shared query func getChats() : async [Types.ChatId] {
    return chats
  };

};
