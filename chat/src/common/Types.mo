import TrieMap "mo:base/TrieMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Text "mo:base/Text";
import User "../user/User";
import ActorMapClass "./Sharding";


type Builder<A> = {
    build: () -> A
}
