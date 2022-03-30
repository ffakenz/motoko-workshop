
module Types {

    public type Other<A, Then> = {
        iPromiseToUseYourCallback: Callback<A, Then> -> Then
    };

    public type Callback<A, Then> = {
      callback: A -> Then
    };

    public type Builder<A> = {
        build: () -> A
    }
}
