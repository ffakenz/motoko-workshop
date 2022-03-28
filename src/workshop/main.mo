import Actor "./common/actor";
import Program "program";

actor Main {
    private stable var state: Actor.State<Nat, Program.Event> = Program.stateOps.init();

    // dfx canister call workshop action "(variant { initCommand = record { value = 0 } } )"
    public func action(cmd: Program.Command): async ?Actor.State<Nat, Program.Event> {
        if (not Program.stateOps.check(cmd, state)) {
            return null;
        };
        let event = switch cmd {
          case (#initCommand({value: Nat})) {
            #initEvent({value = value + 1});
          };
        };
        state := Program.stateOps.apply(event, state);
        return ?state;
    };
};