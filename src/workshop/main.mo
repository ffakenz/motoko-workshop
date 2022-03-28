import List "mo:base/List";
import Actor "./common/actor";
import Program "program";

actor Main {
    private stable var state: Actor.State<Program.Entity, Program.Event> = Program.state.init(0);

    // dfx canister call workshop action "(variant { initCommand = record { value = 0 } } )"
    public func action(cmd: Program.Command): async ?Actor.State<Program.Entity, Program.Event> {
      if (not Program.state.check(state, cmd)) {
          return null;
      };
      let events = Program.commandEvents(cmd);
      state := Program.state.applyAll(state, events);
      return ?state;
    };
};