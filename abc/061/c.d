import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

alias Pair = Tuple!(int, "a", int, "b");
Pair[10^^5+1] ARRAY;

void main()
{
    int n;
    long k;
    readf("%d %d", &n, &k); readln;
    auto array = ARRAY[0..n];

    foreach (i; 0..n) {
        int a, b;
        readf("%d %d", &a, &b); readln;
        array[i] = tuple(a, b);
    }

    array.sort!"a.a < b.a";
    long i;
    foreach (ab; array) {
        i += ab.b;
        if (i >= k) {
            writeln(ab.a);
            break;
        }
    }
}