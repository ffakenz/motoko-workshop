import TrieMap "mo:base/TrieMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Text "mo:base/Text";
import User "../user/User";
import Builder "./Types";




class ActorMapClass<Actor>(
    actorFactory: Builder<(Principal, Actor)>
) {

    var idToActor : TrieMap.TrieMap<Principal,Actor> = 
    TrieMap.fromEntries(
        Iter.fromList(
            List.nil()
        ), 
        Principal.equal, 
        Principal.hash
    );

    var nameToId : TrieMap.TrieMap<Text,Principal> = 
    TrieMap.fromEntries(
        Iter.fromList(
            List.nil()
        ), 
        Text.equal, 
        Text.hash
    );

    public func create(name: Text): Actor {
        func spawnEffect(): Actor {
            let (principal, actorRef) = actorFactory.build();
            idToActor.put(principal, actorRef);
            nameToId.put(name, principal);
            return actorRef;
        };
        switch (nameToId.get(name)) {
            case (?id) {
                switch (idToActor.get(id)) {
                    case null { return spawnEffect(); };
                    case (?actorRef) { return actorRef; };
                };
            };
            case null { return spawnEffect(); };
        }
    };
};
