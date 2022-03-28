import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Bool "mo:base/Bool";
import List "mo:base/List";
import Option "mo:base/Option";

actor Program {
    // start:modules
    type Command = {
        #initCommand: { value: Nat };
    };

    type Event = {
        #initEvent: { value: Nat };
    };

    public type State<A> = {
        value: A;
        events: List.List<Event>;
    };
    
    public type StateOps<A> = {
        check: (Command, State<A>) -> Bool; // check commands
        apply: (Event, State<A>) -> State<A>; // apply events
    };
    // end:modules

    // start:private
    private stable var state: State<Nat> = { 
        value = 0;
        events = null;
    };
    
     // @TODO
    private var stateOps: StateOps<Nat> = {
        check = func(cmd: Command, state: State<Nat>): Bool { 
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
        apply = func(evt: Event, state: State<Nat>): State<Nat> { 
            Debug.print "evt apply";
            let st: State<Nat> = switch evt {
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
    public func action(cmd: Command): async ?State<Nat> {
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