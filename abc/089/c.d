import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

T[][] comb(T)(in T[] arr, in int k) pure nothrow {
    if (k == 0) return [[]];
    typeof(return) result;
    foreach (immutable i, immutable x; arr)
        foreach (suffix; arr[i + 1 .. $].comb(k - 1))
            result ~= x ~ suffix;
    return result;
}

int N;
string[10^^5] SS;

void main()
{
    N = readln.chomp.to!int;
    foreach (i; 0..N) SS[i] = readln.chomp;

    long[5] march;
    foreach (s; SS[0..N]) {
        switch (s[0]) {
            case 'M': ++march[0]; break;
            case 'A': ++march[1]; break;
            case 'R': ++march[2]; break;
            case 'C': ++march[3]; break;
            case 'H': ++march[4]; break;
            default:
        }
    }

    auto cb = [0, 1, 2, 3, 4].comb(3);
    long ret;
    foreach (c; cb) ret += march[c[0]] * march[c[1]] * march[c[2]];
    writeln(ret);
}