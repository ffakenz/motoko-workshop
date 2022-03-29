import Actor "./common/actor";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";

module Program {
  public type Entity = Nat; // business logic

  public type Command = {
      #initCommand: {value: Entity};
  };

  public type Event = {
      #initEvent: {value: Entity};
  };

  // start:private
  public func _init(entity: Entity): Actor.State<Entity, Event> {
    Debug.print "init";
    return Actor.initState(entity);
  };

  private func _check(state: Actor.State<Entity, Event>, cmd: Command): Bool { 
    Debug.print "cmd check";
    return switch cmd {
      case (#initCommand({value: Entity})) {
        return value > state.entity; // business logic
      }
    };
  };

  private func _apply(state: Actor.State<Entity, Event>, evt: Event): Actor.State<Entity, Event> { 
    Debug.print "evt apply";
    return switch evt {
      case (#initEvent({value: Entity})) {
        let _state: Actor.State<Entity, Event> = {
          entity = state.entity + value; // bussiness logic
          events = List.push(evt, state.events);
        };
        return _state;
      };
    };
  };

  private func _applyAll(state: Actor.State<Entity, Event>, evts: List.List<Event>): Actor.State<Entity, Event> { 
    Debug.print "evts applyAll";
    return List.foldLeft(evts, state, _apply);
  };
  // end:private

  // start:public
  public let state: Actor.StateOps<Entity, Event, Command> = {
    init = _init;
    check = _check;
    apply = _apply;
    applyAll = _applyAll;
  };

  public func commandEvents(cmd: Command): List.List<Event> {
    return switch cmd {
      case (#initCommand({value: Entity})) {
        let event = #initEvent({value = value + 1}); // business logic
        let events = List.push(event, List.nil());
        return events;
      };
    };
  };
  // end:public
};