import Actor "./common/actor";
import List "mo:base/List";
import Debug "mo:base/Debug";

module Program {
  public type Command = {
      #initCommand: {value: Nat};
  };

  public type Event = {
      #initEvent: {value: Nat};
  };

  private func init(): Actor.State<Nat, Event> {
    return {
      value = 0;
      events = null;
    }
  };

  private func check(cmd: Command, state: Actor.State<Nat, Event>): Bool { 
    Debug.print "cmd check";
    return 
      switch cmd {
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

  private func apply(evt: Event, state: Actor.State<Nat, Event>): Actor.State<Nat, Event> { 
    Debug.print "evt apply";
    let st: Actor.State<Nat, Event> = switch evt {
      case (#initEvent({value: Nat})) {
        { 
          value = value;
          events = List.push(evt, state.events);
        };
      };
    };
    return st;
  };
  
  public let stateOps: Actor.StateOps<Nat, Event, Command> = {
    init = init;
    check = check;
    apply = apply;
  };
};