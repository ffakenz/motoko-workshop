import TrieMap "mo:base/TrieMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Text "mo:base/Text";
import User "../user/User";
import Types "./Types";
import Option "mo:base/Option";


module ActorRepositoryModule {
    public func empty<Actor>(): ActorRepository<Actor> {
        return ActorRepository<Actor>();
    };
};
class ActorRepository<Actor>() {

    var idToActor : TrieMap.TrieMap<Principal,Actor> = 
    TrieMap.TrieMap<Principal,Actor>(
        Principal.equal, 
        Principal.hash
    );

    var nameToId : TrieMap.TrieMap<Text,Principal> = 
    TrieMap.TrieMap<Text,Principal>(
        Text.equal, 
        Text.hash
    );

    public func create(name: Text, given: (Principal, Actor)): Actor {
        func spawnEffect(): Actor {
            let (principal, actorRef) = given;
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


    public func find(name: Text): ?Actor {
        return Option.chain<Principal, Actor>(
            nameToId.get(name), 
            func (id) { return idToActor.get(id); }
        );
    };
};
