import List "mo:base/List";

module Actor {
  public type Command = {
      #initCommand: { value: Nat };
  };

  public type Event = {
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
};