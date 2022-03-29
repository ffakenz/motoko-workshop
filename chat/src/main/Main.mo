

import User "../user/User";
import Types "../types/Types";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import List "mo:base/List";
import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import ActorMapClass "../common/Sharding";
import Builder "../common/Types";

actor Main {

  public func createUser(memberId: Types.MemberId): async () {
    func factory(): async (Principal, User.User) { 
      let ref = await User.User(memberId);
      let principal = Principal.fromActor(ref);
      Debug.print("[Main][createUser]: memberPrincipal: " # Principal.toText(principal));
      return (principal, ref);
    };
    //let chatSpawner = ActorMapClass<User.User> { build = func() { 
    //   return await factory(); 
    //  }; 
    //};

  };


};
