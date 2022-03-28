import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Bool "mo:base/Bool";
import List "mo:base/List";
import Option "mo:base/Option";
import Actor "actor";

actor Program {
    // start:private
    private stable var state: Actor.State<Nat> = { 
        value = 0;
        events = null;
    };
    
     // @TODO
    private var stateOps: Actor.StateOps<Nat> = {
        check = func(cmd: Actor.Command, state: Actor.State<Nat>): Bool { 
            Debug.print "cmd check";
            return switch cmd {
                case (#initCommand({value: Nat})) {
                  if(value > state.value) {
                    false;
                  }
                  else {
                    true;
                  }
                }
            };
        };
        apply = func(evt: Actor.Event, state: Actor.State<Nat>): Actor.State<Nat> { 
            Debug.print "evt apply";
            let st: Actor.State<Nat> = switch evt {
              case (#initEvent({value: Nat})) {
                { 
                  value = value;
                  events = List.push(evt, state.events);
                };
              };
            };
            return st;
        };
    };
    // end:private

    // start:public
    // dfx canister call workshop action "(variant { initCommand = record { value = 0 } } )"
    public func action(cmd: Actor.Command): async ?Actor.State<Nat> {
        if (not stateOps.check(cmd, state)) {
            return null;
        };
        let event = switch cmd {
          case (#initCommand({value: Nat})) {
            #initEvent({value = value + 1});
          };
        };
        state := stateOps.apply(event, state);
        return ?state;
    };
    // end:public
}