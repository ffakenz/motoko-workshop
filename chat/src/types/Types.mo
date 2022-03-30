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
        addMember: (Member, MemberRef) -> async (); 
        getMembers: query () -> async [Member];
        getMessages: query () -> async [Message];
    };


    public type MemberRef = actor {
        receiveMessage:  Message -> async ();
        addChat: Chat -> async (); 
        getChats: query () -> async [Chat];
    };
    

}