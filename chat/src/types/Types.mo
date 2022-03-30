import Principal "mo:base/Principal";

module Types {

    public type Chat = {
        name : Text;
    };

    public type Member = {
        name : Text;
    };

    public type Message = {
        from: Member;
        content : Text;
    };

     public type ChatRef = actor {
        sendMessage: Message -> async ();
        addMember: (Types.MemberId, Types.MemberRef) -> async (); 
        getMembers: query () -> async [Principal];
        getMessages: query () -> async [Types.Message];
    };
    public type MemberRef = actor {
        receiveMessage: Message -> async ();
        addChatId: ChatId -> async (); 
        getChats: query () -> async [Principal];
    };
    

}