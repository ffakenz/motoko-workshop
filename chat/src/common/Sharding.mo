import Principal "mo:base/Principal";

module Sharding {

   type ActorFactory<ActorRequirements> {
       build: ActorRequirements -> actor
   }

   func spawn<ActorRequirements>
   (a: ActorFactory<ActorRequirements>)
   (b: ActorRequirements)
   : async (Principal, actor) = {
       let actorRef = await a(b)
       (
           Principal.fromActor(actorRef),
           actorRef
       )
   }:


    class ActorMap<ActorRequirements>(factory: ActorFactory<ActorRequirements>) {

        var idToActor : TrieMap.TrieMap<Principal,actor> = 
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

        func get(name: Text): async actor = {
            
            func spawnEffect(): actor = {
                let (principal, actorRef) = Sharding.spawn(factory)(id);
                idToActor.put(principal, actorRef);
                nameToId.put(name, principal);
                return actorRef;
            }
            
            switch nameToId.get(name) {
                case (?id) {
                    switch idToActor.get(id) {
                        case null {
                            return spawnEffect();
                        }
                        case (?actorRef) {
                            return actorRef;
                        }
                    }
                };
                case null {
                    return spawnEffect();
                };
            }
            
        };

    }
}